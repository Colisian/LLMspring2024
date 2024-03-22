import 'package:educ_ai_tion/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 99, 3, 151),
        //title: Text('ESS'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap with SingleChildScrollView for vertical scrolling
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF3039E1),
                      Color(0xFF300D67),
                      Color(0xFF50017B)
                    ],
                  ),
                ),
                //gradient-----------------------------------------------------------
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 100), // Spacer between rows
                      Image.asset('assets/images/logo.PNG'),
                      const SizedBox(height: 20), // Spacer between rows
                      const Text(
                        'Welcome',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          color: Color(0xFFE4AEF2),
                        ),
                      ),

                      const SizedBox(height: 20),
                      const Text(
                        'The Ultimate AI Assistant in Academia',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFE4AEF2),
                        ),
                      ),

                      const SizedBox(height: 50),
                      // Container(
                      //     width: MediaQuery.of(context).size.width * 0.21,
                      //     child: const Text(
                      //       'Helping instructors harness the power of LLMs in education to foster deep learning in a revolutionary way.',
                      //       style: TextStyle(
                      //           fontSize: 16, color: Color(0xFFE4AEF2)),
                      //       maxLines: 3,
                      //     )
                      //     //Padding(
                      //     //  padding: EdgeInsets.only(left: 10),
                      //     // child: Container(
                      //     //width: MediaQuery.of(context).size.width * 0.3,
                      //     //keep lines of text to 2
                      //     //overflow: TextOverflow.ellipsis,
                      //     // ),
                      //     //   ),
                      //     ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          constraints: const BoxConstraints(
                              maxWidth: 200, minHeight: 40),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFD64951),
                                Color(0xFFFD0F60),
                                Color(0xFFD64951)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'login to ESS',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
