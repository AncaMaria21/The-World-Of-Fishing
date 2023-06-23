import 'package:flutter/material.dart';
import 'package:new_fish/ui/views/user_information/user_information_viewmodel.dart';
import 'package:new_fish/ui/views/user_information/user_information_widget.dart';
import 'package:stacked/stacked.dart';

class UserInformationView extends StatelessWidget {
  const UserInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserInformationViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: model.isBusy
        ? const Center(child: CircularProgressIndicator(),)
        : UserInformationWidget(),
      ),
      viewModelBuilder: () => UserInformationViewModel(),
    );
  }
}
