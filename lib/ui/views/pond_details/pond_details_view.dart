import 'package:flutter/material.dart';
import 'package:new_fish/ui/views/pond_details/pond_details_viewmodel.dart';
import 'package:new_fish/ui/views/pond_details/pond_details_widget.dart';
import 'package:stacked/stacked.dart';

import '../../../model/city_model.dart';
import '../../../model/pond_model.dart';

class PondDetailsView extends StatelessWidget {

  final String id;
  final CityModel city;
  final PondModel pondModel;
  final DateTime checkIn;
  final DateTime checkOut;

  const PondDetailsView({super.key, required this.id, required this.city, required this.pondModel, required this.checkIn, required this.checkOut});



  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PondDetailsViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
        ),
        body: model.isBusy
        ? const Center(child: CircularProgressIndicator(),)
        : PondDetailsWidget(id, city, pondModel, checkIn, checkOut),
      ),
      viewModelBuilder: () => PondDetailsViewModel(),
    );
  }
}
