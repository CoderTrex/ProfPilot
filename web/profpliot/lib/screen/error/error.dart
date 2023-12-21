import 'package:flutter/material.dart';

class PlatformErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Platform Error'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 50,
              color: Colors.red,
            ),
            SizedBox(height: 20),
            Text(
              'Unsupported Platform',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'This app supports only Android and iOS platforms.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
