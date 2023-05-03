// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:eazzier_personal/models/app_controller.dart';
// import 'package:eazzier_personal/utils/navigator_service.dart';

// import '../utils/navigator_service.dart';

// Future networkCallLoading() {
//   NavigationService.context
//       .read<AppControllerNotifer>()
//       .setcanPopLoadingScreen(false);
//   return showModalBottomSheet(
//       isDismissible: false,
//       enableDrag: false,
//       backgroundColor: Color.fromRGBO(0, 0, 0, 0.4),
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
//       context: NavigationService.context,
//       builder: (context) {
//         return WillPopScope(
//           onWillPop: () async {
//             return context.read<AppControllerNotifer>().canPopLoadingScreen;
//           },
//           child: FractionallySizedBox(
//             heightFactor: 1.0,
//             child: SafeArea(
//               child: Center(
//                   child: CircularProgressIndicator(
//                       // backgroundColor: Color.fromRGBO(0, 0, 0, 0.4),
//                       )),
//             ),
//           ),
//         );
//       });
// }
