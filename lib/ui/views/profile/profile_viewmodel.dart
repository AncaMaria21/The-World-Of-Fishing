import 'package:new_fish/app/app_setup.router.dart';
import 'package:new_fish/model/user_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';
import '../../../services/firebase_service.dart';

class ProfileViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirebaseService _firebaseService = locator<FirebaseService>();

  UserModel getLoggedInUser() {
    return _firebaseService.userModel;
  }

  Future navigateToWelcome() async {
    _firebaseService.userSignOut().then((value) => _navigationService.replaceWith(Routes.welcomeView));
  }

}