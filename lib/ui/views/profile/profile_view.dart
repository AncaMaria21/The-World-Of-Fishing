import 'package:flutter/material.dart';
import 'package:new_fish/app/app_setup.locator.dart';
import 'package:new_fish/ui/views/profile/profile_viewmodel.dart';
import 'package:new_fish/ui/views/profile/profile_widget.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => Scaffold(
        body: model.isBusy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ProfileWidget(),
      ),
      viewModelBuilder: () => locator<ProfileViewModel>(),
    );
  }
}
