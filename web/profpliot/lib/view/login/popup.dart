import 'package:profpliot/view/login/login.dart';
import 'package:flutter/material.dart';

Widget _highlightTitles(String content) {
  List<String> lines = content.split('\n');
  List<Widget> widgets = [];

  for (String line in lines) {
    if (line.trim().startsWith(RegExp(r'^\d+-\d+\.'))) {
      widgets.add(
        Text(
          line,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      widgets.add(Text(line));
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: widgets,
  );
}

Widget _buildPolicySection(String title, String content) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      const SizedBox(height: 8),
      _highlightTitles(content),
      const SizedBox(height: 16),
    ],
  );
}

void showPopup(BuildContext context) {
  String termOfServiceTitle = '1. Terms of Service';
  String termsOfService = '''
    1.1. Use of services
      1.1.1 By using the Service, you must comply with all applicable laws and regulations.
      1.2. Any illegal activity through the service is prohibited, and actions that may cause harm to other users are also strictly prohibited.

    1.2. Account security
      1.2.1 Users must keep their account information safe.
      1.2.2 Accessing another user's account or providing account information to a third party is prohibited, and the account holder is responsible for the consequences.

    1.3. Service changes and interruptions
      1.3.1 The Company reserves the right to change or discontinue any or all of the Services without prior notice.
      1.3.2 The Company is not responsible for any losses suffered by users due to changes or interruptions in the service.
  ''';

  String privacyPolicyTitle = '2. Privacy Policy';
  String privacyPolicy = '''
    2. Privacy Policy
      2.1. Information collected
        2.1.1 This service may collect essential information such as name and email when registering as a member.
        2.1.2 In addition, data collected while using the service is described in detail in the privacy policy.

      2.2. Use of information
        2.2.1 The collected information is mainly used to provide, maintain, and improve services, and to develop new services.
        2.2.2 Personal information will not be provided to other companies or organizations without the user's consent.

      2.3. Security measures
        2.3.1 Collected information is safely protected through appropriate security measures.
        2.3.2 User information will be safely disposed of even when the service is terminated.
  ''';

  String cookieUsePolicyTitle = '3. Cookie Use Policy';
  String cookieUsePolicy = '''
    3. Cookie Use Policy
      3.1. Use of cookies
        3.1.1 This service uses cookies to improve user experience and provide services.
        3.1.2 Cookies help you set up and maintain certain features.

      3.2. Refusal of cookies
        3.2.1 You may not consent to the use of cookies. However, some features may be limited in this case.
        3.2.2 More information about rejecting cookies can be found in our Cookie Use Policy.
  ''';

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Terms and Policies'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPolicySection(termOfServiceTitle, termsOfService),
              _buildPolicySection(privacyPolicyTitle, privacyPolicy),
              _buildPolicySection(cookieUsePolicyTitle, cookieUsePolicy),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
