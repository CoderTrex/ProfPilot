import 'package:flutter/material.dart';
import 'package:profpliot/view/pc/homePage.dart';

class attendancePage extends StatefulWidget {
  @override
  _attendancePage createState() => _attendancePage();
}

Route _createRoute(int index) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      if (index == 1) {
        return PcHomePage();
      } else if (index == 2) {
        return attendancePage();
      } else {
        return PcHomePage();
      }
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class _attendancePage extends State<attendancePage>
    with AutomaticKeepAliveClientMixin<attendancePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  Widget buildCenteredText(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildLectureContainer(int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.indigoAccent,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 40,
          ),
          buildCenteredText('Lecture Name ${index + 1}'),
          Expanded(
            flex: 2, // Adjust the flex value as needed
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildCenteredText('Start Time: ${index}'),
                  buildCenteredText('Attendance vaild time: ${index}'),
                  buildCenteredText('location: ${index}'),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1, // Adjust the flex value as needed
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12.0),
              ),
              height: 160,
              width: 160,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 1, // Adjust the flex value as needed
            child: Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12.0),
              ),
              height: 160,
              width: 100,
              // Remove the color property if you're using BoxDecoration
            ),
          ),
          SizedBox(
            width: 40,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Row(
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
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today\'s attendance checklist',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 100),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    12.0), // Set the border radius
                              ),
                              child: buildLectureContainer(index),
                            ),
                            SizedBox(height: 30),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
