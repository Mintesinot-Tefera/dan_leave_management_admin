import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  final String?
      // icon,
      docid,
      requestid,
      userid,
      employeename,
      description,
      status,
      type,
      startdate,
      enddate;
  final Timestamp? date;

  Request(
      {
      // this.icon,
      this.docid,
      this.requestid,
      this.userid,
      this.employeename,
      this.description,
      this.date,
      this.status,
      this.type,
      this.startdate,
      this.enddate});

  // static Request fromJson(Map<String, dynamic> json) =>
  //     Request(date: json['date'], status: json['status'], title: json['title']);

  // toList() {}
}

List demoRequests = [
  Request(
    // icon: "assets/icons/xd_file.svg",
    description: "Abebe Kebede",
    date: Timestamp.now(),
    status: "Accepted",
  ),
  Request(
    // icon: "assets/icons/Figma_file.svg",
    description: "Zeleke Alemayehu",
    date: Timestamp.now(),
    status: "Rejected",
  ),
  Request(
    // icon: "assets/icons/doc_file.svg",
    description: "Samuel Geta",
    date: Timestamp.now(),
    status: "Pending",
  ),
  Request(
    // icon: "assets/icons/sound_file.svg",
    description: "Henok Asegid",
    date: Timestamp.now(),
    status: "Pending",
  ),
  Request(
    // icon: "assets/icons/media_file.svg",
    description: "Yonas Temesgen",
    date: Timestamp.now(),
    status: "Rejected",
  ),
  Request(
    // icon: "assets/icons/pdf_file.svg",
    description: "Temesgen Kebede",
    date: Timestamp.now(),
    status: "Rejected",
  ),
  Request(
    // icon: "assets/icons/excle_file.svg",
    description: "Kaleab Mekonen",
    date: Timestamp.now(),
    status: "Accepted",
  ),
];
