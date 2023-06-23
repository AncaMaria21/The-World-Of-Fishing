import 'package:cloud_firestore/cloud_firestore.dart';

class StandModel {
  late String name;
  late String docId;
  DocumentReference? pond;

  StandModel({required this.name, required this.pond});

  factory StandModel.fromJson(Map<String, dynamic> json) {
    return StandModel(name: json['name'], pond: json['pond']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['pond'] = pond;

    return data;
  }

  @override
  String toString() {
    return 'StandModel{name: $name, docId: $docId, pond: $pond}';
  }
}
