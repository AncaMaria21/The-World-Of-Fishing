import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  late num score; // eroare la int si double
  late String? comment;
  late DocumentReference user;
  late DateTime date;

  ReviewModel(
      {required this.score,
      required this.comment,
      required this.user,
      required this.date});

  factory ReviewModel.fromJson(dynamic json) {
    DateTime date = (json['date'] as Timestamp).toDate();
    return ReviewModel(
      score: json['score'],
      comment: json['comment'],
      user: json['user'],
      date: date,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['score'] = score;
    data['comment'] = comment;
    data['user'] = user;
    data['date'] = date;

    return data;
  }
}
