import 'package:expense/login_singup/login_page.dart';
import 'package:expense/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SplashScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      //Appbar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Welcome to Expense Manager',
          ),
        ),
      ),

      body: Stack(
        children: [
          AnimatedPositioned(
              duration: Duration(seconds: 1),
              top: mq.height * 0.15,
              width: mq.width * 0.5,
              right: _isAnimate ? mq.width * 0.25 : -mq.width * 0.5,
              child: Image.asset('images/expense_logo.png')),
          Positioned(
            bottom: mq.height * 0.15,
            width: mq.width * 0.9,
            left: mq.width * 0.05,
            height: mq.height * 0.08,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 217, 247, 184),
                  shape: StadiumBorder(),
                  elevation: 1,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => LoginPage()));
                },
                icon: Image.asset(
                  'images/login.png',
                  height: mq.height * 0.03,
                ),
                label: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                      TextSpan(
                          text: 'Expense Manager',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ]))),
          )
        ],
      ),

      //Floating button to add new user
    );
  }
}
