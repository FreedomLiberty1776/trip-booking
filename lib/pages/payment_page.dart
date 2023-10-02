import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:trip_booking/pages/success_page.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:uuid/uuid.dart';

import '../models/bus.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage(
      {Key? key,
      required this.amount,
      required this.passengerInfo,
      // required this.itemReference,
      required this.allSeats,
      required this.selectedSeats,
      required this.trip})
      : super(key: key);

  final double amount;
  final Trip trip;
  final Map<String, String> passengerInfo;
  final List<dynamic> allSeats;
  final List<int> selectedSeats;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String paymentReference = const Uuid().v1();

  late WebViewPlusController controller;
  bool loadWebview = false;
  bool responseReceived = false;
  dynamic response = {"status": false};
  final FirebaseFirestore db = FirebaseFirestore.instance;

  void loadLocalHtml() async {
    final html = await rootBundle.loadString("assets/index.html");

    final url = Uri.dataFromString(html,
            mimeType: "text/html", encoding: Encoding.getByName('utf-8'))
        .toString();
    controller.loadUrl(url);
  }

  @override
  void initState() {
    // print('${_auth.currentUser!.phoneNumber} is the auth id');

    // List<int> unavailableSelectedSeats =
    //     []; // seats that were selected but are not avialble anymore
    // final DocumentReference docRef = db.collection("trips").doc(widget.trip.id);
    // widget.selectedSeats.forEach((element) {
    //   // if(docRef.)
    // });

    // final updates = <String, dynamic>{
    //   "seat": widget.allSeats,
    // };

    // docRef.update(updates).then(
    //     (value) => print("DocumentSnapshot successfully updated!"),
    //     onError: (e) => print("Error updating document $e"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          // Here we take the value from the PaymentPage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Pay"),
          centerTitle: true,
        ),
        body: WebViewPlus(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'assets/webview/index.html',
          onWebViewCreated: (controller) {
            this.controller = controller;
          },
          javascriptChannels: {
            JavascriptChannel(
                name: "JavascriptChannel",
                onMessageReceived: (message) async {
                  // print(message.message);
                  // print("javascrpt message ${message.message}");

                  if (message.message == "close") {
                    Navigator.pop(context);
                  }
                  if (message.message == "trigger") {
                    controller.webViewController.runJavascript(
                        "payWithPaystack('${widget.amount}', '$paymentReference',  'pk_test_6a18b8aee954c66232af048174b32c9784ebb0e5', '0557494701')");
                  }
                  if (message.message == "paid") {
                    print('doc id ${widget.trip.id}......................');
                    // List<int> unavailableSelectedSeats =
                    []; // seats that were selected but are not avialble anymore
                    final DocumentReference docRef =
                        db.collection("trips").doc(widget.trip.id);
                    print('docreference $docRef ......................');

                    // widget.selectedSeats.forEach((element) {
                    //   // if(docRef.)
                    // });

                    final updates = <String, dynamic>{
                      "seat": replacedElement(widget.allSeats),
                    };

                    docRef
                        .update(updates)
                        .then((value) => Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                                curve: Curves.easeIn,
                                duration: const Duration(milliseconds: 200),
                                type: PageTransitionType.rightToLeft,
                                child: SucessfulPage(
                                  trip: widget.trip,
                                  selectedSeats: widget.selectedSeats,
                                )),
                            ModalRoute.withName('/home')))
                        .onError((e, stackTrace) {
                      print("Error updating document $e");
                      Navigator.pop(context);
                    });
                  }
                })
          },
        ));
  }

  List<dynamic> replacedElement(List<dynamic> allSeats) {
    allSeats.asMap().forEach((index, element) {
      if (element == "*") {
        allSeats[index] = widget.passengerInfo;
      }
    });

    return allSeats;
  }
}

successfulTopUp(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      // contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      title: Center(
          child: Text(
        'Top Up',
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      )),
      // insetPadding: EdgeInsets.zero,
      // action property is not needed because we are handling it's work in the function GetDigitalAddress.
      content: Container(
        width: ScreenUtil().screenWidth,
        // height: ScreenUtil().screenHeight * 0.4,
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Center(
                child: Text(
                  'Top Up successful',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'Ok',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
