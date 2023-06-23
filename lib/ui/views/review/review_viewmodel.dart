import 'package:flutter/cupertino.dart';
import 'package:new_fish/app/app_setup.router.dart';
import 'package:new_fish/model/pond_model.dart';
import 'package:new_fish/model/reservation_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';
import '../../../model/review_model.dart';
import '../../../services/firebase_service.dart';

class ReviewViewModel extends BaseViewModel {

  double _rating = 0;
  double get rating => _rating;
  set rating (double rating) {
    _rating = rating;
    notifyListeners();
  }

  final TextEditingController commentController = TextEditingController();
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  void addReview(ReservationModel reservationModel, PondModel pondModel) {
    ReviewModel reviewModel = ReviewModel(score: rating, comment: commentController.value.text, user: _firebaseService.getLoggedInUser(), date: DateTime.now());
    _firebaseService.addReview(reviewModel, pondModel, reservationModel);
    navigateToHome();
    showSnackbarOnReview();
  }

  Future navigateToHome() async {
    _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
  }

  void showSnackbarOnReview() {
    _snackbarService.showSnackbar(
      message: 'Rezervare evaluata cu succes',
      duration: const Duration(seconds: 4),
    );
  }

}