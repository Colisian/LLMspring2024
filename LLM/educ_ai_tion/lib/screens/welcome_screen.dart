import 'package:educ_ai_tion/screens/login_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Educ-AI-tion'),
      ),
      body: SafeArea(
              child: SingleChildScrollView( child: Stack()
                
                
          // Wrap with SingleChildScrollView for vertical scrolling
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100), // Spacer between rows
                // First Row
                SizedBox(
                  width: screenWidth * 0.9, // 90% of screen width
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // First Column
                      SizedBox(
                        width: screenWidth * 0.4, // 40% of screen width
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //logo------------------------------------------------
                          children: <Widget>[
                            Image.asset('assets/images/logo.PNG'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Spacer between rows
                // Second Row

                SizedBox(
                  width: screenWidth * 0.9, // 90% of screen width
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // First Column
                      SizedBox(
                        width: screenWidth * 0.4, // 40% of screen width
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                                'assets/images/home_image_empTeacher.PNG'),
                          ],
                        ),
                      ),
                      // Second Column
                      SizedBox(
                        width: screenWidth * 0.4, // 40% of screen width
                        child: const Column(
                          children: <Widget>[
                            Text('Welcome',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Color(0xFFE4AEF2),
                                )),
                            Text('The Ultimate AI Assistant in Academia',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFE4AEF2),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Spacer between rows
                // third Row

                SizedBox(
                  width: screenWidth * 0.9, // 90% of screen width
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // First Column
                      SizedBox(
                        width: screenWidth * 0.5, // 40% of screen width
                        child: const Column(
                          children: <Widget>[
                            Text(
                                'Helping instructors harness the power of LLMs in education to provide individualized instruction that fosters deep learning in a revolutionary way.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFE4AEF2),
                                )),
                            Text('Efficieve time for teachers..'),
                          ],
                        ),
                      ),
                      // Second Column
                      SizedBox(
                        width: screenWidth * 0.4, // 40% of screen width
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                                'assets/images/home_image_createInteractive.PNG'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Spacer between rows
                // fourth Row
                SizedBox(
                  width: screenWidth * 0.9, // 90% of screen width
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              // Navigate to student login page
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          child: const Text('login to ESS'),
                          style: ElevatedButton.styleFrom()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }
}
