import 'package:new_fish/app/app_setup.router.dart';
import 'package:new_fish/services/firebase_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';

class WelcomeViewModel extends BaseViewModel {

  final FirebaseService _firebaseService = locator<FirebaseService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool checkIfUserIsSignedIn() {
    return _firebaseService.isSignedIn;
  }

  Future navigateToHome() async {
    await _navigationService.replaceWith(Routes.homeView);
  }

  Future navigateToRegister() async {
    await _navigationService.replaceWith(Routes.registerView);
  }

  Future getDataFromSP() async {
    await _firebaseService.getDataFromSP();
  }
}