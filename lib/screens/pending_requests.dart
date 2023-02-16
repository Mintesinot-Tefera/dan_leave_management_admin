import 'package:admin/controllers/RequestController.dart';
import 'package:admin/models/Request.dart';
import 'package:admin/screens/request_approval_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import 'package:intl/intl.dart';

import '../responsive.dart';
import 'dashboard/components/header.dart';

String docidP = '',
    empnameP = '',
    reqtypeP = "",
    descriptionP = '',
    startdateP = '',
    enddateP = '',
    statusP = '',
    requestidP = '';

late Timestamp applicationtimeanddateP;

class PendingRequests extends StatelessWidget {
  PendingRequests({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 700,
          child: SingleChildScrollView(
            primary: false,
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Header(),
                SizedBox(height: defaultPadding),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<RequestController>(
                        builder: (context, requestController, child) {
                      return Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            PendingRequestsBody(),
                            SizedBox(height: defaultPadding),
                            if (Responsive.isMobile(context))
                              SizedBox(height: defaultPadding),
                            if (Responsive.isMobile(context))
                              requestController.requestselected
                                  ? RequestApprovalPage(
                                      documentid: docidP,
                                      reqid: requestidP,
                                      empname: empnameP,
                                      reqtype: reqtypeP,
                                      description: descriptionP,
                                      startdate: startdateP,
                                      applicationtimeanddate:
                                          applicationtimeanddateP,
                                      enddate: enddateP,
                                      status: statusP,
                                    )
                                  : Center()
                          ],
                        ),
                      );
                    }),
                    if (!Responsive.isMobile(context))
                      SizedBox(width: defaultPadding),
                    // On Mobile means if the screen is less than 850 we dont want to show it
                    if (!Responsive.isMobile(context))
                      Consumer<RequestController>(
                          builder: (context, requestController, child) {
                        return Expanded(
                          flex: 4,
                          child: requestController.requestselected
                              ? RequestApprovalPage(
                                  documentid: docidP,
                                  reqid: requestidP,
                                  empname: empnameP,
                                  reqtype: reqtypeP,
                                  description: descriptionP,
                                  startdate: startdateP,
                                  applicationtimeanddate:
                                      applicationtimeanddateP,
                                  enddate: enddateP,
                                  status: statusP,
                                )
                              : Center(),
                        );
                      })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PendingRequestsBody extends StatefulWidget {
  const PendingRequestsBody({
    Key? key,
  }) : super(key: key);

  @override
  State<PendingRequestsBody> createState() => _PendingRequestsBodyState();
}

class _PendingRequestsBodyState extends State<PendingRequestsBody> {
  late Stream<QuerySnapshot> stream;
  late QuerySnapshot qShot;
  List<Request> requests = [];

  @override
  void initState() {
    super.initState();
    stream = FirebaseFirestore.instance
        .collection("Request")
        .where("status", isEqualTo: "Pending")
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
        .where("status", isEqualTo: "Pending")

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

  // List<Request> requests = [];

  //     for (var u in jsonData) {
  //       Request request =
  //           Request(title: u['title'],status: u['status'], date: u['date']);
  //       requests.add(request);
  //     }
  //     print(requests.length);
  //     return requests;

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
              return const Center(child: CircularProgressIndicator());
            }
            // List? pendingrequests = snapshot.data as List?;
            return SafeArea(
                child: Container(
              height: 700,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(defaultPadding),
                // decoration: BoxDecoration(
                //   color: secondaryColor,
                //   borderRadius: const BorderRadius.all(Radius.circular(10)),
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: defaultPadding),
                    Text(
                      "Pending Requests",
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
                          // snapshot.data!.docs.length,
                          (index) =>
                              pendingRequestDataRow(context, requests[index]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          }),
    );
  }

  DataRow pendingRequestDataRow(BuildContext context, Request requestInfo) {
    Timestamp t = requestInfo.date as Timestamp;
    DateTime date = t.toDate();
    return DataRow(cells: [
      DataCell(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text(requestInfo.employeename!),
        ),
      ),
      // DataCell(Text(requestInfo.date!.toString())),
      // DataCell(Text(
      //     '${date.month} - ${date.day} - ${date.year}   ${date.hour}:${date.minute}')),

      DataCell(Text(DateFormat('yyyy-MM-dd KK:mm:ss a').format(date))),
      DataCell(Text(requestInfo.type!)),

      DataCell(
        Text(requestInfo.status!),
        onTap: () {
          docidP = requestInfo.docid!;
          requestidP = requestInfo.requestid!;
          empnameP = requestInfo.employeename!;
          reqtypeP = requestInfo.type!;
          descriptionP = requestInfo.description!;
          startdateP = requestInfo.startdate!;
          applicationtimeanddateP = requestInfo.date!;
          enddateP = requestInfo.enddate!;
          statusP = requestInfo.status!;

          Provider.of<RequestController>(context, listen: false)
              .selectrequest();
        },
      ),
    ]);
  }
}
