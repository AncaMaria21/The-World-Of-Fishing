import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_fish/app/app_setup.locator.dart';
import 'package:stacked/stacked.dart';

import 'history_viewmodel.dart';
import 'history_widget.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => Scaffold(
          body: model.isBusy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : HistoryWidget()),
      viewModelBuilder: () => locator<HistoryViewModel>(),
    );
  }
}
