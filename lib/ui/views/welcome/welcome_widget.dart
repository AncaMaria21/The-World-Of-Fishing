import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_fish/components/custom_button.dart';
import 'package:new_fish/ui/views/welcome/welcome_viewmodel.dart';
import 'package:stacked/stacked.dart';

class WelcomeWidget extends ViewModelWidget<WelcomeViewModel> {
  @override
  Widget build(BuildContext context, WelcomeViewModel viewModel) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/fish.png'),
              fit: BoxFit.cover)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 20),
              // custom button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  onPressed: () async {
                    if (viewModel.checkIfUserIsSignedIn() == true) {
                      await viewModel.getDataFromSP().whenComplete(
                      await viewModel.navigateToHome()
                      );
                    } else {
                      viewModel.navigateToRegister();
                    }
                  },
                  text: "Sa incepem", color: Colors.green,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}