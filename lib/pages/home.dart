import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_booking/pages/available_trips.dart';
import '../utils/datetime.dart';
import '../widgets/navigation_drawer.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Home")),
//       body: Column(children: [

//       ]),
//     );
//   }
// }

const List<String> location = <String>[
  "Select Location",
  "Accra",
  "Kumasi",
  "Bolga",
  "Navorongo",
  "Paga",
  "Wa",
  "Nandom",
  "Aflao",
  "Elubo",
  "Abidjan",
  "Berekum",
  "Bunso",
  "Tamale",
  "Dormaa",
  "Ho",
  "Sunayani",
  "Cape Coast",
  "Tema",
  "Takoradi",
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _txtFormCtrl = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String fromValue = location.first;
  String toValue = location.first;
  DateTime date = DateTime.now();

  @override
  void initState() {
    _txtFormCtrl.text = getFormatedDate(date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          // onTap: checkPermission,
          child: Icon(
            Icons.menu,
            size: 30.sp,
            // color: Colors.white,
          ),
        ),
        title: const Text('Book Trip'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 45, bottom: 18),
              child: Text(
                "Where can we take you?",
                style: TextStyle(fontSize: 25, color: Colors.blue),
              ),
            ),
            dropdownItem('From'),
            const SizedBox(
              height: 20,
            ),
            dropdownItem('To'),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    'Select Travel Date',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
                dateSelector(),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: (() async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AvailableTrips()));
                      }),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context).colorScheme.primary),
                        child: const Text(
                          'Find Trips',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      drawer: const NavigationDrawer(),
    );
  }

  dateSelector() {
    return TextFormField(
      controller: _txtFormCtrl,
      // initialValue: getFormatedDate(date),

      readOnly: true,
      // keyboardType: TextInputType.number,
      onTap: () {
        // we will show the date picker here.
        successfulTopUp(context);
      },

      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.edit),
        // labelText: 'Phone',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      // validator: (value) {
      //   // if (value == null ||
      //   //     value.isEmpty ||
      //   //     value.length != 10 ||
      //   //     mobileNumberIsValid(value) == null) {
      //   //   return 'Invalid Ghana phone number';
      //   // }

      //   phone = value!;
      //   return null;
      // },
    );
  }

  dropdownItem(String loc) {
    return InputDecorator(
      decoration: const InputDecoration(
          border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        // gapPadding: 0,
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: loc == "From" ? fromValue : toValue,
              isExpanded: true,
              isDense: true,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 30,
              elevation: 16,
              // style: const TextStyle(color: Colors.deepPurple),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  if (loc == "From") {
                    fromValue = value!;
                  } else {
                    toValue = value!;
                  }
                });
              },
              items: location.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  successfulTopUp(BuildContext context) {
    DateTime selectedDate = date;
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        // contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
        title: Center(
            child: Text(
          'Select Travel Date',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        )),
        // insetPadding: EdgeInsets.zero,
        // action property is not needed because we are handling it's work in the function GetDigitalAddress.
        content: SizedBox(
          width: ScreenUtil().screenWidth,
          // height: ScreenUtil().screenHeight * 0.4,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  height: 200,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: date,
                    onDateTimeChanged: (DateTime newDateTime) {
                      selectedDate = newDateTime;
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        date = selectedDate;
                        _txtFormCtrl.text = getFormatedDate(date);
                        setState(() {});

                        Navigator.pop(context);
                      },
                      child: Text(
                        'Set',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
