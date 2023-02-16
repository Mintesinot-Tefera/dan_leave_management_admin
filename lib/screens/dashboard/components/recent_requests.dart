import 'package:admin/models/Request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

class RecentRequests extends StatefulWidget {
  const RecentRequests({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentRequests> createState() => _RecentRequestsState();
}

class _RecentRequestsState extends State<RecentRequests> {
  late Stream<QuerySnapshot> stream;
  late QuerySnapshot qShot;
  List<Request> requests = [];

  @override
  void initState() {
    super.initState();
    stream = FirebaseFirestore.instance
        .collection("Request")
        // .orderBy("number", descending: false)
        .snapshots();
    changetoList();
  }

  Future<List<Request>> getRequestList() async {
    // FirebaseFirestore.instance.collection('Request').get().then(
    //   (value) {
    //     value.docs.forEach((element) {
    //       print(element.data());
    //     });
    //   },
    // );
    qShot = await FirebaseFirestore.instance
        .collection('Request')
        // .where("status", isEqualTo: "Pending")

        // .where({"status": "Pending"})
        .get();

    return qShot.docs
        .map((doc) => Request(
              docid: doc.id,
              requestid: doc['request_id'],
              description: doc['request_description'],
              date: doc['date'],
              status: doc['status'],
              startdate: doc['start_date'],
              employeename: doc['employee_name'],
              enddate: doc['end_date'],
              type: doc['request_type'],
            ))
        .toList();
  }

  changetoList() async {
    requests = await getRequestList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: EdgeInsets.all(defaultPadding),
        // decoration: BoxDecoration(
        //   color: secondaryColor,
        //   borderRadius: const BorderRadius.all(Radius.circular(10)),
        // ),
        child: StreamBuilder<QuerySnapshot>(
            // future: Firebase.initializeApp(),
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                // return const Text("Something went wrong");
                print("loading");
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              // List? pendingrequests = snapshot.data as List?;
              return SafeArea(
                  child: Container(
                      child: Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Requests",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: DataTable2(
                        columnSpacing: defaultPadding,
                        minWidth: 600,
                        columns: [
                          DataColumn(
                            label: Text("Employee Name"),
                          ),
                          DataColumn(
                            label: Text("Application Time"),
                          ),
                          DataColumn(
                            label: Text("Request Type"),
                          ),
                          DataColumn(
                            label: Text("Request Status"),
                          ),
                        ],
                        rows: List.generate(
                          requests.length,
                          (index) =>
                              recentRequestsDataRow(context, requests[index]),
                        ),
                      ),
                    ),
                  ],
                ),
              )));
            }));
  }

  DataRow recentRequestsDataRow(BuildContext context, Request requestInfo) {
    Timestamp t = requestInfo.date as Timestamp;
    DateTime date = t.toDate();
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              // SvgPicture.asset(
              //   requestInfo.icon!,
              //   height: 30,
              //   width: 30,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(requestInfo.employeename!),
              ),
            ],
          ),
        ),
        DataCell(Text(DateFormat('yyyy-MM-dd KK:mm:ss a').format(date))),
        DataCell(Text(requestInfo.type!)),
        DataCell(
          Text(requestInfo.status!),
        )
      ],
    );
  }
}
