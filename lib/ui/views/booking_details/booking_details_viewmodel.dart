import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';
import '../../../app/app_setup.router.dart';
import '../../../model/city_model.dart';
import '../../../model/pond_model.dart';

class BookingDetailsViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  late List<CityModel> _citiesModel;
  List<CityModel> get citiesModel => _citiesModel;

  late CityModel _selectedCity = CityModel(name: 'Oras', docId: 'id');
  CityModel get selectedCity => _selectedCity;
  set selectedCity(CityModel cityModel) { _selectedCity = cityModel; notifyListeners();}

  String _checkIn = "Check In";
  String get checkIn => _checkIn;

  String _checkOut = "Check out";
  String get checkout => _checkOut;

  List<DateTime?> checkInDate = [
    DateTime.now(),
  ];

  List<DateTime?> checkOutDate = [
    DateTime.now(),
  ];

  void handleStartupLogic() {
    getPonds();
    getCities();
  }

  List<PondModel> ponds = [];
  
  void setCheckInDate(List<DateTime?> values) {
    checkInDate = values;
    _checkIn = _getValueText(CalendarDatePicker2Type.single, values);
    notifyListeners();
  }

  void setCheckOutDate(List<DateTime?> values) {
    checkOutDate = values;
    _checkOut = _getValueText(CalendarDatePicker2Type.single, values);
    notifyListeners();
  }


  String _getValueText(
      CalendarDatePicker2Type datePickerType,
      List<DateTime?> values,
      ) {
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
          .map((v) => v.toString().replaceAll('00:00:00.000', ''))
          .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  String displayStringForOption(CityModel option) => option.name;

  getCities() async {
    var cities = List<CityModel>.empty(growable: true);
    var cityRef = FirebaseFirestore.instance.collection('Orase');
    var snapshot = await cityRef.get();
    for (var element in snapshot.docs) {
      var city = CityModel.fromJson(element.data());
      city.docId = element.id;
      cities.add(city);
    }
    _citiesModel = cities;
  }

  Future navigateToHome() async {
    await _navigationService.navigateTo(Routes.bookingListView, arguments: BookingListViewArguments(id: '1', city: _selectedCity, checkIn: checkInDate.first!, checkOut: checkOutDate.first!));
  }

  void getPonds() async {
    var ponds = List<PondModel>.empty(growable: true);
    var pondRef = FirebaseFirestore.instance.collection('Balta');
    var snapshot = await pondRef.get();
    for (var element in snapshot.docs) {
      var pond = PondModel.fromJson(element.data());
      pond.docId = element.id;
      ponds.add(pond);
    }
    this.ponds = ponds;
    notifyListeners();
  }

}