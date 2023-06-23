import 'package:flutter/material.dart';
import 'package:new_fish/ui/views/otp/otp_viewmodel.dart';
import 'package:new_fish/ui/views/otp/otp_widget.dart';
import 'package:stacked/stacked.dart';

class OtpView extends StatelessWidget {
  final String verificationId;
  final String phoneNumber;

  const OtpView({Key? key, required this.verificationId, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: model.isBusy
        ? const Center(child: CircularProgressIndicator(),)
        : OtpWidget(verificationId, phoneNumber),
      ),
      viewModelBuilder: () => OtpViewModel(),
    );
  }
}
