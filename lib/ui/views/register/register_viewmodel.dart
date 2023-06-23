import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';
import '../../../services/firebase_service.dart';

class RegisterViewModel extends BaseViewModel {

  final TextEditingController _phoneController = TextEditingController();
  TextEditingController get phoneController => _phoneController;
  void setText(String text) {
    _phoneController.text = text;
    _phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: _phoneController.text.length,
      ),
    );
    notifyListeners();
  }

  Country _selectedCountry = Country(
      phoneCode: "40",
      countryCode: "RO",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Romania",
      example: "Romania",
      displayName: "Romania",
      displayNameNoCountryCode: "RO",
      e164Key: "");
  // late Country _selectedCountry;
  Country get selectedCountry => _selectedCountry;
  set selectedCountry (Country country) {
    _selectedCountry = country;
    notifyListeners();
  }

  final FirebaseService _firebaseService = locator<FirebaseService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void sendPhoneNumber(String phoneNumber) {
    //+40765030305
    print(phoneNumber);
    _firebaseService.signInWithPhone("+${_selectedCountry.phoneCode}$phoneNumber");
  }

}