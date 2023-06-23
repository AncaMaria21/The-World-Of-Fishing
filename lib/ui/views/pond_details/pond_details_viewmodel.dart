import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_fish/app/app_setup.router.dart';
import 'package:new_fish/model/pond_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';
import '../../../model/user_model.dart';
import '../../../services/firebase_service.dart';

class PondDetailsViewModel extends BaseViewModel {

  final NavigationService _navigationService = locator<NavigationService>();
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  double calculateScore(PondModel pondModel) {
    double sum = 0;
    for (var review in pondModel.reviews) {
      sum += review.score;
    }
    return sum/pondModel.reviews.length;
  }

  Future navigateToHome() async {
    return _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
  }

  void addReservation(PondModel pondModel, DateTime checkIn, DateTime checkOut) {
    _firebaseService.addReservation(pondModel, checkIn, checkOut);
  }

  void showSnackbar() {
    _snackbarService.showSnackbar(
      message: 'Rezervare facuta cu succes',
      duration: const Duration(seconds: 4),
    );
  }

  Future<UserModel> getUserReview(DocumentReference documentReference) async {
    return _firebaseService.getUserReview(documentReference);
  }

}