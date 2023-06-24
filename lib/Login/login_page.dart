import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:staff_management/json.dart';
import 'package:staff_management/main.dart';

class LoginPage extends StatefulWidget {
  static String currentUserid = '';
  static late LoginJson loginJson;

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isForgotPasswordPress = false;
  bool isRegisterPress = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String todayDate;

  @override
  void initState() {
    super.initState();
    String year = '${DateTime.now().year}';
    String month = DateTime.now().month < 10
        ? '0${DateTime.now().month}'
        : '${DateTime.now().month}';
    String day = DateTime.now().day < 10
        ? '0${DateTime.now().day}'
        : '${DateTime.now().day}';
    todayDate = '$year-$month-$day';
  }

  List<Map> userdata = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGrey3,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Employee Management System",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        border: Border.all(width: 4)),
                    padding: const EdgeInsets.fromLTRB(50, 50, 50, 10),
                    height: 350,
                    width: 350,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Login',
                            style: TextStyle(
                                color: CupertinoColors.black, fontSize: 30),
                          ),
                          CupertinoTextField(
                            controller: usernameController,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.systemGrey3,
                            ),
                            placeholder: 'Username',
                            placeholderStyle: const TextStyle(
                                color: CupertinoColors.secondaryLabel),
                            prefix: const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(CupertinoIcons.person_solid),
                            ),
                          ),
                          CupertinoTextField(
                            onSubmitted: (value) async {
                              Map body = {
                                'username': usernameController.text,
                                'password': passwordController.text,
                              };
                              print(body);
                              var url = Uri.parse(
                                  'https://himanshiflutter.000webhostapp.com/login.php');
                              var response = await http.post(url, body: body);
                              Map json = jsonDecode(response.body);
                              print(json);
                              LoginPage.loginJson = LoginJson(json: json);
                              if (LoginPage.loginJson.user!.isNotEmpty) {
                                if (LoginPage.loginJson.user![0].role !=
                                    'admin') {
                                  todayAttendance();
                                }
                                LoginPage.currentUserid =
                                    LoginPage.loginJson.user![0].id!;
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    HomePage.selectedDrawerIndex = 0;
                                    return HomePage(
                                      username: usernameController.text,
                                      role: LoginPage.loginJson.user![0].role!,
                                    );
                                  },
                                ));
                              }
                            },
                            controller: passwordController,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.systemGrey3,
                            ),
                            placeholder: 'Password',
                            placeholderStyle: const TextStyle(
                                color: CupertinoColors.secondaryLabel),
                            obscureText: true,
                            prefix: const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(CupertinoIcons.padlock_solid),
                            ),
                          ),
                          CupertinoButton(
                            child: Container(
                                decoration: BoxDecoration(
                                  color: CupertinoColors.darkBackgroundGray,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 40, vertical: 5),
                                child: const Text(
                                  'Sign in',
                                  style:
                                      TextStyle(color: CupertinoColors.white),
                                )),
                            onPressed: () async {
                              Map body = {
                                'username': usernameController.text,
                                'password': passwordController.text,
                              };

                              var url = Uri.parse(
                                  'https://himanshiflutter.000webhostapp.com/login.php');
                              var response = await http.post(url, body: body);
                              Map json = jsonDecode(response.body);
                              print('============$json');
                              LoginPage.loginJson = LoginJson(json: json);
                              if (LoginPage.loginJson.user!.isNotEmpty) {
                                LoginPage.currentUserid =
                                    LoginPage.loginJson.user![0].id!;
                                if (LoginPage.loginJson.user![0].role !=
                                    'admin') {
                                  todayAttendance();
                                }
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return HomePage(
                                      username: usernameController.text,
                                      role: LoginPage.loginJson.user![0].role!,
                                    );
                                  },
                                ));
                              }
                            },
                          ),
                        ]),
                  ),
                  const Positioned(
                    left: 125,
                    top: -80,
                    child: Icon(
                      CupertinoIcons.person_fill,
                      color: CupertinoColors.black,
                      size: 100,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Future<void> todayAttendance() async {
    print('************************ $todayDate');
    Map body = {'date': todayDate};
    var url = Uri.parse(
        'https://himanshiflutter.000webhostapp.com/today_attendance.php');
    var response = await http.post(url, body: body);
    Map json = jsonDecode(response.body);
    DateJson todayDateJson = DateJson(json: json);

    bool isPresent = true;
    for (int i = 0; i < todayDateJson.attendance!.length; i++) {
      if (todayDateJson.attendance![i].userid ==
          LoginPage.loginJson.user![0].id!) {
        isPresent = false;
        break;
      }
    }
    if (isPresent) {
      // add present
      print("<<<<<<<<<<<<<<<<<<");
      addAttendance(
          id: LoginPage.loginJson.user![0].id!,
          date: todayDate,
          attendance: 'P');
    }
    // setState(() {
    //   // for (int i = 0; i < HomePage.viewUserJson.user!.length - 1; i++) {
    //   //   try {
    //   //     attendance.add(todayDateJson.attendance![i].attendance!);
    //   //   } catch (_) {
    //   //     attendance.add('');
    //   //   }
    //   // }
    //   // print(attendance);
    //   // isAttendanceLoad = true;
    // });
    debugPrint('log : Today Attendance ===> $json');
  }

  Future<void> addAttendance(
      {required String id,
      required String date,
      required String attendance}) async {
    print('log: addAttendance() called');
    Map body = {
      'userid': id,
      'date': date,
      'attendance': attendance,
    };
    var url = Uri.parse(
        'https://himanshiflutter.000webhostapp.com/add_attendace.php');
    var response = await http.post(url, body: body);
    Map json = jsonDecode(response.body);
  }
}
