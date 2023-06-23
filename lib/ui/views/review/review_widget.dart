import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_fish/ui/views/review/review_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../components/rating_star.dart';
import '../../../components/custom_button.dart';
import '../../../model/pond_model.dart';
import '../../../model/reservation_model.dart';

class ReviewWidget extends ViewModelWidget<ReviewViewModel> {

  final ReservationModel reservationModel;
  final PondModel pondModel;

  const ReviewWidget(this.reservationModel, this.pondModel, {super.key});


  @override
  Widget build(BuildContext context, ReviewViewModel viewModel) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 35,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(pondModel.image),
            radius: 120,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(pondModel.name),
          const SizedBox(
            height: 15,
          ),
          const Text(
              "Cate stelute merita aceasta experienta?"),
          const SizedBox(
            height: 10,
          ),
          StarRating(
            rating: viewModel.rating,
            onRatingChanged: (rating) => viewModel.rating = rating,
            color: Colors.pink,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: viewModel.commentController,
              maxLines: 6, //or null
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Lasa un comentariu daca vrei :)'
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          CustomButton(color: Colors.green, text: "Adauga review", onPressed: () => viewModel.addReview(reservationModel, pondModel))
        ],
      ),
    )
    ;
  }

}