import 'package:new_fish/app/app_setup.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';
import '../../../model/city_model.dart';
import '../../../model/pond_model.dart';
import '../../../services/firebase_service.dart';

class BookingListViewModel extends BaseViewModel {
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future<List<PondModel>> getPond(
      CityModel city, DateTime checkIn, DateTime checkOut) {
    return _firebaseService.getPond(city, checkIn, checkOut);
  }

  Future navigateToPondDetails(
    String id,
      CityModel city,
      PondModel pondModel,
      DateTime checkIn,
      DateTime checkOut
  ) async {
    return await _navigationService.navigateTo(Routes.pondDetailsView,
        arguments: PondDetailsViewArguments(
            id: '1',
            city: city,
            pondModel: pondModel,
            checkIn: checkIn,
            checkOut: checkOut));
  }
}
