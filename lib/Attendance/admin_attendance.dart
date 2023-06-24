import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:staff_management/json.dart';
import 'package:staff_management/main.dart';

class AdminAttendancePage extends StatefulWidget {
  static late DateJson dateJson;

  const AdminAttendancePage({Key? key}) : super(key: key);

  @override
  State<AdminAttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AdminAttendancePage> {
  List<String> day = [];
  List<String> date = [];
  List<String> dayName = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  int lastDay = 0;
  List<Map<String, String>> employeeAttendance = [
    {'name': 'Janvi Mangukiya', 'attendance': ''},
    {'name': 'Prarthna Patel', 'attendance': ''},
    {'name': 'Himanshi Patel', 'attendance': ''},
    {'name': 'Dhruvi Moradiya', 'attendance': ''},
    {'name': 'Prachi Moradiya', 'attendance': ''},
  ];
  List<String> employeeName = [
    'Janvi Mangukiya',
    'Prarthna Patel',
    'Himanshi Patel',
    'Dhruvi Moradiya',
    'Prachi Moradiya',
  ];
  List<String> attendance = [];
  String? currentEmployee;
  late String todayDate;
  late DateJson todayDateJson;
  int length = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String year = '${DateTime.now().year}';
    String month = DateTime.now().month < 10
        ? '0${DateTime.now().month}'
        : '${DateTime.now().month}';
    String day = DateTime.now().day < 10
        ? '0${DateTime.now().day}'
        : '${DateTime.now().day}';
    todayDate = '$year-$month-$day';
    todayAttendance(today: DateTime.now());
    getDateList(DateTime.now().month);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0x000000),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, top: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: Color(0x00000000),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: CupertinoColors.systemGrey3,
                        focusColor: Color(0x00000000),
                        value: currentEmployee,
                        hint: Text('Select Employee'),
                        items: List.generate(
                            HomePage.viewUserJson.user!.length - 1, (index) {
                          return DropdownMenuItem(
                            child: Text(
                                HomePage.viewUserJson.user![index + 1].name!),
                            value: HomePage.viewUserJson.user![index + 1].name!,
                          );
                        }),
                        onChanged: (value) {
                          setState(() {
                            currentEmployee = value!;
                            for (int i = 1;
                                i < HomePage.viewUserJson.user!.length;
                                i++) {
                              if (value ==
                                  HomePage.viewUserJson.user![i].name!) {
                                viewAttendance(
                                    userid: HomePage.viewUserJson.user![i].id!);
                                break;
                              }
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      "May",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )),
                currentEmployee != null
                    ? Container(
                        height: 400,
                        width: 500,
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: Row(
                                  children: List.generate(
                                      7,
                                      (index) => Expanded(
                                            child: Center(
                                                child: Text(dayName[index])),
                                          )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: viewAttendanceLoad
                                  ? GridView.builder(
                                      itemCount: date.length,
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 7,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10),
                                      itemBuilder: (context, index) {
                                        String attendance = '';
                                        String nowDate =
                                            '${DateTime.now().year}-${DateTime.now().month < 10 ? '0' + '${DateTime.now().month}' : DateTime.now().month}-${int.parse(date[index]) < 10 ? '0' + date[index] : date[index]}';
                                        for (int i = 0;
                                            i <
                                                AdminAttendancePage.dateJson
                                                    .attendance!.length;
                                            i++) {
                                          if (nowDate ==
                                              AdminAttendancePage.dateJson
                                                  .attendance![i].date!) {
                                            attendance = AdminAttendancePage
                                                .dateJson
                                                .attendance![i]
                                                .attendance!;
                                            break;
                                          } else {
                                            attendance = '';
                                          }
                                        }
                                        return Card(
                                          color: attendance == 'P'
                                              ? CupertinoColors.systemGreen
                                              : attendance == 'A'
                                                  ? CupertinoColors.systemRed
                                                  : CupertinoColors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          elevation: 5,
                                          child: Center(
                                            child: Text(
                                              '${date[index]}',
                                              style: TextStyle(
                                                  color: (index + 1) % 7 == 0 ||
                                                          (index + 2) % 7 == 0
                                                      ? CupertinoColors
                                                          .systemRed
                                                      : CupertinoColors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : SizedBox(),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(
                        height: 400,
                        width: 500,
                        child: Center(
                            child: Text(
                          'Select Employee to\nsee Attendance',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )),
                      )
              ],
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Today Attendance',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Material(
                  child: isAttendanceLoad
                      ? ReorderableListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              key: Key(index.toString()),
                              padding: const EdgeInsets.all(10),
                              child: CupertinoListTile(
                                  backgroundColor: CupertinoColors.white,
                                  padding: EdgeInsets.all(10),
                                  leading: Icon(CupertinoIcons.person_solid),
                                  trailing: Material(
                                    color: Colors.transparent,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 110,
                                          child: RadioListTile(
                                            activeColor:
                                                CupertinoColors.systemGreen,
                                            contentPadding: EdgeInsets.zero,
                                            title: const Text('Present'),
                                            value: 'P',
                                            groupValue: attendance[index],
                                            onChanged: (value) => null,
                                          ),
                                        ),
                                        SizedBox(
                                            width: 110,
                                            child: RadioListTile(
                                                activeColor:
                                                    CupertinoColors.systemRed,
                                                contentPadding: EdgeInsets.zero,
                                                title: const Text('Absent'),
                                                value: 'A',
                                                groupValue: attendance[index],
                                                onChanged: (value) => null)),
                                      ],
                                    ),
                                  ),
                                  title: Text(HomePage
                                      .viewUserJson.user![index + 1].name!)),
                            );
                          },
                          itemCount: HomePage.viewUserJson.user!.length - 1,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              if (newIndex > oldIndex) newIndex--;
                              Map<String, String> temp =
                                  employeeAttendance[newIndex];
                              employeeAttendance[newIndex] =
                                  employeeAttendance[oldIndex];
                              employeeAttendance[oldIndex] = temp;
                            });
                          },
                        )
                      : SizedBox(),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  getDateList(int month) {
    var now = new DateTime.now();

    var beginningNextMonth = (month < 12)
        ? DateTime(now.year, month + 1, 1)
        : DateTime(now.year + 1, 1, 1);
    lastDay = beginningNextMonth.subtract(Duration(days: 1)).day;
    day.clear();
    date.clear();

    for (int i = 1; i <= lastDay; i++) {
      String dayName =
          DateFormat('EE').format(DateTime(DateTime.now().year, month, i));
      day.add(dayName);
      date.add('$i');
    }
    List<String> temp = [];
    String firstDayName =
        DateFormat('EE').format(DateTime(DateTime.now().year, month, 1));
    for (int i = 0; firstDayName != dayName[i]; i++) {
      temp.add('');
    }
    temp.addAll(date);
    date.clear();
    date.addAll(temp);
  }

  bool viewAttendanceLoad = false;

  viewAttendance({required String userid}) async {
    Map body = {'userid': userid};
    var url = Uri.parse(
        'https://himanshiflutter.000webhostapp.com/view_attendance.php');
    var response = await http.post(url, body: body);
    Map json = jsonDecode(response.body);
    AdminAttendancePage.dateJson = DateJson(json: json);
    setState(() {
      viewAttendanceLoad = true;
    });
  }

  Future<void> todayAttendance({required DateTime today}) async {
    Map body = {'date': todayDate};
    var url = Uri.parse(
        'https://himanshiflutter.000webhostapp.com/today_attendance.php');
    var response = await http.post(url, body: body);
    Map json = jsonDecode(response.body);
    todayDateJson = DateJson(json: json);
    setState(() {
      attendance = List.filled(HomePage.viewUserJson.user!.length - 1, '');
      for (int i = 0; i < todayDateJson.attendance!.length; i++) {
        print(todayDateJson.attendance![i].userid);
        for (int j = 1; j < HomePage.viewUserJson.user!.length; j++) {
          if (todayDateJson.attendance![i].userid ==
              HomePage.viewUserJson.user![j].id) {
            attendance[j - 1] = todayDateJson.attendance![i].attendance!;
            break;
          }
        }
      }
      print(attendance);
      isAttendanceLoad = true;
    });
    debugPrint('log : Today Attendance ===> $json');
  }

  bool attendanceError = false;
  bool isAttendanceLoad = false;

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

  Future<void> updateAttendance(
      {required String id,
      required String date,
      required String attendance}) async {
    print('log: updateAttendance() called');
    Map body = {
      'id': id,
      'updated_attendance': attendance,
    };
    debugPrint('$body');
    var url = Uri.parse(
        'https://himanshiflutter.000webhostapp.com/update_attendance.php');
    var response = await http.post(url, body: body);
    Map json = jsonDecode(response.body);
    print(id);
    print(json);
  }
}
