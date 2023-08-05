import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatapp/pages/otp.dart';
import 'package:flutterchatapp/widgets/button.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final numberController = TextEditingController();

  final _firebaseAuth = FirebaseAuth.instance;

  _handleOnPress() async {
    if (_formKey.currentState!.validate()) {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+971${numberController.text}',
        verificationCompleted: (PhoneAuthCredential credential) {
          print('Verified user');
          print('Verified user');
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Something went wrong');
          print('Something went wrong');
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpPage(phoneNumber: numberController.text, otpId: verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: numberController,
            decoration: InputDecoration(labelText: 'Phone number', hintText: '+971xxxxx'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }

              if (value.length < 10 || value.length > 10) {
                return 'Enter a valid phone number e.g, 0501231234';
              }

              if (value.substring(0, 2) != '05') {
                return 'Enter a valid phone number that starts with 05x';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: CustomButton(onPress: _handleOnPress, title: 'Continue'),
          )
        ],
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(children: [
          Text(
            'Sign in'.toUpperCase(),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Expanded(
            child: Column(children: [
              MyCustomForm(),
            ]),
          )
        ]),
      ),
    )));
  }
}
