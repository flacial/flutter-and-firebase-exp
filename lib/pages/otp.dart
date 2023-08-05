import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key, required this.phoneNumber, required this.otpId});

  final FirebaseAuth auth = FirebaseAuth.instance;

  final String phoneNumber;
  final String otpId;
  final defaultPinTheme = PinTheme(
    width: 46,
    height: 50,
    textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black12),
      borderRadius: BorderRadius.circular(12),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Expanded(
          child: Column(
            children: [
              const SizedBox(height: 200),
              const Text('Enter OTP code sent to your phone number'),
              const SizedBox(height: 20),
              Pinput(
                onCompleted: (pin) async {
                  // throw pin

                  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: otpId, smsCode: pin);

                  await auth.signInWithCredential(credential);
                },
                length: 6,
                defaultPinTheme: defaultPinTheme,
              ),
            ],
          ),
        ),
      )),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'OTP Verification',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
