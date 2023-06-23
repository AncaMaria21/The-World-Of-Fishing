import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_fish/components/custom_button.dart';
import 'package:new_fish/ui/views/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfileWidget extends ViewModelWidget<ProfileViewModel> {
  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: size.height * 0.2 - 27,
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36))),
            ),
            Positioned(
                top: -15,
                right: 15,
                child: IconButton(
                  onPressed: () {
                    viewModel.navigateToWelcome();
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                )),
            Positioned(
              top: (size.height * 0.2 - 27) / 3,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 60,
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  backgroundImage:
                      NetworkImage(viewModel.getLoggedInUser().profilePic),
                  radius: 50,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 70,
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: Colors.green.withOpacity(0.23))
              ]),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(Icons.person),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Text(viewModel.getLoggedInUser().name),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: Colors.green.withOpacity(0.23))
              ]),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(Icons.phone),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Text(viewModel.getLoggedInUser().phoneNumber),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: Colors.green.withOpacity(0.23))
              ]),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(Icons.email),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Text(viewModel.getLoggedInUser().email),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: Colors.green.withOpacity(0.23))
              ]),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(Icons.place),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Text(viewModel.getLoggedInUser().address),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
