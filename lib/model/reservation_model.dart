import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationModel {
  DateTime checkIn;
  DateTime checkOut;
  String docId;
  DocumentReference user;
  DocumentReference stand;
  bool isReview;


  ReservationModel({
    required this.user,
    required this.stand,
    required this.checkIn,
    required this.checkOut,
    required this.docId,
    required this.isReview
  });

  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    DateTime checkIn = (map['checkIn'] as Timestamp).toDate();
    DateTime checkOut = (map['checkOut'] as Timestamp).toDate();
    return ReservationModel(
      user: map['user'],
      stand: map['stand'],
      checkIn: DateTime(checkIn.year, checkIn.month, checkIn.day),
      checkOut: DateTime(checkOut.year, checkOut.month, checkOut.day),
      docId: map['docId'] ?? '',
      isReview: map['isReview']

    );
  }

  Map<String, dynamic> toMap() {
    return {
      "user": user,
      "stand": stand,
      "checkIn": checkIn,
      "checkOut": checkOut,
      "isReview": isReview
    };
  }

  @override
  String toString() {
    return 'ReservationModel{userId: $user, standId: $stand, checkIn: $checkIn, checkOut: $checkOut, docId: $docId , isReview: $isReview}';
  }
}
