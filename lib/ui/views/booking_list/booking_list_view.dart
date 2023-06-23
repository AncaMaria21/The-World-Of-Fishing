import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../model/city_model.dart';
import 'booking_list_viewmodel.dart';
import 'booking_list_widget.dart';

class BookingListView extends StatelessWidget {
  final String id;
  final CityModel city;
  final DateTime checkIn;
  final DateTime checkOut;

  const BookingListView({Key? key, required this.id, required this.city, required this.checkIn, required this.checkOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookingListViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
        ),
        body: model.isBusy
            ? const Center(child: CircularProgressIndicator(),)
            : BookingListWidget(id, city, checkIn, checkOut)
      ),
      viewModelBuilder: () => BookingListViewModel(),
    );
  }
}
