import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staff_management/Attendance/admin_attendance.dart';
import 'package:staff_management/Attendance/user_attendance.dart';
import 'package:staff_management/Chat/chat.dart';
import 'package:staff_management/Chat/chat_togather.dart';
import 'package:staff_management/Employee/employee.dart';
import 'package:staff_management/Employee/your_detail.dart';
import 'package:staff_management/Login/login_page.dart';
import 'package:staff_management/Overview/overview.dart';
import 'package:staff_management/Pay%20Roll/pay_roll.dart';
import 'package:staff_management/Pay%20Roll/user_pay_roll.dart';
import 'package:staff_management/Task/admin_task.dart';
import 'package:staff_management/Task/user_task.dart';
import 'package:staff_management/Training/training.dart';
import 'package:staff_management/json.dart';

Future<void> main() async {
  DartVLC.initialize();
  runApp(CupertinoApp(
    localizationsDelegates: [
      DefaultMaterialLocalizations.delegate,
      DefaultCupertinoLocalizations.delegate,
      DefaultWidgetsLocalizations.delegate,
    ],
    debugShowCheckedModeBanner: false,
    theme: CupertinoThemeData(primaryColor: CupertinoColors.black),
    home: LoginPage(),
  ));
}

class HomePage extends StatefulWidget {
  static late ViewUserJson viewUserJson;
  String username;
  String role;
  static int selectedDrawerIndex = 0;

  HomePage({super.key, this.username = '', required this.role});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  bool isSearch = false;
  bool isLogoutPress = false;

  bool isDrawerOpen = true;
  List<String> adminDrawerList = [
    'Overview',
    'Employee',
    'Attendance',
    'Tasks',
    'Payroll',
    'Training',
    'Chat',
  ];
  List<String> userDrawerList = [
    'Overview',
    'Your Details',
    'Attendance',
    'Tasks',
    'Payroll',
    'Training',
    'Chat',
  ];
  List<Widget> adminBody = [
    OverviewPage(),
    EmployeePage(),
    AdminAttendancePage(),
    AdminTaskPage(),
    PayRollPage(),
    TrainingPage(),
    ChatPage(),
    ChatTogether(fromId: LoginPage.currentUserid ?? '', toId: ChatPage.toId),
  ];
  List<Widget> userBody = [
    OverviewPage(),
    ViewDetailPage(),
    UserAttendancePage(),
    UserTaskPage(),
    UserPayRoll(),
    TrainingPage(),
    ChatPage(),
  ];

  @override
  void initState() {
    super.initState();
    getAllUserData();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey3,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 60,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    height: 50,
                    width: 250,
                    child: Center(
                        child: Text(
                          'APPFLOW',
                          style: TextStyle(
                              color: CupertinoColors.activeGreen,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        )),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CupertinoSearchTextField(
                        decoration: BoxDecoration(
                          border:
                          Border.all(color: CupertinoColors.secondaryLabel),
                          borderRadius: BorderRadius.circular(10),
                          color: CupertinoColors.white,
                        ),
                        controller: searchController,
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 50,
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Icon(Icons.notification_add_outlined),
                      )),
                  Container(
                    height: 50,
                    width: 200,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/user.png',
                          height: 40,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(widget.username),
                              Listener(
                                  onPointerDown: (event) {
                                    setState(() {
                                      isLogoutPress = true;
                                    });
                                  },
                                  onPointerUp: (event) {
                                    setState(() {
                                      isLogoutPress = false;
                                    });
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginPage(),
                                        ));
                                  },
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                        color: isLogoutPress
                                            ? CupertinoColors.secondaryLabel
                                            : CupertinoColors.black),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ])),
            Divider(),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isDrawerOpen
                      ? AnimatedContainer(
                    duration: Duration(milliseconds: 600),
                    height: double.infinity,
                    width: isDrawerOpen ? 250 : 0,
                    color: CupertinoColors.inactiveGray,
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isDrawerOpen = false;
                                      });
                                    },
                                    child: Icon(Icons.close)),
                              )
                            ]),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 23, vertical: 10),
                            child: ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(scrollbars: false),
                              child: ListView(
                                children: List.generate(
                                  widget.role == 'admin'
                                      ? adminDrawerList.length
                                      : userDrawerList.length,
                                      (index) =>
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            HomePage.selectedDrawerIndex =
                                                index;
                                          });
                                        },
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color:
                                              HomePage.selectedDrawerIndex ==
                                                  index
                                                  ? CupertinoColors.white
                                                  : Colors.transparent,
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 10),
                                                child: Image.asset(
                                                  'assets/images/$index.png',
                                                  height: 30,),
                                              ),
                                              Text(widget.role == 'admin'
                                                  ? adminDrawerList[index]
                                                  : userDrawerList[index])
                                            ],
                                          ),
                                        ),
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 0,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 23),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child:
                                  Icon(CupertinoIcons.settings_solid),
                                ),
                                Text('Settings')
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                      : GestureDetector(
                    onTap: () {
                      setState(() {
                        isDrawerOpen = true;
                      });
                    },
                    child: Icon(CupertinoIcons.bars),
                  ),
                  Expanded(
                    child: widget.role == 'admin'
                        ? adminBody[HomePage.selectedDrawerIndex]
                        : userBody[HomePage.selectedDrawerIndex],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getAllUserData() async {
    var url = Uri.parse(
        'https://himanshiflutter.000webhostapp.com/view_employee.php');
    var response = await http.get(url);
    Map json = jsonDecode(response.body);
    HomePage.viewUserJson = ViewUserJson(json: json);
  }
}
