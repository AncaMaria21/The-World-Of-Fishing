import 'package:flutter/material.dart';
import 'package:new_fish/ui/views/welcome/welcome_viewmodel.dart';
import 'package:new_fish/ui/views/welcome/welcome_widget.dart';
import 'package:stacked/stacked.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: model.isBusy
              ? const Center(child: CircularProgressIndicator(),)
              : WelcomeWidget()
      ),
      viewModelBuilder: () => WelcomeViewModel(),
    );
  }
}
