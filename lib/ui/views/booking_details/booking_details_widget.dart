import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:new_fish/model/pond_model.dart';
import 'package:stacked/stacked.dart';

import '../../../components/custom_button.dart';
import '../../../model/city_model.dart';
import 'booking_details_viewmodel.dart';

class BookingDetailsWidget extends ViewModelWidget<BookingDetailsViewModel> {
  @override
  Widget build(BuildContext context, BookingDetailsViewModel viewModel) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: size.height * 0.2,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 56),
                  height: size.height * 0.2 - 27,
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(36),
                          bottomRight: Radius.circular(36))),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Ce cautati?',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const CircleAvatar(
                        radius: 48,
                        backgroundImage: AssetImage("assets/images/peste.jpg"),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    height: 54,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 10),
                              blurRadius: 50,
                              color: Colors.green.withOpacity(0.23))
                        ]),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: Icon(Icons.room)),
                      child: Autocomplete<CityModel>(
                        initialValue:
                            TextEditingValue(text: viewModel.selectedCity.name),
                        displayStringForOption: (city) => city.name,
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable<CityModel>.empty();
                          }
                          return viewModel.citiesModel
                              .where((CityModel option) {
                            return option.name
                                .toLowerCase()
                                .toString()
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (CityModel selection) {
                          viewModel.selectedCity = selection;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            height: 54,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 50,
                      color: Colors.green.withOpacity(0.23))
                ]),
            child: createCheckInOption(context, viewModel),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            height: 54,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 50,
                      color: Colors.green.withOpacity(0.23))
                ]),
            child: createCheckOutOption(context, viewModel),
          ),
          const SizedBox(
            height: 20.0,
          ),
          CustomButton(
              color: Colors.green,
              text: "Cauta",
              onPressed: () {
                viewModel.navigateToHome();
              }),
          Row(
            children: <Widget>[
              Container(
                height: 24,
                child: Stack(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "Baltile noastre",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        margin: const EdgeInsets.only(right: 5),
                        height: 7,
                        color: Colors.green.withOpacity(0.2),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: buildPondsList(size, context, viewModel),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildPondsList(Size size, BuildContext context, BookingDetailsViewModel viewModel) {
    List<Widget> ponds = [];

    for(var pond in viewModel.ponds) {
      ponds.add(buildPondItem(size, context, pond));
    }

    ponds.add(Container(
      margin: const EdgeInsets.only(
          right: 20,
          top: 10,
          bottom: 20 * 2.5
      ),
    ));

    return ponds;
  }



  Widget buildPondItem(Size size, BuildContext context, PondModel pondModel) {
    return Container(
                margin: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                    bottom: 20 * 2.5
                ),
                width: size.width * 0.6,
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)
                          )
                      ),
                      child: Image.network(pondModel.image),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)
                            ),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 10),
                                  blurRadius: 50,
                                  color: Colors.green.withOpacity(0.23)
                              )
                            ]
                        ),
                        child: Row(
                          children: <Widget>[
                            RichText(text: TextSpan(children: [
                              TextSpan(
                                  text: "${pondModel.name.toUpperCase()}\n",
                                  style: Theme.of(context).textTheme.button
                              ),
                              TextSpan(
                                text: pondModel.address.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.green.withOpacity(0.8)
                                )
                              )
                            ]))
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              );
  }

  createCheckInOption(
      BuildContext buildContext, BookingDetailsViewModel viewModel) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(viewModel.checkIn),
      leading: const Icon(Icons.calendar_month),
      trailing: const Icon(Icons.arrow_drop_down),
      onTap: () async {
        final values = await showCalendarDatePicker2Dialog(
          context: buildContext,
          config: CalendarDatePicker2WithActionButtonsConfig(
            calendarType: CalendarDatePicker2Type.single,
            selectedDayHighlightColor: Colors.amber[900],
            weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
            weekdayLabelTextStyle: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
            firstDayOfWeek: 1,
            controlsHeight: 50,
            controlsTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            dayTextStyle: const TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
            ),
            disabledDayTextStyle: const TextStyle(
              color: Colors.grey,
            ),
            selectableDayPredicate: (day) => !day
                .difference(DateTime.now().subtract(const Duration(days: 3)))
                .isNegative,
          ),
          dialogSize: const Size(325, 400),
          borderRadius: BorderRadius.circular(15),
          initialValue: viewModel.checkInDate,
          dialogBackgroundColor: Colors.white,
        );
        if (values != null) {
          viewModel.setCheckInDate(values);
        }
      },
    );
  }

  createCheckOutOption(
      BuildContext buildContext, BookingDetailsViewModel viewModel) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(viewModel.checkout),
      leading: const Icon(Icons.calendar_month),
      trailing: const Icon(Icons.arrow_drop_down),
      onTap: () async {
        final values = await showCalendarDatePicker2Dialog(
          context: buildContext,
          config: CalendarDatePicker2WithActionButtonsConfig(
            calendarType: CalendarDatePicker2Type.single,
            selectedDayHighlightColor: Colors.amber[900],
            weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
            weekdayLabelTextStyle: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
            firstDayOfWeek: 1,
            controlsHeight: 50,
            controlsTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            dayTextStyle: const TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
            ),
            disabledDayTextStyle: const TextStyle(
              color: Colors.grey,
            ),
            selectableDayPredicate: (day) => !day
                .difference(DateTime.now().subtract(const Duration(days: 3)))
                .isNegative,
          ),
          dialogSize: const Size(325, 400),
          borderRadius: BorderRadius.circular(15),
          dialogBackgroundColor: Colors.white,
        );
        if (values != null) {
          viewModel.setCheckOutDate(values);
        }
      },
    );
  }
}