// import 'package:courierapp/pages/schedue.dart';
// import 'package:courierapp/widgets/accounts/account.dart';
// import 'package:courierapp/widgets/general/messages_and_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:trip_booking/pages/trips.dart';

import '../models/app_controller.dart';

// import '../../models/app_controller.dart';
// import '../../pages/accounts/sign_in.dart';
// import '../../pages/earnings/earnings.dart';

class NavigationDrawer extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  NavigationDrawer({
    Key? key,
  }) : super(key: key);
  // Widget loginLogout(bool value) {
  //   return value ? const Text('Logout') : const Text('Login');
  // }

  @override
  Widget build(BuildContext context) {
    AppControllerNotifer controller = context.watch<AppControllerNotifer>();
    //print(context.read<AppControllerNotifer>().courierInfo.photo);

    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Column(
        children: [
          Expanded(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  // height: 200.h,
                  child: DrawerHeader(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50.h,
                          backgroundImage:
                              const AssetImage("assets/images/user_image.png"),
                        ),
                        Stack(
                          children: [
                            SizedBox(
                              // color: Colors.blue,
                              width: ScreenUtil().screenWidth * 0.8,
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 7.h),
                                    child:
                                        Text(_auth.currentUser!.displayName!),
                                  ),
                                ],
                              ),
                            ),
                            // Positioned(
                            //   right: 0,
                            //   child: IconButton(
                            //       onPressed: () => Navigator.of(context).push(
                            //           PageTransition(
                            //               curve: Curves.easeIn,
                            //               duration: Duration(milliseconds: 200),
                            //               child: AccountPage(),
                            //               type:
                            //                   PageTransitionType.rightToLeft)),
                            //       icon: Icon(
                            //         Icons.navigate_next,
                            //         size: 30.sp,
                            //         color:
                            //             Theme.of(context).colorScheme.primary,
                            //       )),
                            // ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.trip_origin),
                  title: const Text('My Trips'),
                  visualDensity: VisualDensity.compact,
                  minLeadingWidth: 0,
                  onTap: () => Navigator.push(
                      context,
                      PageTransition(
                          curve: Curves.easeIn,
                          duration: const Duration(milliseconds: 200),
                          type: PageTransitionType.rightToLeft,
                          child: MyTrips())),
                ),
                // ListTile(
                //   leading: const Icon(Icons.password),
                //   title: const Text('Change Password'),
                //   onTap: () {
                //     // Navigator.push(
                //     //     context,
                //     //     PageTransition(
                //     //         curve: Curves.easeIn,
                //     //         duration: const Duration(milliseconds: 200),
                //     //         type: PageTransitionType.rightToLeft,
                //     //         child: BarcodeReader()));
                //   },
                //   visualDensity: VisualDensity.compact,
                //   minLeadingWidth: 0,
                // ),
                ListTile(
                  leading: const Icon(Icons.file_copy),
                  title: const Text('Terms & Conditions'),
                  onTap: () {
                    // showToastInfo("This feature is not available");
                  },
                  visualDensity: VisualDensity.compact,
                  minLeadingWidth: 0,
                ),
                // ListTile(
                //   leading: const Icon(Icons.settings),
                //   title: const Text('Settings'),
                //   onTap: () {},
                //   visualDensity: VisualDensity.compact,
                //   minLeadingWidth: 0,
                // ),
                ListTile(
                  leading: const Icon(Icons.phone_enabled),
                  title: const Text('Support'),
                  onTap: () async {
                    // String telephoneUrl =
                    //     'tel:${Notifiers.apcRead.storeCity.mainContact}}'; // for some reason it referenced from the order as FoodOrder for vendor Above and we don't have to even get the string for phone

                    // if (await canLaunch(telephoneUrl)) {
                    //   await launch(telephoneUrl);
                    // } else {
                    //   throw "Error occured trying to call that number.";
                    // }
                  },
                  visualDensity: VisualDensity.compact,
                  minLeadingWidth: 0,
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  // trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      context
                          .read<AppControllerNotifer>()
                          .setAuthentication(false, false);
                      Navigator.pushReplacementNamed(context, '/verify_phone');
                    });
                  },
                  visualDensity: VisualDensity.compact,
                  minLeadingWidth: 0,
                ),
              ],
            ),
          ),
          Align(
              alignment: FractionalOffset.bottomCenter,
              // This container holds all the children that will be aligned
              // on the bottom and should not scroll with the above ListView
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 40.h, horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Divider(),
                      InkWell(
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        onTap: () async {
                          // if (await canLaunch(
                          //     // maybe we don't have to hardcode the url but provide it as
                          //     "https://teleportdl.com/privacy_policy")) {
                          //   await launch(
                          //       "https://teleportdl.com/privacy_policy");
                          // } else {
                          //   throw "Error occured trying to call that number.";
                          // }
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 16.h),
                        child: const Text('version ALPHA'),
                      ),

                      // ListTile(
                      //     leading: Icon(Icons.help),
                      //     title: Text('Help and Feedback'))
                    ],
                  )))
        ],
      ),
    );
  }
}
