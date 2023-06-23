import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_fish/ui/views/user_information/user_information_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../components/custom_button.dart';

class UserInformationWidget extends ViewModelWidget<UserInformationViewModel> {
  @override
  Widget build(BuildContext context, UserInformationViewModel viewModel) {
    return SafeArea(
        child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
                child: Center(
                    child: Column(
                  children: [
                    InkWell(
                      onTap: () => viewModel.selectImage(),
                      child: viewModel.image == null
                          ? const CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 50,
                              child: Icon(
                                Icons.account_circle,
                                size: 50,
                                color: Colors.white,
                              ),
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(viewModel.image!),
                              radius: 50,
                            ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          // name field
                          textFeld(
                            hintText: "Nume Prenume",
                            icon: Icons.account_circle,
                            inputType: TextInputType.name,
                            maxLines: 1,
                            controller: viewModel.nameController,
                          ),

                          // email
                          textFeld(
                            hintText: "abc@example.com",
                            icon: Icons.email,
                            inputType: TextInputType.emailAddress,
                            maxLines: 1,
                            controller: viewModel.emailController,
                          ),

                          // address
                          textFeld(
                            hintText: "Adresa",
                            icon: Icons.edit,
                            inputType: TextInputType.name,
                            maxLines: 2,
                            controller: viewModel.addressController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: CustomButton(
                        color: Colors.green,
                        text: "Continua",
                        onPressed: () => viewModel.storeData(),
                      ),
                    ),
                    CustomButton(
                        color: Colors.green,
                        text: "Inapoi",
                        onPressed: () {
                          viewModel.navigateToWelcome();
                        })
                  ],
                ))));
  }

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Colors.green,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.green,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.green.shade50,
          filled: true,
        ),
      ),
    );
  }
}
