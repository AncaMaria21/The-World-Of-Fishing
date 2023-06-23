import 'package:flutter/material.dart';
import 'package:new_fish/ui/views/pond_details/pond_details_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

import '../../../components/custom_button.dart';
import '../../../model/city_model.dart';
import '../../../model/pond_model.dart';

class PondDetailsWidget extends ViewModelWidget<PondDetailsViewModel> {
  final String id;
  final CityModel city;
  final PondModel pondModel;
  final DateTime checkIn;
  final DateTime checkOut;

  const PondDetailsWidget(
      this.id, this.city, this.pondModel, this.checkIn, this.checkOut,
      {super.key});

  @override
  Widget build(BuildContext context, PondDetailsViewModel viewModel) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                buildPondImage(context),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40))),
                    child: Column(
                      children: <Widget>[
                        buildPondName(),
                        buildPondScore(viewModel),
                        buildPondCity(),
                        separetourHorizontal(),
                        // buildDescText()
                      ],
                    ),
                  ),
                ),
              ],
            ),
            buildDescText(),
            separetourHorizontal(),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 25, 10),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  children: const <Widget>[
                    Text(
                      "Facilitati",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Icon(Icons.theater_comedy)
                  ],
                ),
              ),
            ),
            buildEquipement(),
            separetourHorizontal(),
            buildComment(viewModel),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 70,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: size.width / 2,
                          height: 70,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20))),
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white),
                            onPressed: () {
                              viewModel.addReservation(pondModel, checkIn, checkOut);
                              viewModel.showSnackbar();
                              viewModel.navigateToHome();
                            },
                            child: Text("Rezerva"),
                          ),
                        ),
                        SizedBox(
                          width: size.width / 2,
                          child: Center(
                            child: Text(
                              "${pondModel.price * checkOut.difference(checkIn).inDays} RON/sejur",
                              style: const TextStyle(color: Colors.green),
                            ),
                          ),
                        ),
                        // SizedBox(width: 20,)
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Padding buildPondCity() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(13, 2, 25, 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          city.name,
          style: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.2),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Padding buildPondScore(PondDetailsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(13, 2, 25, 10),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: const Icon(
              Icons.star,
              color: Colors.pink,
              size: 18,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                viewModel.calculateScore(pondModel).toStringAsFixed(2),
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "(${pondModel.reviews.length.toString()})",
              style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Padding buildPondName() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        pondModel.name,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
            fontStyle: FontStyle.italic),
        maxLines: 2,
      ),
    );
  }

  Widget buildPondImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: Image.network(
        pondModel.image,
        fit: BoxFit.fill,
      ),
    );
  }

  Container separetourHorizontal() {
    return Container(
      margin: EdgeInsets.all(15),
      width: 350,
      height: 1,
      color: Colors.black38,
    );
  }

  Widget buildDescText() {
    int _maxLines1 = 20;
    return
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 5, 25, 10),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              pondModel.description,
              style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2),
              overflow: TextOverflow.ellipsis,
              maxLines: _maxLines1,
            ),
          ),
    );
  }

  Column buildEquipement() {
    List<Widget> facilities = [];
    for (var facility in pondModel.facilities) {
      if (facility.name == "Wi-Fi") {
        facilities.add(buildFacility("Wi-Fi", Icons.wifi));
      } else if (facility.name == 'Parcare') {
        facilities.add(buildFacility('Parcare', Icons.park));
      } else {
        facilities.add(buildFacility(facility.name, Icons.question_mark));
      }
    }
    return Column(
      children: facilities,
    );
  }

  Padding buildFacility(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(text),
          Icon(
            icon,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  Widget buildComment(PondDetailsViewModel viewModel) {
    List<Widget> reviews = [];
    reviews.add(Padding(
      padding: const EdgeInsets.fromLTRB(13, 2, 25, 5),
      child: Row(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(right: 5),
              child: const Icon(
                Icons.star,
                color: Colors.pink,
                size: 25,
              )),
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                viewModel.calculateScore(pondModel).toStringAsFixed(2),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    ));
    reviews.add(Padding(
      padding: EdgeInsets.fromLTRB(13, 0, 25, 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          "(${pondModel.reviews.length} comentarii)",
          style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ));
    reviews.add(const SizedBox(
      height: 25,
    ));
    for (var review in pondModel.reviews) {
      reviews.add(Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 2, 25, 10),
            child: Column(
              children: <Widget>[
                FutureBuilder(
                  future: viewModel.getUserReview(review.user),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            snapshot.data!.profilePic),
                                        fit: BoxFit.cover)),
                                height: 45,
                                width: 45,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    snapshot.data!.name,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.2),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    DateFormat('yyyy-MM-dd')
                                        .format(review.date),
                                    style: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.2),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 5),
                                child: const Icon(
                                  Icons.star,
                                  color: Colors.pink,
                                  size: 18,
                                ),
                              ),
                              Text(review.score.toString()),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(13, 10, 5, 10),
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    review.comment!,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.5,
                                        letterSpacing: 0.2),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 10,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                    return const Text("error");
                  },
                ),
              ],
            ),
          ),
        ],
      ));
    }
    return Column(
      children: reviews,
    );
  }
}
