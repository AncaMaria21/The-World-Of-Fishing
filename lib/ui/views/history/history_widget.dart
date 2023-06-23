import 'package:flutter/material.dart';
import 'package:new_fish/ui/views/history/history_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../components/custom_button.dart';
import '../../../model/reservation_model.dart';

class HistoryWidget extends ViewModelWidget<HistoryViewModel> {
  @override
  Widget build(BuildContext context, HistoryViewModel viewModel) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        // SegmentedButton<Filter>(
        //   segments: const <ButtonSegment<Filter>>[
        //     ButtonSegment<Filter>(
        //       value: Filter.upcoming,
        //       label: Text('Upcoming',),
        //     ),
        //     ButtonSegment<Filter>(
        //       value: Filter.finished,
        //       label: Text('Finished'),
        //     ),
        //   ],
        //   selected: <Filter>{viewModel.filter},
        //   onSelectionChanged: (Set<Filter> newSelection) {
        //     viewModel.setFilter(newSelection.first);
        //   },
        // ),
        Expanded(
            child: StreamBuilder(
          stream: viewModel.getReservation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var doc = snapshot.data!.docs[index];
                  ReservationModel reservationModel =
                      ReservationModel.fromMap(doc.data());
                  reservationModel.docId = doc.id;
                  return buildHistoryItem(viewModel, reservationModel, size);
                },
              );
            } else {
              return const Text("No data");
            }
          },
        ))
      ],
    );
  }

  Widget buildHistoryItem(HistoryViewModel viewModel,
      ReservationModel reservationModel, Size size) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "${viewModel.getDatetime(reservationModel.checkIn)} - ${viewModel.getDatetime(reservationModel.checkOut)}, ",
                  style: TextStyle(color: Colors.grey),
                ),
                FutureBuilder(
                  future: viewModel.getStandById(reservationModel.stand),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!.name,
                        style: TextStyle(color: Colors.grey),
                      );
                    }
                    return const Text("error");
                  },
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: SizedBox(
              width: size.width - 10,
              // height: size.height / 3,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    FutureBuilder(
                      future: viewModel.getPondByStand(reservationModel.stand),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            width: size.width - 10,
                            height: size.height / 4,
                            child: Image.network(
                              snapshot.data!.image,
                              fit: BoxFit.fill,
                            ),
                          );
                        }
                        return const Text("error");
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FutureBuilder(
                          future:
                              viewModel.getPondByStand(reservationModel.stand),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                margin: EdgeInsets.only(left: 8),
                                child: Text(
                                  snapshot.data!.name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                ),
                              );
                            }
                            return const Text("error");
                          },
                        ),
                        FutureBuilder(
                          future:
                              buildHistoryButton(viewModel, reservationModel),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                margin: EdgeInsets.only(right: 8),
                                child: snapshot.data!,
                              );
                            }
                            return Text("error");
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FutureBuilder(
                          future:
                              viewModel.getPondByStand(reservationModel.stand),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                margin: EdgeInsets.only(left: 8, bottom: 5),
                                child: Text(
                                  snapshot.data!.address.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.green.withOpacity(0.8),
                                      fontSize: 12),
                                ),
                              );
                            }
                            return const Text("error");
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<Widget> buildHistoryButton(
      HistoryViewModel viewModel, ReservationModel reservationModel) async {
    var pondModel = await viewModel.getPondByStand(reservationModel.stand);
    var time = DateTime.now();
    if (reservationModel.checkOut.isBefore(time)) {
      return CustomButton(
          color: reservationModel.isReview ? Colors.grey : Colors.green,
          text: "Evaluare",
          onPressed: reservationModel.isReview
              ? null
              : () {
                  viewModel.navigateToReview(reservationModel, pondModel!);
                });
    } else {
      return CustomButton(
          color: DateTime.now().isAfter(
                  reservationModel.checkIn.subtract(const Duration(days: 2)))
              ? Colors.grey
              : Colors.green,
          text: "Anulare",
          onPressed: () {
            if (DateTime.now().isBefore(
                reservationModel.checkIn.subtract(const Duration(days: 2)))) {
              viewModel.deleteReservation(reservationModel.docId);
              viewModel.showSnackbarOnDelete();
            }
          });
    }
  }
}
