import 'package:new_fish/services/firebase_service.dart';
import 'package:new_fish/ui/views/booking_details/booking_details_view.dart';
import 'package:new_fish/ui/views/booking_details/booking_details_viewmodel.dart';
import 'package:new_fish/ui/views/booking_list/booking_list_view.dart';
import 'package:new_fish/ui/views/history/history_view.dart';
import 'package:new_fish/ui/views/history/history_viewmodel.dart';
import 'package:new_fish/ui/views/home/home_view.dart';
import 'package:new_fish/ui/views/otp/otp_view.dart';
import 'package:new_fish/ui/views/pond_details/pond_details_view.dart';
import 'package:new_fish/ui/views/profile/profile_view.dart';
import 'package:new_fish/ui/views/profile/profile_viewmodel.dart';
import 'package:new_fish/ui/views/register/register_view.dart';
import 'package:new_fish/ui/views/review/review_view.dart';
import 'package:new_fish/ui/views/user_information/user_information_view.dart';
import 'package:new_fish/ui/views/welcome/welcome_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: WelcomeView, initial: true),
  MaterialRoute(page: RegisterView),
  MaterialRoute(page: OtpView),
  MaterialRoute(page: UserInformationView),
  MaterialRoute(
    page: BookingDetailsView,
  ),
  MaterialRoute(page: BookingListView),
  MaterialRoute(page: HistoryView),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: ProfileView),
  MaterialRoute(page: PondDetailsView),
  MaterialRoute(page: ReviewView)
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: BookingDetailsViewModel),
  LazySingleton(classType: HistoryViewModel),
  LazySingleton(classType: ProfileViewModel),
  LazySingleton(classType: FirebaseService),
  LazySingleton(classType: SnackbarService),
  LazySingleton(classType: DialogService)
])
class AppSetup {}
