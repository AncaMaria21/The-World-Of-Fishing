class CityModel {
  late String name;
  late String docId;

  CityModel({required this.name, required this.docId});

  CityModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['docId'] = docId;
    return data;
  }

  @override
  String toString() {
    return 'CityModel{name: $name, docId: $docId}';
  }

  @override
  int get hashCode => Object.hash(name, docId);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is CityModel && other.name == name && other.docId == docId;
  }
}
