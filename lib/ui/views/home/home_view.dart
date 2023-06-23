import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_fish/ui/views/booking_details/booking_details_view.dart';
import 'package:new_fish/ui/views/history/history_view.dart';
import 'package:new_fish/ui/views/profile/profile_view.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
        ),
        body:
        PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          reverse: model.reverse,
          transitionBuilder: (Widget child, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
          child: getViewForIndex(model.currentIndex),
        ),
        bottomNavigationBar: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -10),
                blurRadius: 35,
                color: Colors.green.withOpacity(0.38)
              )
            ]
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.green,
            currentIndex: model.currentIndex,
            onTap: model.setIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.search, color: Colors.green,), label: 'Cautati'),
              BottomNavigationBarItem(icon: Icon(Icons.calendar_month, color: Colors.green,), label: 'Rezervari'),
              BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.green,), label: 'Profilul meu')
            ],
          ),
        )
        ,
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const BookingDetailsView();
      case 1:
        return const HistoryView();
      case 2:
        return const ProfileView();
      default:
        return const BookingDetailsView();
    }
  }
}
