import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/controllers/RequestController.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/pending_requests.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyB90T-3CMT_fcMcA3yMOgumAvo_u1ODfhY",
          projectId: "danattendancemanagement-805e7",
          messagingSenderId: "714977608761",
          appId: "1:714977608761:web:44ef5c0e0b9d3d078279e8"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RequestController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dan Energy Attendance Admin',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        // routes: {
        //   '/pendingrequests': (context) => PendingRequests(),
        // },
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MenuController(),
            ),
          ],
          child: MainScreen(),
        ),
      ),
    );
  }
}
