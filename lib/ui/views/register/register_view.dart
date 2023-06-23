import 'package:flutter/material.dart';
import 'package:new_fish/ui/views/register/register_viewmodel.dart';
import 'package:new_fish/ui/views/register/register_widget.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        body: model.isBusy
        ? const Center(child: CircularProgressIndicator(),)
        : RegisterWidget(),
      ),
      viewModelBuilder: () => RegisterViewModel(),
    );
  }
}
