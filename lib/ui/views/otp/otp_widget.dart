import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_fish/ui/views/otp/otp_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:pinput/pinput.dart';

import '../../../components/custom_button.dart';
import '../../../utils/utiles.dart';

class OtpWidget extends ViewModelWidget<OtpViewModel> {
  final String verificationId;
  final String phoneNumber;

  const OtpWidget(this.verificationId, this.phoneNumber, {super.key});

  @override
  Widget build(BuildContext context, OtpViewModel viewModel) {
    return SafeArea(
      child: viewModel.isLoading() == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.lightGreen,
              ),
            )
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.lightGreen.shade100,
                        ),
                        child: Image.asset(
                          "assets/images/fishing.png",
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Verificare",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Adauga codul OTP trimis pe telefonul tau",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.green.shade200,
                            ),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onCompleted: (value) {
                          viewModel.otpCode = value;
                        },
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: CustomButton(
                          color: Colors.green,
                          text: "Verifica",
                          onPressed: () {
                            if (viewModel.otpCode != null) {
                              viewModel.verifyOtp(verificationId);
                            } else {
                              showSnackBar(context, "Adauga codul de 6 cifre");
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "N-ai primit un cod?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          viewModel.signInWithPhone(phoneNumber);
                        },
                        child: const Text(
                          "Retrimite cod",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
