import 'dart:io';
import 'package:flutter/material.dart';
import 'package:new_fish/app/app_setup.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';
import '../../../model/user_model.dart';
import '../../../services/firebase_service.dart';
import '../../../utils/utiles.dart';

class UserInformationViewModel extends BaseViewModel {

  final FirebaseService _firebaseService = locator<FirebaseService>();
  final NavigationService _navigationService = locator<NavigationService>();

  File? _image;
  File? get image => _image;

  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;
  void setNameText(String text) {
    _nameController.text = text;
    nameController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: _nameController.text.length
      )
    );
    notifyListeners();
  }

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;
  void setEmailText(String text){
    _emailController.text = text;
    _emailController.selection = TextSelection.fromPosition(
        TextPosition(
            offset: _emailController.text.length
        )
    );
    notifyListeners();
  }

  final TextEditingController _addressController = TextEditingController();
  TextEditingController get addressController => _addressController;
  void setAddressText(String text) {
    _addressController.text = text;
    _addressController.selection = TextSelection.fromPosition(
        TextPosition(
            offset: _addressController.text.length
        )
    );
    notifyListeners();
  }

  void selectImage() async {
    _image = await pickImage();
    notifyListeners();
  }

  // store user data to database
  void storeData() async {
    UserModel userModel = UserModel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        address: addressController.text.trim(),
        profilePic: "",
        createdAt: "",
        phoneNumber: "",
        uid: "",
        docId: ""
    );
    if (image != null) {
      _firebaseService.saveUserDataToFirebase(
        userModel: userModel,
        profilePic: image!,
        onSuccess: () {
          _firebaseService.saveUserDataToSP().then(
                (value) => _navigationService.pushNamedAndRemoveUntil(Routes.homeView)
          );
        },
      );
    } else {
      // showSnackBar(context, "Please upload your profile photo");
    }
  }

  Future navigateToWelcome() async {
    return await _navigationService.pushNamedAndRemoveUntil(Routes.welcomeView);
  }

}