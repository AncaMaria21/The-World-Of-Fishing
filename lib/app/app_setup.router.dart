// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/cupertino.dart' as _i14;
import 'package:flutter/material.dart' as _i13;
import 'package:flutter/material.dart';
import 'package:new_fish/model/city_model.dart' as _i15;
import 'package:new_fish/model/pond_model.dart' as _i16;
import 'package:new_fish/model/reservation_model.dart' as _i17;
import 'package:new_fish/ui/views/booking_details/booking_details_view.dart'
    as _i6;
import 'package:new_fish/ui/views/booking_list/booking_list_view.dart' as _i7;
import 'package:new_fish/ui/views/history/history_view.dart' as _i8;
import 'package:new_fish/ui/views/home/home_view.dart' as _i9;
import 'package:new_fish/ui/views/otp/otp_view.dart' as _i4;
import 'package:new_fish/ui/views/pond_details/pond_details_view.dart' as _i11;
import 'package:new_fish/ui/views/profile/profile_view.dart' as _i10;
import 'package:new_fish/ui/views/register/register_view.dart' as _i3;
import 'package:new_fish/ui/views/review/review_view.dart' as _i12;
import 'package:new_fish/ui/views/user_information/user_information_view.dart'
    as _i5;
import 'package:new_fish/ui/views/welcome/welcome_view.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i18;

class Routes {
  static const welcomeView = '/';

  static const registerView = '/register-view';

  static const otpView = '/otp-view';

  static const userInformationView = '/user-information-view';

  static const bookingDetailsView = '/booking-details-view';

  static const bookingListView = '/booking-list-view';

  static const historyView = '/history-view';

  static const homeView = '/home-view';

  static const profileView = '/profile-view';

  static const pondDetailsView = '/pond-details-view';

  static const reviewView = '/review-view';

  static const all = <String>{
    welcomeView,
    registerView,
    otpView,
    userInformationView,
    bookingDetailsView,
    bookingListView,
    historyView,
    homeView,
    profileView,
    pondDetailsView,
    reviewView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.welcomeView,
      page: _i2.WelcomeView,
    ),
    _i1.RouteDef(
      Routes.registerView,
      page: _i3.RegisterView,
    ),
    _i1.RouteDef(
      Routes.otpView,
      page: _i4.OtpView,
    ),
    _i1.RouteDef(
      Routes.userInformationView,
      page: _i5.UserInformationView,
    ),
    _i1.RouteDef(
      Routes.bookingDetailsView,
      page: _i6.BookingDetailsView,
    ),
    _i1.RouteDef(
      Routes.bookingListView,
      page: _i7.BookingListView,
    ),
    _i1.RouteDef(
      Routes.historyView,
      page: _i8.HistoryView,
    ),
    _i1.RouteDef(
      Routes.homeView,
      page: _i9.HomeView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i10.ProfileView,
    ),
    _i1.RouteDef(
      Routes.pondDetailsView,
      page: _i11.PondDetailsView,
    ),
    _i1.RouteDef(
      Routes.reviewView,
      page: _i12.ReviewView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.WelcomeView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.WelcomeView(),
        settings: data,
      );
    },
    _i3.RegisterView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.RegisterView(),
        settings: data,
      );
    },
    _i4.OtpView: (data) {
      final args = data.getArgs<OtpViewArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.OtpView(
            key: args.key,
            verificationId: args.verificationId,
            phoneNumber: args.phoneNumber),
        settings: data,
      );
    },
    _i5.UserInformationView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.UserInformationView(),
        settings: data,
      );
    },
    _i6.BookingDetailsView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.BookingDetailsView(),
        settings: data,
      );
    },
    _i7.BookingListView: (data) {
      final args = data.getArgs<BookingListViewArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.BookingListView(
            key: args.key,
            id: args.id,
            city: args.city,
            checkIn: args.checkIn,
            checkOut: args.checkOut),
        settings: data,
      );
    },
    _i8.HistoryView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.HistoryView(),
        settings: data,
      );
    },
    _i9.HomeView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.HomeView(),
        settings: data,
      );
    },
    _i10.ProfileView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.ProfileView(),
        settings: data,
      );
    },
    _i11.PondDetailsView: (data) {
      final args = data.getArgs<PondDetailsViewArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.PondDetailsView(
            key: args.key,
            id: args.id,
            city: args.city,
            pondModel: args.pondModel,
            checkIn: args.checkIn,
            checkOut: args.checkOut),
        settings: data,
      );
    },
    _i12.ReviewView: (data) {
      final args = data.getArgs<ReviewViewArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.ReviewView(
            key: args.key,
            reservationModel: args.reservationModel,
            pondModel: args.pondModel),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class OtpViewArguments {
  const OtpViewArguments({
    this.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  final _i14.Key? key;

  final String verificationId;

  final String phoneNumber;

  @override
  String toString() {
    return '{"key": "$key", "verificationId": "$verificationId", "phoneNumber": "$phoneNumber"}';
  }

  @override
  bool operator ==(covariant OtpViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.verificationId == verificationId &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return key.hashCode ^ verificationId.hashCode ^ phoneNumber.hashCode;
  }
}

class BookingListViewArguments {
  const BookingListViewArguments({
    this.key,
    required this.id,
    required this.city,
    required this.checkIn,
    required this.checkOut,
  });

  final _i14.Key? key;

  final String id;

  final _i15.CityModel city;

  final DateTime checkIn;

  final DateTime checkOut;

  @override
  String toString() {
    return '{"key": "$key", "id": "$id", "city": "$city", "checkIn": "$checkIn", "checkOut": "$checkOut"}';
  }

  @override
  bool operator ==(covariant BookingListViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.id == id &&
        other.city == city &&
        other.checkIn == checkIn &&
        other.checkOut == checkOut;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        id.hashCode ^
        city.hashCode ^
        checkIn.hashCode ^
        checkOut.hashCode;
  }
}

class PondDetailsViewArguments {
  const PondDetailsViewArguments({
    this.key,
    required this.id,
    required this.city,
    required this.pondModel,
    required this.checkIn,
    required this.checkOut,
  });

  final _i14.Key? key;

  final String id;

  final _i15.CityModel city;

  final _i16.PondModel pondModel;

  final DateTime checkIn;

  final DateTime checkOut;

  @override
  String toString() {
    return '{"key": "$key", "id": "$id", "city": "$city", "pondModel": "$pondModel", "checkIn": "$checkIn", "checkOut": "$checkOut"}';
  }

  @override
  bool operator ==(covariant PondDetailsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.id == id &&
        other.city == city &&
        other.pondModel == pondModel &&
        other.checkIn == checkIn &&
        other.checkOut == checkOut;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        id.hashCode ^
        city.hashCode ^
        pondModel.hashCode ^
        checkIn.hashCode ^
        checkOut.hashCode;
  }
}

class ReviewViewArguments {
  const ReviewViewArguments({
    this.key,
    required this.reservationModel,
    required this.pondModel,
  });

  final _i14.Key? key;

  final _i17.ReservationModel reservationModel;

  final _i16.PondModel pondModel;

  @override
  String toString() {
    return '{"key": "$key", "reservationModel": "$reservationModel", "pondModel": "$pondModel"}';
  }

  @override
  bool operator ==(covariant ReviewViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.reservationModel == reservationModel &&
        other.pondModel == pondModel;
  }

  @override
  int get hashCode {
    return key.hashCode ^ reservationModel.hashCode ^ pondModel.hashCode;
  }
}

extension NavigatorStateExtension on _i18.NavigationService {
  Future<dynamic> navigateToWelcomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.welcomeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOtpView({
    _i14.Key? key,
    required String verificationId,
    required String phoneNumber,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.otpView,
        arguments: OtpViewArguments(
            key: key, verificationId: verificationId, phoneNumber: phoneNumber),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUserInformationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.userInformationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBookingDetailsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.bookingDetailsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBookingListView({
    _i14.Key? key,
    required String id,
    required _i15.CityModel city,
    required DateTime checkIn,
    required DateTime checkOut,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.bookingListView,
        arguments: BookingListViewArguments(
            key: key, id: id, city: city, checkIn: checkIn, checkOut: checkOut),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHistoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.historyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPondDetailsView({
    _i14.Key? key,
    required String id,
    required _i15.CityModel city,
    required _i16.PondModel pondModel,
    required DateTime checkIn,
    required DateTime checkOut,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.pondDetailsView,
        arguments: PondDetailsViewArguments(
            key: key,
            id: id,
            city: city,
            pondModel: pondModel,
            checkIn: checkIn,
            checkOut: checkOut),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToReviewView({
    _i14.Key? key,
    required _i17.ReservationModel reservationModel,
    required _i16.PondModel pondModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.reviewView,
        arguments: ReviewViewArguments(
            key: key, reservationModel: reservationModel, pondModel: pondModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithWelcomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.welcomeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOtpView({
    _i14.Key? key,
    required String verificationId,
    required String phoneNumber,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.otpView,
        arguments: OtpViewArguments(
            key: key, verificationId: verificationId, phoneNumber: phoneNumber),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUserInformationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.userInformationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBookingDetailsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.bookingDetailsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBookingListView({
    _i14.Key? key,
    required String id,
    required _i15.CityModel city,
    required DateTime checkIn,
    required DateTime checkOut,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.bookingListView,
        arguments: BookingListViewArguments(
            key: key, id: id, city: city, checkIn: checkIn, checkOut: checkOut),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHistoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.historyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPondDetailsView({
    _i14.Key? key,
    required String id,
    required _i15.CityModel city,
    required _i16.PondModel pondModel,
    required DateTime checkIn,
    required DateTime checkOut,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.pondDetailsView,
        arguments: PondDetailsViewArguments(
            key: key,
            id: id,
            city: city,
            pondModel: pondModel,
            checkIn: checkIn,
            checkOut: checkOut),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithReviewView({
    _i14.Key? key,
    required _i17.ReservationModel reservationModel,
    required _i16.PondModel pondModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.reviewView,
        arguments: ReviewViewArguments(
            key: key, reservationModel: reservationModel, pondModel: pondModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
