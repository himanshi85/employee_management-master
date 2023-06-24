import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:staff_management/Login/login_page.dart';

class UserPayRoll extends StatefulWidget {
  const UserPayRoll({Key? key}) : super(key: key);

  @override
  State<UserPayRoll> createState() => _UserPayRollState();
}

class _UserPayRollState extends State<UserPayRoll> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewAttendance(userid: LoginPage.currentUserid);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(border: Border.all()),
              child: Text(
                'Employee Management System',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(),
                      right: BorderSide(),
                      bottom: BorderSide())),
              child: Text(
                'Salary Slip for May 2023',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(),
                      right: BorderSide(),
                      bottom: BorderSide())),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text('Emp. Id',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),),
                          Text('Designation',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),),
                          SizedBox(
                            height: 50,
                          ),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(LoginPage.loginJson.user![0].name!),
                          Text(LoginPage.loginJson.user![0].id!),
                          Text(LoginPage.loginJson.user![0].post!),
                          SizedBox(
                            height: 50,
                          ),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text('Salary',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),),
                          Text('A/c No.',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),),
                          Text('IFSC Code',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),),
                          SizedBox(
                            height: 50,
                          ),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(LoginPage.loginJson.user![0].salary!),
                          Text(LoginPage.loginJson.user![0].account_no!),
                          Text(LoginPage.loginJson.user![0].ifsc!),
                          SizedBox(
                            height: 50,
                          ),
                        ]),
                  ]),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(),
                            right: BorderSide(),
                            bottom: BorderSide())),
                    child: const Text('Total Present',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(),
                            right: BorderSide(),
                            bottom: BorderSide())),
                    child: Text('Total Absent',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(),
                            right: BorderSide(),
                            bottom: BorderSide())),
                    child: Text('Total Holyday',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(),
                            right: BorderSide(),
                            bottom: BorderSide())),
                    child: Text('Remaining Day',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(),
                            right: BorderSide(),
                            bottom: BorderSide())),
                    child: Text('$totalPresent'),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(),
                            right: BorderSide(),
                            bottom: BorderSide())),
                    child: Text('$totalAbsent'),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(),
                            right: BorderSide(),
                            bottom: BorderSide())),
                    child: Text('5'),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(),
                            right: BorderSide(),
                            bottom: BorderSide())),
                    child: Text('${31 - totalPresent - totalAbsent - 5}'),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Net Salary : ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${totalPay.round()}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  int totalPresent = 0;
  int totalAbsent = 0;
  double totalPay = 0;

  viewAttendance({required String userid}) async {
    Map body = {'userid': userid};
    var url = Uri.parse(
        'https://himanshiflutter.000webhostapp.com/view_attendance.php');
    var response = await http.post(url, body: body);
    setState(() {
      Map json = jsonDecode(response.body);
      for (int i = 0; i < json['response'].length; i++) {
        if (json['response'][i]['attendance'] == 'P') {
          totalPresent++;
        } else if (json['response'][i]['attendance'] == 'A') {
          totalAbsent++;
        }
      }
      totalPay = double.parse(LoginPage.loginJson.user![0].salary!) /
          30 *
          totalPresent;
    });
  }
}
