import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Request.dart';

late QuerySnapshot qShot;
List<Request> requests = [];

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });

  // Future<List<Request>> getRequestList() async {
  //   qShot = await FirebaseFirestore.instance
  //       .collection('Request')
  //       .where("status", isEqualTo: "Pending")
  //       .get();

  //   return qShot.docs
  //       .map((doc) => Request(
  //             docid: doc.id,
  //             requestid: doc['request_id'],
  //             description: doc['request_description'],
  //             date: doc['date'],
  //             status: doc['status'],
  //             startdate: doc['start_date'],
  //             employeename: doc['employee_name'],
  //             enddate: doc['end_date'],
  //             type: doc['request_type'],
  //           ))
  //       .toList();
  // }

  // changetoList() async {
  //   requests = await getRequestList();
  // }
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Pending Requests",
    numOfFiles: 8,
    svgSrc: "assets/icons/Documents.svg",
    totalStorage: "1.9GB",
    color: Color.fromARGB(255, 243, 255, 19),
    percentage: 80,
  ),
  CloudStorageInfo(
    title: "Approved Requests",
    numOfFiles: 18,
    svgSrc: "assets/icons/google_drive.svg",
    totalStorage: "2.9GB",
    color: Color.fromARGB(255, 58, 255, 19),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Declined Requests",
    numOfFiles: 13,
    svgSrc: "assets/icons/one_drive.svg",
    totalStorage: "1GB",
    color: Color.fromARGB(255, 220, 23, 13),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "Total Requests",
    numOfFiles: 8,
    svgSrc: "assets/icons/drop_box.svg",
    totalStorage: "7.3GB",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];
