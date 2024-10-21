import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../my_app_exports.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      surfaceTintColor: Colors.white,
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: FittedBox(child: brandName(fontSize: 30)),
          ),
          Padding(
            padding: const EdgeInsets.all(
              AppDimens.appVPadding10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Hi 👋",
                  style: AppTextStyle.bold20(),
                ),
                Text(
                  user?.email ?? "No display name found",
                  style: AppTextStyle.semiBold20(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
              AppDimens.appVPadding10,
            ),
            child: CommonElevatedButton(
              width: double.infinity,
              text: AppStrings.signOut,
              onPressed: () async {
                UtilsMethod().showConfirmationDialog(
                  context: context,
                  title: 'Are you sure want to SignOut?',
                  confirmText: AppStrings.signOut,
                  onTapCancel: () {
                    Navigator.pop(context);
                  },
                  onTapConfirm: () async {
                    SharedPreferences userData =
                        await SharedPreferences.getInstance();
                    // clear log in data
                    await userData.remove('isLoggedIn');
                    // for clear all the saved items
                    // await userData.clear();
                    navigateTo(context, AppRoute.signInScreen);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
