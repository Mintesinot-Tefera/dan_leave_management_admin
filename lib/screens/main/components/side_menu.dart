import 'package:admin/controllers/MenuController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../controllers/RequestController.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo_dan.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              Provider.of<MenuController>(context, listen: false)
                  .changeCurrentScreen(CustomScreensEnum.dashboardScreen);
            },
          ),
          DrawerListTile(
            title: "Pending Requests",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Provider.of<RequestController>(context, listen: false)
                  .unselectrequest();

              Provider.of<MenuController>(context, listen: false)
                  .changeCurrentScreen(CustomScreensEnum.pendingRequestScreen);
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => PendingRequest2()));
            },
          ),
          DrawerListTile(
            title: "Approved Requests",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Provider.of<RequestController>(context, listen: false)
                  .unselectrequest();
              Provider.of<MenuController>(context, listen: false)
                  .changeCurrentScreen(CustomScreensEnum.approvedRequestScreen);
            },
          ),
          DrawerListTile(
            title: "Declined Requests",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Provider.of<MenuController>(context, listen: false)
                  .changeCurrentScreen(CustomScreensEnum.declinedRequestScreen);
            },
          ),
          DrawerListTile(
            title: "Documents",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Notification",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
