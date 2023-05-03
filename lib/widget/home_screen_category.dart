import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget selectCategory(
  String title,
  String description,
  String image,
  BuildContext context,
  bool hasSibling,
) {
  return Container(
    // constraints: BoxConstraints(minHeight: 200.h),
    child: Column(
      children: [
        Container(
          // color: Colors.lightBlue,
          child: Image.asset(
            image,
            width: 60.w,
            height: 60.w,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.h),
          child: Text(
            title,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 17.sp,
                fontWeight: FontWeight.w900),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.sp,
              color: Color.fromARGB(255, 68, 67, 67),
              // fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    ),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          spreadRadius: 5,
          blurRadius: 5,
        ),
      ],
      borderRadius: BorderRadius.circular(10),
      // border: Border.all(color: Theme.of(context).colorScheme.primary),
    ),
    // width: MediaQuery.of(context).size.width * 0.85,
    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
  );
}

Widget singleCategory(String title, String description, String image,
    BuildContext context, bool hasSibling) {
  return Container(
    width: ScreenUtil().screenWidth - 32.h,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          spreadRadius: 5,
          blurRadius: 5,
        ),
      ],
      borderRadius: BorderRadius.circular(10),
      // border: Border.all(color: Theme.of(context).colorScheme.primary),
    ),
    // width: MediaQuery.of(context).size.width * 0.85,
    padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 8.w),

    // margin: EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        Image.asset(
          image,
          width: 120.w,
          height: 120.w,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w900),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  description,
                  // softWrap: true,
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 68, 67, 67),
                    // fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
