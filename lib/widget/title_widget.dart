// import 'package:eazzier_personal/page/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class TitleWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool canPop;

  const TitleWidget(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.canPop})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        child: false
            ? Stack(
                alignment: Alignment.centerLeft,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              curve: Curves.easeIn,
                              duration: const Duration(milliseconds: 200),
                              type: PageTransitionType.rightToLeft,
                              child: Container()));
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 30.sp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Center(
                    child: Text(
                      text,
                      style: TextStyle(
                          fontSize: fontSize,
                          color: Theme.of(context).colorScheme.primary,
                          // letterSpacing: 20,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            : Center(
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: fontSize,
                      color: Theme.of(context).colorScheme.primary,
                      // letterSpacing: 20,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
      );
}
