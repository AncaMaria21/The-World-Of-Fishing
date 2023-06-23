import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:new_fish/ui/views/booking_list/booking_list_item.dart';
import 'package:new_fish/ui/views/booking_list/booking_list_viewmodel.dart';
import 'package:new_fish/ui/views/pond_details/pond_details_view.dart';
import 'package:stacked/stacked.dart';

import '../../../model/city_model.dart';
import '../../../model/pond_model.dart';

class BookingListWidget extends ViewModelWidget<BookingListViewModel> {
  final String id;
  final CityModel city;
  final DateTime checkIn;
  final DateTime checkOut;

  const BookingListWidget(this.id, this.city, this.checkIn, this.checkOut,
      {super.key});

  @override
  Widget build(BuildContext context, BookingListViewModel viewModel) {
    return FutureBuilder(
        future: viewModel.getPond(city, checkIn, checkOut),
        builder:
            (BuildContext context, AsyncSnapshot<List<PondModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var ponds = snapshot.data as List<PondModel>;
            if (ponds.isEmpty) {
              return const Center(
                child: Text(("Nu sunt balti disponibile")),
              );
            } else {
              return GestureDetector(
                onTap: null,
                child: ListView.builder(
                    itemCount: ponds.length,
                    itemBuilder: (context, index) {
                      return OpenContainer(
                        closedElevation: 6,
                        transitionType: ContainerTransitionType.fade,
                          transitionDuration: const Duration(seconds: 1),
                          closedBuilder: (context, VoidCallback openContainer) => BookingListItem(pondModel: ponds[index], onClicked: openContainer),
                          openBuilder: (context,_) => PondDetailsView(id: id, city: city, pondModel: ponds[index], checkIn: checkIn, checkOut: checkOut)
                      );
                    }),
              );
            }
          }
        });
  }
}
