import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../controllers/RequestController.dart';
import 'request_details_info_card.dart';

class RequestDetailsPage extends StatelessWidget {
  const RequestDetailsPage({
    Key? key,
    required this.documentid,
    required this.reqid,
    required this.empname,
    required this.reqtype,
    required this.applicationtimeanddate,
    required this.description,
    required this.startdate,
    required this.enddate,
    required this.status,
  }) : super(key: key);
  final String documentid,
      reqid,
      empname,
      reqtype,
      description,
      startdate,
      enddate,
      status;
  final Timestamp applicationtimeanddate;

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestController>(
        builder: (context, requestController, child) {
      String statusTemp = '';
      if (status != 'Pending') {
        statusTemp = status;
      } else
        statusTemp = requestController.requeststatus;
      return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Request Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: defaultPadding),
            // Chart(),
            RequestDetailsInfoCard(
              // svgSrc: "assets/icons/Documents.svg",

              empname: empname,
              reqtype: reqtype,
              description: description,
              startdate: startdate,
              enddate: enddate,
              applicationtimeanddate: applicationtimeanddate,
              status: statusTemp,
            ),
            SizedBox(
              height: 20,
            ),

            // RequestDetailsInfoCard(
            //   svgSrc: "assets/icons/media.svg",
            //   title:
            //       "Media Files15.3Gasdfhadskjfhsdjfk ajsdkfjaksdfaksjdflasdfkhaslkfdhlasdhf rkashdfkahsdkfhlaskdjfhkashfhaskdhfkjhd;askdjjflkasjdlfjasldfjlskdjflsjdflksjdlkfjsldkfjlsdjflsjdlfksjlaksiewuqroiuoqiuwoerupqouoeB",
            //   amountOfFiles: "15.3B",
            //   numOfFiles: 1328,
            // ),
          ],
        ),
      );
    });
  }
}
