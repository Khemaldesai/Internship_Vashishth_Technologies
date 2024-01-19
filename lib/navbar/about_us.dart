import 'package:expense/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('About Us')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('images/expense_logo.png'),
                // Replace 'assets/app_logo.png' with the actual path to your app logo
              ),
              SizedBox(height: 20),
              Text(
                'Expense Manager',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Version 1.0.0',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'A simple and efficient way to manage your expenses. '
                'Expense Manager helps you track your spending and stay '
                'organized financially.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Contact Us:',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Email: contact@expensemanager.com',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Phone: +917045781652',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        // Back button to navigate back to home_page.dart
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const HomePage()));
          },
          child: Icon(Icons.arrow_back),
        ),
        // Align the FloatingActionButton to the top-left corner
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      ),
    );
  }
}
