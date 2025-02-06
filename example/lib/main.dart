import 'dart:developer';

import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Custom Date Range Picker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({
    super.key,
    required this.title,
  });

  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? pickedStartDate;
  String? pickedEndDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFFF7622),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildHeader(context),
            _buildBody(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        top: 23,
        right: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filter by Date",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF181C2E),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            "Enter the date range you want to filter by",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: const Color(0xFF7E8A97),
            ),
          ),
          SizedBox(height: 26),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _calenderInputField("Date from".toUpperCase(), true),
          SizedBox(height: 22),
          _calenderInputField("Date to".toUpperCase(), false),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _calenderInputField(String label, bool isStartDate) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF32343E),
          ),
        ),
        SizedBox(height: 3),
        SizedBox(
          height: 56,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0xFFF0F5FA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () async {
                    final result =
                        await showModalBottomSheet<Map<String, String>>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      builder: (context) {
                        String? tempPickedStartDate;
                        String? tempPickedEndDate;
                        return StatefulBuilder(
                          builder: (context, modalSetState) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      DateRangePicker(
                                        onStartDateChanged: (value) {
                                          if (value != null) {
                                            modalSetState(() {
                                              tempPickedStartDate =
                                                  "${DateFormat('dd').format(value)}th${DateFormat(' MMMM').format(value)}, ${DateFormat('yyyy').format(value)}";
                                            });

                                            // Immediately update UI
                                            setState(() {
                                              pickedStartDate =
                                                  tempPickedStartDate;
                                            });

                                            log("A start date is selected: $pickedStartDate");
                                          }
                                        },
                                        onEndDateChanged: (value) {
                                          if (value != null) {
                                            modalSetState(() {
                                              tempPickedEndDate =
                                                  "${DateFormat('dd').format(value)}th${DateFormat(' MMMM').format(value)}, ${DateFormat('yyyy').format(value)}";
                                            });

                                            // Immediately update UI
                                            setState(() {
                                              pickedEndDate = tempPickedEndDate;
                                            });

                                            log("An end date is selected: $pickedEndDate");
                                          }
                                        },
                                        selectedDateColor:
                                            const Color(0xFFFF7622),
                                        highlightColor: const Color(0xFFFF7622)
                                            .withOpacity(0.1),
                                        selectedDateTextColor:
                                            const Color(0xFFFFFFFF),
                                        highlightTextColor:
                                            const Color(0xFFFF7622),
                                        onFilledPressed: () {
                                          Navigator.pop(context, {
                                            'startDate':
                                                tempPickedStartDate ?? "",
                                            'endDate': tempPickedEndDate ?? "",
                                          });
                                        },
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );

                    if (result != null) {
                      setState(() {
                        if (isStartDate) {
                          pickedStartDate = result['startDate']!;
                          log(pickedStartDate!);
                        } else {
                          pickedEndDate = result['endDate']!;
                          log(pickedEndDate!);
                        }
                      });
                    }
                  },
                  child: SizedBox(
                    height: 21,
                    width: 21,
                    child: Icon(Icons.calendar_month),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  isStartDate
                      ? (pickedStartDate ?? "Select Date")
                      : (pickedEndDate ?? "Select Date"),
                  style: TextStyle(
                    fontSize:
                        (isStartDate ? pickedStartDate : pickedEndDate) == null
                            ? 14
                            : 16,
                    fontWeight: FontWeight.w400,
                    color:
                        (isStartDate ? pickedStartDate : pickedEndDate) == null
                            ? const Color(0xFF7E8A97).withOpacity(0.45)
                            : const Color(0xFF7E8A97),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
