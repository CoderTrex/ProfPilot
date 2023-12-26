import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// 01035719455

class FirebaseAuthentication {
  String phoneNumber = "";

  sendOTP(String phoneNumber) async {
    this.phoneNumber = phoneNumber;
    FirebaseAuth auth = FirebaseAuth.instance;
    ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber(
      '+82 $phoneNumber',
    );
    printMessage("OTP Sent to +82 $phoneNumber");
    return confirmationResult;
  }

  authenticateMe(ConfirmationResult confirmationResult, String otp) async {
    UserCredential userCredential = await confirmationResult.confirm(otp);
    userCredential.additionalUserInfo!.isNewUser
        ? printMessage("Successful Authentication")
        : printMessage("User already exists");
  }

  printMessage(String msg) {
    debugPrint(msg);
  }
}

Widget buildTextField(
        String labelText,
        TextEditingController textEditingController,
        IconData prefixIcons,
        BuildContext context) =>
    Padding(
      padding: const EdgeInsets.all(10.00),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: TextFormField(
          obscureText: labelText == "OTP" ? true : false,
          controller: textEditingController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(5.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(5.5),
            ),
            prefixIcon: Icon(prefixIcons, color: Colors.blue),
            hintText: labelText,
            hintStyle: const TextStyle(color: Colors.blue),
            filled: true,
            fillColor: Colors.blue[50],
          ),
        ),
      ),
    );

class PcLogin extends StatefulWidget {
  const PcLogin({super.key});

  @override
  State<PcLogin> createState() => _PcLoginState();
}

class _PcLoginState extends State<PcLogin> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController otp = TextEditingController();
  bool canShow = false;
  var temp;

  @override
  void dispose() {
    phoneNumber.dispose();
    otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        buildTextField("Phone Number", phoneNumber, Icons.phone, context),
        canShow
            ? buildTextField("OTP", otp, Icons.timer, context)
            : const SizedBox(),
        !canShow ? buildSendOTPBtn("Send OTP") : buildSubmitBtn("Submit"),
      ]),
    );
  }

  Widget buildSendOTPBtn(String text) => ElevatedButton(
        onPressed: () async {
          setState(() {
            canShow = !canShow;
          });
          temp = await FirebaseAuthentication().sendOTP(phoneNumber.text);
        },
        child: Text(text),
      );

  Widget buildSubmitBtn(String text) => ElevatedButton(
        onPressed: () {
          FirebaseAuthentication().authenticateMe(temp, otp.text);
        },
        child: Text(text),
      );
}





// class PcLogin extends StatefulWidget {
//   const PcLogin({super.key});

//   @override
//   State<PcLogin> createState() => _nameState();
// }

// class _nameState extends State<PcLogin> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 1440,
//       height: 1024,
//       clipBehavior: Clip.antiAlias,
//       decoration: BoxDecoration(color: Color(0xBFE6F3FF)),
//       child: Stack(
//         children: [
//           Positioned(
//             left: 595,
//             top: 0,
//             child: Container(
//               width: 845,
//               height: 1024,
//               child: Stack(
//                 children: [
//                   Positioned(
//                     left: 0,
//                     top: 0,
//                     child: Container(
//                       width: 845,
//                       height: 1024,
//                       decoration: ShapeDecoration(
//                         color: Color(0xFFFCFDFF),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(25),
//                             bottomLeft: Radius.circular(25),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 123,
//                     top: 124,
//                     child: Container(
//                       width: 600,
//                       height: 856,
//                       child: Stack(
//                         children: [
//                           Positioned(
//                             left: 152,
//                             top: 833,
//                             child: Text(
//                               'Reserved directs to Leo Barreto',
//                               style: TextStyle(
//                                 color: Color(0xFF7C838A),
//                                 fontSize: 20,
//                                 fontFamily: 'Roboto',
//                                 fontWeight: FontWeight.w400,
//                                 height: 0,
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 332,
//                             top: 694,
//                             child: Container(
//                               width: 220,
//                               height: 55,
//                               child: Stack(
//                                 children: [
//                                   Positioned(
//                                     left: 10,
//                                     top: 3,
//                                     child: Container(
//                                       width: 50,
//                                       height: 50,
//                                       decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                           image: NetworkImage(
//                                               "https://via.placeholder.com/50x50"),
//                                           fit: BoxFit.contain,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     left: 66,
//                                     top: 17,
//                                     child: SizedBox(
//                                       width: 138,
//                                       height: 21,
//                                       child: Text(
//                                         'Sing up with GitHub',
//                                         style: TextStyle(
//                                           color: Color(0xFF7C838A),
//                                           fontSize: 14,
//                                           fontFamily: 'Poppins',
//                                           fontWeight: FontWeight.w500,
//                                           height: 0,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     left: 0,
//                                     top: 0,
//                                     child: Container(
//                                       width: 220,
//                                       height: 55,
//                                       decoration: ShapeDecoration(
//                                         shape: RoundedRectangleBorder(
//                                           side: BorderSide(
//                                               width: 1,
//                                               color: Color(0xFF7C838A)),
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 31,
//                             top: 694,
//                             child: Container(
//                               width: 220,
//                               height: 55,
//                               child: Stack(
//                                 children: [
//                                   Positioned(
//                                     left: 7,
//                                     top: 3,
//                                     child: Container(
//                                       width: 50,
//                                       height: 50,
//                                       decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                           image: NetworkImage(
//                                               "https://via.placeholder.com/50x50"),
//                                           fit: BoxFit.contain,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     left: 66,
//                                     top: 17,
//                                     child: SizedBox(
//                                       width: 141,
//                                       height: 21,
//                                       child: Text(
//                                         'Sing up with Google',
//                                         style: TextStyle(
//                                           color: Color(0xFF7C838A),
//                                           fontSize: 14,
//                                           fontFamily: 'Poppins',
//                                           fontWeight: FontWeight.w500,
//                                           height: 0,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     left: 0,
//                                     top: 0,
//                                     child: Container(
//                                       width: 220,
//                                       height: 55,
//                                       decoration: ShapeDecoration(
//                                         shape: RoundedRectangleBorder(
//                                           side: BorderSide(
//                                               width: 1,
//                                               color: Color(0xFF7C838A)),
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 251,
//                             top: 640,
//                             child: Text(
//                               '- OR -',
//                               style: TextStyle(
//                                 color: Color(0xFFB0BAC3),
//                                 fontSize: 26,
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.w500,
//                                 height: 0,
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 2,
//                             top: 572,
//                             child: Text.rich(
//                               TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: 'Already have a account?',
//                                     style: TextStyle(
//                                       color: Color(0xFF7C838A),
//                                       fontSize: 18,
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.w400,
//                                       height: 0,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: ' ',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 18,
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.w400,
//                                       height: 0,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: 'Log in',
//                                     style: TextStyle(
//                                       color: Color(0xFFF9ED32),
//                                       fontSize: 18,
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.w400,
//                                       height: 0,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 121,
//                             top: 497,
//                             child: Container(
//                               width: 340,
//                               height: 60,
//                               child: Stack(
//                                 children: [
//                                   Positioned(
//                                     left: 0,
//                                     top: 0,
//                                     child: Container(
//                                       width: 340,
//                                       height: 60,
//                                       decoration: ShapeDecoration(
//                                         color: Color(0xFFF9ED32),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     left: 70,
//                                     top: 10,
//                                     child: SizedBox(
//                                       width: 215,
//                                       child: Text(
//                                         'Create Account',
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 26,
//                                           fontFamily: 'Poppins',
//                                           fontWeight: FontWeight.w500,
//                                           height: 0,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 0,
//                             top: 362,
//                             child: Container(
//                               width: 600,
//                               height: 95,
//                               child: Stack(
//                                 children: [
//                                   Positioned(
//                                     left: 2,
//                                     top: 0,
//                                     child: Text(
//                                       'Password',
//                                       style: TextStyle(
//                                         color: Color(0xFF7C838A),
//                                         fontSize: 20,
//                                         fontFamily: 'Poppins',
//                                         fontWeight: FontWeight.w500,
//                                         height: 0,
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     left: 0,
//                                     top: 30,
//                                     child: Container(
//                                       width: 600,
//                                       height: 65,
//                                       child: Stack(
//                                         children: [
//                                           Positioned(
//                                             left: 40,
//                                             top: 17,
//                                             child: Text(
//                                               'Enter your Password here',
//                                               style: TextStyle(
//                                                 color: Colors.black
//                                                     .withOpacity(0.5),
//                                                 fontSize: 20,
//                                                 fontFamily: 'Poppins',
//                                                 fontWeight: FontWeight.w400,
//                                                 height: 0,
//                                               ),
//                                             ),
//                                           ),
//                                           Positioned(
//                                             left: 0,
//                                             top: 0,
//                                             child: Container(
//                                               width: 600,
//                                               height: 65,
//                                               decoration: ShapeDecoration(
//                                                 color: Color(0x66B0BAC3),
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(20),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 0,
//                             top: 227,
//                             child: Container(
//                               width: 600,
//                               height: 95,
//                               child: Stack(
//                                 children: [
//                                   Positioned(
//                                     left: 2,
//                                     top: 0,
//                                     child: Text(
//                                       'Email',
//                                       style: TextStyle(
//                                         color: Color(0xFF7C838A),
//                                         fontSize: 20,
//                                         fontFamily: 'Poppins',
//                                         fontWeight: FontWeight.w500,
//                                         height: 0,
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     left: 0,
//                                     top: 30,
//                                     child: Container(
//                                       width: 600,
//                                       height: 65,
//                                       child: Stack(
//                                         children: [
//                                           Positioned(
//                                             left: 40,
//                                             top: 17,
//                                             child: Text(
//                                               'Enter your Email here',
//                                               style: TextStyle(
//                                                 color: Colors.black
//                                                     .withOpacity(0.5),
//                                                 fontSize: 20,
//                                                 fontFamily: 'Poppins',
//                                                 fontWeight: FontWeight.w400,
//                                                 height: 0,
//                                               ),
//                                             ),
//                                           ),
//                                           Positioned(
//                                             left: 0,
//                                             top: 0,
//                                             child: Container(
//                                               width: 600,
//                                               height: 65,
//                                               decoration: ShapeDecoration(
//                                                 color: Color(0x66B0BAC3),
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(20),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 0,
//                             top: 91,
//                             child: Container(
//                               width: 600,
//                               height: 95,
//                               child: Stack(
//                                 children: [
//                                   Positioned(
//                                     left: 2,
//                                     top: 0,
//                                     child: Text(
//                                       'Full Name',
//                                       style: TextStyle(
//                                         color: Color(0xFF7C838A),
//                                         fontSize: 20,
//                                         fontFamily: 'Poppins',
//                                         fontWeight: FontWeight.w500,
//                                         height: 0,
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     left: 0,
//                                     top: 30,
//                                     child: Container(
//                                       width: 600,
//                                       height: 65,
//                                       child: Stack(
//                                         children: [
//                                           Positioned(
//                                             left: 40,
//                                             top: 17,
//                                             child: Text(
//                                               'Enter your Fulll Name here',
//                                               style: TextStyle(
//                                                 color: Colors.black
//                                                     .withOpacity(0.5),
//                                                 fontSize: 20,
//                                                 fontFamily: 'Poppins',
//                                                 fontWeight: FontWeight.w400,
//                                                 height: 0,
//                                               ),
//                                             ),
//                                           ),
//                                           Positioned(
//                                             left: 0,
//                                             top: 0,
//                                             child: Container(
//                                               width: 600,
//                                               height: 65,
//                                               decoration: ShapeDecoration(
//                                                 color: Color(0x66B0BAC3),
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(20),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 131,
//                             top: 0,
//                             child: Text(
//                               'Create your Free Account',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 26,
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.w600,
//                                 height: 0,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
