import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  String currentMonth = '';
  List<String> month = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'Jun',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  List<String> day = [];
  List<String> date = [];
  List<String> task = [
    'Improve the UI for ABC App.',
    'Have meeting with O Company.',
    'Change some of the working in O.',
    'Work on XYZ Project',
    'Improve the UI for ABC App.',
    'Have meeting with O Company.',
    'Change some of the working in O.',
    'Work on XYZ Project',
  ];
  List<String> notification = [
    'Improve the UI for ABC App.',
    'Have meeting with O Company.',
    'Change some of the working in O.',
    'Work on XYZ Project',
    'Improve the UI for ABC App.',
    'Have meeting with O Company.',
    'Change some of the working in O.',
    'Work on XYZ Project',
  ];

  int lastDay = 0;
  int currentMonthIndex = 0;
  bool isSeeMorePress = false;
  bool isSeeMoreNot = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentMonthIndex = DateTime.now().month;
    currentMonth = month[currentMonthIndex - 1];
    getDateList(currentMonthIndex);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Colors.transparent,
        child: Column(
          children: [
            SizedBox(
              height: 56,
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: DropdownButton(
                                value: currentMonth,
                                menuMaxHeight: 250,
                                isDense: true,
                                focusColor: CupertinoColors.inactiveGray,
                                dropdownColor: CupertinoColors.inactiveGray,
                                icon: Icon(CupertinoIcons.chevron_down,),
                                items: List.generate(12, (index) {
                                  return DropdownMenuItem(
                                    child: Text(month[index]),
                                    value: month[index],
                                  );
                                }),
                                onChanged: (value) {
                                  setState(() {
                                    currentMonth = value!;
                                    for (int i = 0; i < 12; i++) {
                                      if (month[i] == currentMonth) {
                                        currentMonthIndex = i + 1;
                                        break;
                                      }
                                    }

                                    getDateList(currentMonthIndex);
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 110,
                            child: ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(scrollbars: false),
                              child: ListView.builder(
                                itemCount: lastDay,
                                padding: EdgeInsets.all(5),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  bool bb = DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day) ==
                                      DateTime(DateTime.now().year,
                                          currentMonthIndex, index + 1);
                                  return Container(
                                    width: 40,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: bb
                                            ? CupertinoColors.white
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(day[index]),
                                        Text(date[index]),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                            child: Text('Today'),
                          ),
                          Expanded(
                            child: ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(scrollbars: false),
                              child: ListView.builder(
                                itemCount: task.length,
                                physics: task.length > 3 && isSeeMorePress
                                    ? AlwaysScrollableScrollPhysics()
                                    : NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return CupertinoListTile(
                                      title: Text(task[index]));
                                },
                              ),
                            ),
                          ),
                          task.length > 3 && isSeeMorePress
                              ? SizedBox()
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSeeMorePress = true;
                                      });
                                    },
                                    child: Text('See more...'),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(border: Border.all()),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Work per day'),
                                  Text('This Week')
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 200,
                                  width: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '8',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        '6',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        '4',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        '2',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        '0',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      // Container(height: 20,color: Colors.red,)
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 250,
                                    padding: const EdgeInsets.only(right: 30),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 180,
                                              width: 30,
                                              color: CupertinoColors.white,
                                            ),
                                            Container(
                                              height: 80,
                                              width: 30,
                                              color: CupertinoColors.white,
                                            ),
                                            Container(
                                              height: 120,
                                              width: 30,
                                              color: CupertinoColors.white,
                                            ),
                                            Container(
                                              height: 115,
                                              width: 30,
                                              color: CupertinoColors.white,
                                            ),
                                            Container(
                                              height: 140,
                                              width: 30,
                                              color: CupertinoColors.white,
                                            ),
                                            Container(
                                              height: 0,
                                              width: 30,
                                              color: CupertinoColors.white,
                                            ),
                                            Container(
                                              height: 0,
                                              width: 30,
                                              color: CupertinoColors.white,
                                            ),
                                          ],
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  top: BorderSide(
                                                      color: CupertinoColors
                                                          .white))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width: 40,
                                                  child: Center(
                                                      child: Text('Mon'))),
                                              SizedBox(
                                                  width: 40,
                                                  child: Center(
                                                      child: Text('Tue'))),
                                              SizedBox(
                                                  width: 40,
                                                  child: Center(
                                                      child: Text('Wed'))),
                                              SizedBox(
                                                  width: 40,
                                                  child: Center(
                                                      child: Text('Thu'))),
                                              SizedBox(
                                                  width: 40,
                                                  child: Center(
                                                      child: Text('Fri'))),
                                              SizedBox(
                                                  width: 40,
                                                  child: Center(
                                                      child: Text('Sat'))),
                                              SizedBox(
                                                  width: 40,
                                                  child: Center(
                                                      child: Text('Sun'))),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Notifications',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            Expanded(
                              child: ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context)
                                    .copyWith(scrollbars: false),
                                child: ListView.builder(
                                  itemCount: notification.length,
                                  physics:
                                      notification.length > 3 && isSeeMoreNot
                                          ? AlwaysScrollableScrollPhysics()
                                          : NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return CupertinoListTile(
                                        title: Text(notification[index]));
                                  },
                                ),
                              ),
                            ),
                            notification.length > 3 && isSeeMoreNot
                                ? SizedBox()
                                : Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isSeeMoreNot = true;
                                        });
                                      },
                                      child: Text('See more...'),
                                    ),
                                  )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
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
  }
}
