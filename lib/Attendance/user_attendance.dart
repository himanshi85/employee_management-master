import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:staff_management/Login/login_page.dart';
import 'package:staff_management/json.dart';

class UserAttendancePage extends StatefulWidget {
  const UserAttendancePage({Key? key}) : super(key: key);

  @override
  State<UserAttendancePage> createState() => _UserAttendancePageState();
}

class _UserAttendancePageState extends State<UserAttendancePage> {
  List<String> day = [];
  List<String> date = [];
  int lastDay = 0;
  List<String> dayName = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  late DateJson dateJson;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDateList(DateTime.now().month);
    viewAttendance(userid: LoginPage.currentUserid);
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

  viewAttendance({required String userid}) async {
    Map body = {'userid': userid};
    var url = Uri.parse(
        'https://himanshiflutter.000webhostapp.com/view_attendance.php');
    var response = await http.post(url, body: body);
    Map json = jsonDecode(response.body);
    dateJson = DateJson(json: json);
    setState(() {
      isAttendanceLoad = true;
    });
  }

  bool isAttendanceLoad = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Colors.transparent,
        child: Center(
          child: SizedBox(
            height: 450,
            width: 500,
            child: isAttendanceLoad
                ? Column(
                    children: [
                      Text(
                        'May',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Spacer(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            children: List.generate(
                                7,
                                (index) => Expanded(
                                      child:
                                          Center(child: Text(dayName[index])),
                                    )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GridView.builder(
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
                                  i < dateJson.attendance!.length;
                                  i++) {
                                if (nowDate == dateJson.attendance![i].date!) {
                                  attendance =
                                      dateJson.attendance![i].attendance!;
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                child: Center(
                                  child: Text(
                                    '${date[index]}',
                                    style: TextStyle(
                                        color: (index + 1) % 7 == 0 ||
                                                (index + 2) % 7 == 0
                                            ? CupertinoColors.systemRed
                                            : CupertinoColors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  )
                : SizedBox(),
          ),
        ));
  }

}
