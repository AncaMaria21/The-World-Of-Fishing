import 'package:flutter/material.dart';

import '../../../model/pond_model.dart';

class BookingListItem extends StatelessWidget {
  final PondModel pondModel;
  final VoidCallback onClicked;

  const BookingListItem(
      {Key? key, required this.pondModel, required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 5,
            margin: const EdgeInsets.all(10),
            child: InkWell(
              onTap: onClicked,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width - 10,
                    child: Image.network(
                      pondModel.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Text(
                          pondModel.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Text(
                          "${pondModel.price} RON/zi" ,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 8, bottom: 5, top: 5),
                        child: Text(
                          pondModel.address.toUpperCase(),
                          style: TextStyle(
                              color: Colors.green.withOpacity(0.8),
                              fontSize: 12
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
