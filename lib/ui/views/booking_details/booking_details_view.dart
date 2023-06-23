import 'package:flutter/material.dart';
import 'package:new_fish/app/app_setup.locator.dart';
import 'package:stacked/stacked.dart';

import 'booking_details_viewmodel.dart';
import 'booking_details_widget.dart';

class BookingDetailsView extends StatelessWidget {
  const BookingDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookingDetailsViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => Scaffold(
          body: model.isBusy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : BookingDetailsWidget()),
      viewModelBuilder: () => locator<BookingDetailsViewModel>(),
      onViewModelReady: (model) => model.handleStartupLogic(),
    );
  }
}
