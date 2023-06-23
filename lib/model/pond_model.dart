import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_fish/model/facility_model.dart';
import 'package:new_fish/model/review_model.dart';

class PondModel {
  late String name;
  late String docId;
  late DocumentReference city;
  late String image;
  late String description;
  late List<FacilityModel> facilities;
  late String address;
  late List<ReviewModel> reviews;
  late String emailAddress;
  late num price;
  late String name_owner;

  PondModel(
      {required this.name,
      required this.docId,
      required this.city,
      required this.image,
      required this.description,
      required this.facilities,
      required this.address,
      required this.reviews,
      required this.emailAddress,
      required this.price,
      required this.name_owner});

  factory PondModel.fromJson(Map<String, dynamic> json) {
    return PondModel(
        name: json['name'],
        docId: '',
        city: json['city'],
        image: json['image'],
        description: json['description'],
        facilities: [],
        address: json['address'],
        reviews: [],
        emailAddress: json['emailAddress'],
        price: json['price'],
        name_owner: json['name_owner']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['docId'] = docId;
    data['city'] = city;
    data['facilities'] = facilities;
    data['address'] = address;
    data['reviews'] = reviews;
    data['emailAddress'] = emailAddress;
    data['price'] = price;
    data['name_owner'] =name_owner;

    return data;
  }

  @override
  String toString() {
    return 'PondModel{name: $name, docId: $docId, city: $city, image: $image, description: $description, facilities: $facilities, address: $address, reviews: $reviews, emailAddress: $emailAddress, price: $price, name_owner:$name_owner}';
  }
}
