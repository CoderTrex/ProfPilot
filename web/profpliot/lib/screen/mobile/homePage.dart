import 'package:flutter/material.dart';
import 'package:profpliot/screen/mobile/attendancePage.dart';

Widget buildListTile(String title, VoidCallback onTap) {
  return Container(
    width: 100,
    padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
    decoration: BoxDecoration(color: null), // Specify your color or remove it
    child: ListTile(
      onTap: onTap,
      leading: Container(
        width: 10,
        height: 10,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(),
        child: Stack(children: []),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          height: 0.07,
        ),
      ),
    ),
  );
}

Route _createRoute(int index) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      if (index == 1) {
        return MobileHomePage();
      } else if (index == 2) {
        return MobildAttendancePage();
      } else {
        return MobileHomePage(); // You can replace this with the appropriate widget for the default case.
      }
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class MobileHomePage extends StatefulWidget {
  @override
  _Mobilehomepage createState() => _Mobilehomepage();
}

class _Mobilehomepage extends State<MobileHomePage>
    with AutomaticKeepAliveClientMixin<MobileHomePage> {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Navigation Drawer',
        ),
        backgroundColor: const Color(0xff764abc),
      ),
      drawer: Row(
        children: [
          Container(
            width: 223,
            decoration: BoxDecoration(color: Color(0xFF082F49)),
            child: ListView(
              children: [
                Container(
                  height: 60,
                  width: 220,
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 30,
                  ),
                  decoration: BoxDecoration(color: Color(0xFF082F49)),
                  child: Text(
                    'ProfPliot',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildListTile('Home', () {
                  Navigator.push(
                    context,
                    _createRoute(1),
                  );
                }),
                buildListTile('attendance', () {
                  Navigator.push(
                    context,
                    _createRoute(2),
                  );
                }),
                buildListTile('Community', () {
                  Navigator.push(
                    context,
                    _createRoute(1),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
