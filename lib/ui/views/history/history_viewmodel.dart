import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:new_fish/app/app_setup.router.dart';
import 'package:new_fish/model/reservation_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';
import '../../../model/pond_model.dart';
import '../../../model/stand_model.dart';
import '../../../services/firebase_service.dart';

enum Filter { upcoming, finished }

class HistoryViewModel extends BaseViewModel{

  final FirebaseService _firebaseService = locator<FirebaseService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final DialogService _dialogService = locator<DialogService>();

  Filter _filter = Filter.upcoming;
  Filter get filter => _filter;

  void setFilter(Filter filter) {
    _filter = filter;
    notifyListeners();
  }

  Future navigateToReview(ReservationModel reservationModel, PondModel pondModel) async {
    return await _navigationService.navigateTo(Routes.reviewView, arguments: ReviewViewArguments(reservationModel: reservationModel, pondModel: pondModel));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getReservation() {
    return _firebaseService.getReservation();
  }

  Future<PondModel?> getPondByStand(DocumentReference documentReference) async {
    return _firebaseService.getPondByStand(documentReference);
  }

  void deleteReservation(String id) async {
    _firebaseService.deleteReservation(id);
  }

  Future<StandModel> getStandById(DocumentReference documentReference) async {
    return _firebaseService.getStandById(documentReference);
  }

  void showSnackbarOnDelete() {
    _snackbarService.showSnackbar(
      message: 'Rezervare anulata cu succes',
      duration: const Duration(seconds: 4),
    );
  }

  void showDialogOnDelete() async {
    await _dialogService.showDialog(
      title: 'Test Dialog Title',
      description: 'Test Dialog Description',
      dialogPlatform: DialogPlatform.Cupertino,
      cancelTitle: 'NO'
    );
  }

  String getDatetime(DateTime dateTime) {
    return DateFormat('dd.MM.yy').format(dateTime);
  }

}