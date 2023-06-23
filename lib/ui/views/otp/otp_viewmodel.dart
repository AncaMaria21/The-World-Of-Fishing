import 'package:new_fish/app/app_setup.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';
import '../../../services/firebase_service.dart';

class OtpViewModel extends BaseViewModel {
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String? _otpCode;
  String? get otpCode => _otpCode;
  set otpCode(String? otpCode) {
    _otpCode = otpCode;
  }

  bool isLoading() {
    return _firebaseService.isLoading;
  }

  void signInWithPhone(String phoneNumber) {
    print(phoneNumber);
    _firebaseService.signInWithPhone(phoneNumber);
  }
  // verify otp
  void verifyOtp(String verificationId) {
    _firebaseService.verifyOtp(
      verificationId: verificationId,
      userOtp: _otpCode!,
      onSuccess: () {
        // checking whether user exists in the db
        _firebaseService.checkExistingUser().then(
              (value) async {
            if (value == true) {
              // user exists in our app
              _firebaseService.getDataFromFirestore().then(
                    (value) => _firebaseService.saveUserDataToSP().then(
                      (value) => _firebaseService.setSignIn().then(
                        (value) => _navigationService.replaceWith(Routes.homeView),
                  ),
                ),
              );
            } else {
              _navigationService.pushNamedAndRemoveUntil(Routes.userInformationView);
            }
          },
        );
      },
    );
  }
}