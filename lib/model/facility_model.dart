class FacilityModel {

  late String name;
  late String icon;

  FacilityModel({
    required this.name,
    required this.icon
});

  factory FacilityModel.fromJson(dynamic json) {
    return FacilityModel(name: json['name'], icon: json['icon']);
  }

  @override
  String toString() {
    return 'FacilityModel{name: $name, icon: $icon}';
  }
}