import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_fish/app/app_setup.router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;

import '../app/app_setup.locator.dart';
import '../model/city_model.dart';
import '../model/facility_model.dart';
import '../model/pond_model.dart';
import '../model/reservation_model.dart';
import '../model/review_model.dart';
import '../model/stand_model.dart';
import '../model/user_model.dart';

class FirebaseService extends ChangeNotifier {
  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _uid;

  String get uid => _uid!;

  UserModel? _userModel;

  UserModel get userModel => _userModel!;

  final NavigationService _navigationService = locator<NavigationService>();
  late final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  FirebaseService() {
    checkSign();
    _firebaseAuth = FirebaseAuth.instance;
  }

  void checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    // notifyListeners();
  }

  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid;
    // notifyListeners();
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    _userModel = null;
    s.clear();
  }

  void signInWithPhone(String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          //timeout: Duration(seconds: 60),
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            _navigationService.replaceWith(Routes.otpView,
                arguments: OtpViewArguments(
                    verificationId: verificationId, phoneNumber: phoneNumber));
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
    }
  }

  void verifyOtp({
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    // notifyListeners();

    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;

      if (user != null) {
        // carry our logic
        _uid = user.phoneNumber;
        onSuccess();
      }
      _isLoading = false;
      // notifyListeners();
    } on FirebaseAuthException catch (e) {
      // showSnackBar( e.message.toString());
      _isLoading = false;
      print(e.message);
      // notifyListeners();
    }
  }

  Future<bool> checkExistingUser() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firebaseFirestore
        .collection("users")
        .where('uid', isEqualTo: _uid)
        .get();
    print(
        "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    // print(snapshot.docs)
    // print(snapshot.docs[0].data());

    if (snapshot.size != 0) {
      print("USER EXISTS");
      _userModel = UserModel.fromMap(snapshot.docs[0].data());
      _userModel?.docId = snapshot.docs[0].id;
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }

  Future getDataFromFirestore() async {
    await _firebaseFirestore
        .collection("users")
        .doc(_userModel?.docId)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
          name: snapshot['name'],
          email: snapshot['email'],
          createdAt: snapshot['createdAt'],
          address: snapshot['address'],
          uid: snapshot['uid'],
          profilePic: snapshot['profilePic'],
          phoneNumber: snapshot['phoneNumber'],
          docId: snapshot.id);
      _uid = userModel.uid;
    });
  }

  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    // notifyListeners();
  }

  Future<List<PondModel>> getPond(
      CityModel city, DateTime checkIn, DateTime checkOut) async {
    List<PondModel> ponds = [];
    List<String> freestands = [];

    var resRef = FirebaseFirestore.instance.collection('Reservation');
    var snapshot = await resRef.get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshot.docs;
    docs.sort((a, b) {
      var checkInA = (a.data()['checkOut'] as Timestamp).toDate();
      var checkInB = (b.data()['checkOut'] as Timestamp).toDate();

      return checkInA.compareTo(checkInB);
    });

    for (var element in docs) {
      var res = ReservationModel.fromMap(element.data());

      var userRef = element.data()['user'];
      var standRef = element.data()['stand'];

      var userSnap = await userRef.get();
      var standSnap = await standRef.get();

      var user = UserModel.fromMap(userSnap.data());
      user.docId = userSnap.id;

      var stand = StandModel.fromJson(standSnap.data());
      stand.docId = standSnap.id;

      if ((res.checkIn.isBefore(checkIn) && (checkIn.isBefore(res.checkOut))) ||
          (res.checkIn.isBefore(checkOut) && checkOut.isBefore(res.checkOut)) ||
          (checkIn.isBefore(res.checkIn) && res.checkIn.isBefore(checkOut)) ||
          (checkIn.isBefore(res.checkOut) && res.checkOut.isBefore(checkOut)) ||
          (res.checkIn.isAtSameMomentAs(checkIn) &&
              res.checkOut.isAtSameMomentAs(checkOut))) {
        freestands.add(standSnap.id);
      }
    }

    var pondIds = [];
    var standRef = FirebaseFirestore.instance.collection('Stand');
    var snapshotStand = await standRef.get();
    for (var element in snapshotStand.docs) {
      if (!(freestands.contains(element.id))) {
        var pondRef = element.data()["pond"];
        var pondSnap = await pondRef.get();
        pondIds.add(pondSnap.id); //Json al meu
      }
    }

    var pondRef = FirebaseFirestore.instance.collection('Balta');
    var snapshotPond = await pondRef.get();

    for (var element in snapshotPond.docs) {
      var pond = PondModel.fromJson(element.data());
      pond.docId = element.id;

      var cityRef = element.data()['city'];
      var citySnap = await cityRef.get();
      var city2 = CityModel.fromJson(citySnap.data());
      city2.docId = citySnap.id;
      // pond.city = city2;

      var facilityRefList = element.data()['facilities'];
      var reviewsRefList = element.data()['reviews'];

      for (var facilityRef in facilityRefList) {
        var facSnap = await facilityRef.get();
        pond.facilities.add(FacilityModel.fromJson(facSnap));
      }
      for (var reviewsRef in reviewsRefList) {
        dynamic revSnap = await reviewsRef.get();
        pond.reviews.add(ReviewModel.fromJson(revSnap));
      }
      if ((pondIds.contains(pond.docId) && isPondInCity(pond, city))) {
        ponds.add(pond);
      }
    }
    return ponds;
  }

  bool isPondInCity(PondModel pondModel, CityModel city) {
    var cityRef =
        FirebaseFirestore.instance.collection("Orase").doc(city.docId);
    return cityRef == pondModel.city;
  }

  addReservation(
      PondModel pondModel, DateTime checkIn, DateTime checkOut) async {
    var stand = await getFirstFreeStand(pondModel, checkIn, checkOut);
    var user =
        FirebaseFirestore.instance.collection("users").doc(userModel.docId);
    ReservationModel reservationModel = ReservationModel(
      user: user,
      stand: stand,
      docId: '',
      checkIn: checkIn,
      checkOut: checkOut,
      isReview: false,
    );

    try {
      // uploading to database
      await _firebaseFirestore
          .collection("Reservation")
          .add(reservationModel.toMap())
          .then((value) async {
        PondModel? pondModel = await getPondByStand(reservationModel.stand);
        sendEmail(
            pondModel!.name_owner,
            pondModel!.emailAddress,
            userModel.name,
            "${reservationModel.checkIn}-${reservationModel.checkOut}",
            pondModel!.name,
            userModel.phoneNumber);
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  addReview(ReviewModel reviewModel, PondModel pondModel,
      ReservationModel reservationModel) async {
    try {
      // uploading to database
      await _firebaseFirestore
          .collection("Review")
          .add(reviewModel.toJson())
          .then((DocumentReference doc) async {
        var list = [doc];
        list.add(doc);
        await _firebaseFirestore
            .collection("Balta")
            .doc(pondModel.docId)
            .update({"reviews": FieldValue.arrayUnion(list)}).then(
                (value) => {});
      });

      await _firebaseFirestore
          .collection("Reservation")
          .doc(reservationModel.docId)
          .update({"isReview": true}).then((value) => {});
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<UserModel> getUserReview(DocumentReference documentReference) async {
    var snapshot = await documentReference.get();
    UserModel userModel =
        UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
    userModel.docId = snapshot.id;

    return userModel;
  }

  Future getFirstFreeStand(
      PondModel pondModel, DateTime checkIn, DateTime checkOut) async {
    var pondRef =
        FirebaseFirestore.instance.collection('Balta').doc(pondModel.docId);

    var standRef = FirebaseFirestore.instance
        .collection('Stand')
        .where("pond", isEqualTo: pondRef);
    var standSnap = await standRef.get();

    var standIdsInPond = [];

    for (var element in standSnap.docs) {
      standIdsInPond.add(element);
    }

    var freestands = [];

    for (var pondStand in standIdsInPond) {
      var resRef = FirebaseFirestore.instance
          .collection("Reservation")
          .where("stand", isEqualTo: pondStand.reference);

      var resSnap = await resRef.get();

      if (resSnap.size == 0) {
        return FirebaseFirestore.instance.collection("Stand").doc(pondStand.id);
      }

      for (var element in resSnap.docs) {
        var res = ReservationModel.fromMap(element.data());
        res.docId = element.id;
        var standSnap = await element.data()['stand'].get();
        var stand = StandModel.fromJson(standSnap.data());
        stand.docId = standSnap.id;

        var freeStandRef =
            FirebaseFirestore.instance.collection("Stand").doc(standSnap.id);

        if ((res.checkIn.isBefore(checkIn) &&
                (checkIn.isBefore(res.checkOut))) ||
            (res.checkIn.isBefore(checkOut) &&
                checkOut.isBefore(res.checkOut)) ||
            (checkIn.isBefore(res.checkIn) && res.checkIn.isBefore(checkOut)) ||
            (checkIn.isBefore(res.checkOut) &&
                res.checkOut.isBefore(checkOut)) ||
            (res.checkIn.isAtSameMomentAs(checkIn) &&
                res.checkOut.isAtSameMomentAs(checkOut))) {
          if (freestands.contains(freeStandRef)) {
            freestands.remove(freeStandRef);
          }
        } else {
          freestands.add(freeStandRef);
        }
      }
    }

    if (freestands.isNotEmpty) {
      return freestands[0];
    }
    return null;
  }

  Future<PondModel?> getPondByStand(DocumentReference documentReference) async {
    DocumentSnapshot snapshotStand = await documentReference.get();
    StandModel standModel =
        StandModel.fromJson(snapshotStand.data() as Map<String, dynamic>);
    standModel.docId = snapshotStand.id;
    var pondSnapshot = await standModel.pond?.get();
    if (pondSnapshot != null) {
      PondModel pondModel =
          PondModel.fromJson(pondSnapshot.data() as Map<String, dynamic>);
      pondModel.docId = pondSnapshot.id;
      return pondModel;
    }
    return null;
  }

  Future sendEmail(String name_owner, String emailAddress, String nume_client,
      String perioada, String nume_balta, String numar_telefon) async {
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    var serviceId = "service_n05spk4";
    var templateId = "template_qa66yzi";
    var userID = "XN2Isb08WHaemV2hQ";
    var respons = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userID,
          'template_params': {
            'name_owner': name_owner,
            'nume_balta': nume_balta,
            'perioada': perioada,
            'nume_client': nume_client,
            'numar_telefon': numar_telefon,
            'email_address': emailAddress,
            'name_owner': name_owner
          }
        }));
    print(respons.statusCode);
    print(respons.body);
  }

  Future sendEmailCancelReservation(
      String name_owner,
      String emailAddress,
      String nume_client,
      String perioada,
      String nume_balta,
      String numar_telefon) async {
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    var serviceId = "service_n05spk4";
    var templateId = "template_ztcr7x9";
    var userID = "XN2Isb08WHaemV2hQ";
    var respons = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userID,
          'template_params': {
            'name_owner': name_owner,
            'nume_balta': nume_balta,
            'perioada': perioada,
            'nume_client': nume_client,
            'numar_telefon': numar_telefon,
            'email_address': emailAddress
          }
        }));
    print(respons.statusCode);
    print(respons.body);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getReservation() {
    var userDoc =
        FirebaseFirestore.instance.collection("users").doc(userModel.docId);
    return FirebaseFirestore.instance
        .collection('Reservation')
        .where('user', isEqualTo: userDoc)
        .snapshots();
  }

  deleteReservation(String id) async {
    var res = await FirebaseFirestore.instance
        .collection("Reservation")
        .doc(id)
        .get();
    ReservationModel reservationModel = ReservationModel.fromMap(res.data()!);
    FirebaseFirestore.instance
        .collection('Reservation')
        .doc(id)
        .delete()
        .then((value) async {
      PondModel? pondModel = await getPondByStand(reservationModel.stand);
      sendEmailCancelReservation(
          pondModel!.name_owner,
          pondModel!.emailAddress,
          userModel.name,
          "${reservationModel.checkIn}-${reservationModel.checkOut}",
          pondModel!.name,
          userModel.phoneNumber);
    });
  }

  Future<StandModel> getStandById(DocumentReference documentReference) async {
    var snapshot = await documentReference.get();
    StandModel standModel =
        StandModel.fromJson(snapshot.data() as Map<String, dynamic>);
    standModel.docId = snapshot.id;
    return standModel;
  }

  DocumentReference<Map<String, dynamic>> getLoggedInUser() {
    return FirebaseFirestore.instance.collection("users").doc(userModel.docId);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPonds() {
    return FirebaseFirestore.instance.collection("Balta").snapshots();
  }

  void saveUserDataToFirebase({
    required UserModel userModel,
    required File profilePic,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
        userModel.profilePic = value;
        userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      });
      _userModel = userModel;

      // uploading to database
      DocumentReference documentReference =
          await _firebaseFirestore.collection("users").add(userModel.toMap());
      _userModel?.docId = documentReference.id;
      onSuccess();
      _isLoading = false;
      notifyListeners();
      // });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      _isLoading = false;
    }
  }

  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
