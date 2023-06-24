import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staff_management/Login/login_page.dart';
import 'package:staff_management/main.dart';

class PayRollPage extends StatefulWidget {
  const PayRollPage({Key? key}) : super(key: key);

  @override
  State<PayRollPage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<PayRollPage> {
  List<double> width = [650, 490, 420, 370, 300];
  List<double> salary = [
    0,
    10000,
    20000,
    30000,
    40000,
    50000,
    60000,
    70000,
    80000

  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Colors.transparent,
        child: Column(
          children: [
            Row(
              children: [
                Card(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Employee',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          Text('${HomePage.viewUserJson.user!.length - 1}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    height: 100,
                    width: 200,
                  ),
                ),
                Card(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Salary',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          Text(getTotalSalary(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    height: 100,
                    width: 200,
                  ),
                ),
              ],
            ),
            Flexible(
              child: Card(
                margin: EdgeInsets.fromLTRB(20, 10, 30, 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: HomePage.viewUserJson.user!.length,
                          itemBuilder: (context, index) {
                            return HomePage.viewUserJson.user![index].id !=
                                    LoginPage.loginJson.user![0].id
                                ? Row(
                                    children: [
                                      SizedBox(
                                        width: 130,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            HomePage.viewUserJson.user![index]
                                                .name!,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        height: 40,
                                        width: (double.tryParse(HomePage
                                                    .viewUserJson
                                                    .user![index]
                                                    .salary!) ??
                                                0) *
                                            725 /
                                            80000,
                                        color: CupertinoColors.systemBlue,
                                      ),
                                      Text(
                                        '${HomePage.viewUserJson.user![index].salary}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  )
                                : SizedBox(
                                    height: 0,
                                  );
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 90),
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: CupertinoColors.systemBlue))),
                        child: Row(
                          children: List.generate(
                              salary.length,
                              (index) => SizedBox(
                                    width: 90,
                                    child: Center(
                                      child: Text(
                                        '${salary[index].round()}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  String getTotalSalary() {
    double totalSalary = 0;
    for (int i = 0; i < HomePage.viewUserJson.user!.length; i++) {
      try {
        totalSalary += double.parse(HomePage.viewUserJson.user![i].salary!);
      } catch (_) {}
    }
    return '$totalSalary';
  }
}
