import 'package:flutter/material.dart';
import 'package:new_fish/ui/views/review/review_viewmodel.dart';
import 'package:new_fish/ui/views/review/review_widget.dart';
import 'package:stacked/stacked.dart';

import '../../../model/pond_model.dart';
import '../../../model/reservation_model.dart';

class ReviewView extends StatelessWidget {

  final ReservationModel reservationModel;
  final PondModel pondModel;

  const ReviewView({Key? key, required this.reservationModel, required this.pondModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReviewViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
        ),
        body: model.isBusy
        ? const Center(child: CircularProgressIndicator(),)
        : ReviewWidget(reservationModel, pondModel),
      ),
      viewModelBuilder: () => ReviewViewModel(),
    );
  }
}
