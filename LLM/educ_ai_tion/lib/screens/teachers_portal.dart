import 'package:educ_ai_tion/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'question_generator_screen.dart';
import 'generated_questions_screen.dart';
import 'file_upload_screen.dart';
import 'grade_screen.dart';
import 'question_file_list.dart';
import 'question_display_screen.dart';
import 'suggest_activity.dart';

// Teacher's Portal
class TeachersPortal extends StatefulWidget {
const TeachersPortal({super.key});
  @override
  _TeachersPortalState createState() => _TeachersPortalState();
}

class _TeachersPortalState extends State<TeachersPortal> {
   @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Teacher \'s Portal',
          onMenuPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
drawer: const DrawerMenu(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // For tablets or larger screens
            return _buildTabletOrLargeScreenLayout();
          } else {
            // For smaller screens
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Widget _buildTabletOrLargeScreenLayout() {
    return Container(
      color: Colors.lightBlue[100],
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
           MaterialButton(
  padding: EdgeInsets.all(8.0),
  textColor: Colors.black, // Black text color
  splashColor: Colors.greenAccent,
  elevation: 8.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25.0), // More rounded corners
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionGeneratorScreen(),
      ),
    );
  },
  child: Container(
    width: 300, // Adjust the width to one third of the original size
    height: 240, // Adjust the height to one third of the original size
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0), // More rounded corners for the image container
      border: Border.all(color: Colors.black, width: 2.0), // Dark border around the image
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end, // Align text at the bottom
      crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch text to fill container width
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25.0), // Clip the image container with rounded corners
          child: Image.asset(
            'assets/images/assignment_icon.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.lightBlue, // White background for text
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ), // Apply rounded corners only to the bottom
          ),
          child: Text(
            'Generate Questions',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black, // Black text color
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  ),
),
   
           MaterialButton(
  padding: EdgeInsets.all(8.0),
  textColor: Colors.black, // Black text color
  splashColor: Colors.greenAccent,
  elevation: 8.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25.0), // More rounded corners
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionDisplayScreen(),
      ),
    );
  },
  child: Container(
    width: 300, // Adjust the width to one third of the original size
    height: 240, // Adjust the height to one third of the original size
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0), // More rounded corners for the image container
      border: Border.all(color: Colors.black, width: 2.0), // Dark border around the image
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end, // Align text at the bottom
      crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch text to fill container width
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25.0), // Clip the image container with rounded corners
          child: Image.asset(
            'assets/images/answer_key_icon.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.lightBlue, // White background for text
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ), // Apply rounded corners only to the bottom
          ),
          child: Text(
            'Generate Key',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black, // Black text color
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  ),
),
   
           MaterialButton(
  padding: EdgeInsets.all(8.0),
  textColor: Colors.black, // Black text color
  splashColor: Colors.greenAccent,
  elevation: 8.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25.0), // More rounded corners
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionDisplayScreen(),
      ),
    );
  },
  child: Container(
    width: 300, // Adjust the width to one third of the original size
    height: 240, // Adjust the height to one third of the original size
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0), // More rounded corners for the image container
      border: Border.all(color: Colors.black, width: 2.0), // Dark border around the image
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end, // Align text at the bottom
      crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch text to fill container width
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25.0), // Clip the image container with rounded corners
          child: Image.asset(
            'assets/images/activity_icon.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.lightBlue, // White background for text
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ), // Apply rounded corners only to the bottom
          ),
          child: Text(
            'Study Activity',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black, // Black text color
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  ),
),
             
            ],
          ),
          Expanded(
            child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
           MaterialButton(
  padding: EdgeInsets.all(8.0),
  textColor: Colors.black, // Black text color
  splashColor: Colors.greenAccent,
  elevation: 8.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25.0), // More rounded corners
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SuggestScreen(),
      ),
    );
  },
  child: Container(
    width: 300, // Adjust the width to one third of the original size
    height: 240, // Adjust the height to one third of the original size
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0), // More rounded corners for the image container
      border: Border.all(color: Colors.black, width: 2.0), // Dark border around the image
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end, // Align text at the bottom
      crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch text to fill container width
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25.0), // Clip the image container with rounded corners
          child: Image.asset(
            'assets/images/suggest_activity_icon.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.lightBlue, // White background for text
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ), // Apply rounded corners only to the bottom
          ),
          child: Text(
            'Activity Suggestions',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black, // Black text color
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  ),
),
   
           MaterialButton(
  padding: EdgeInsets.all(8.0),
  textColor: Colors.black, // Black text color
  splashColor: Colors.greenAccent,
  elevation: 8.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25.0), // More rounded corners
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GradingScreen(),
      ),
    );
  },
  child: Container(
    width: 300, // Adjust the width to one third of the original size
    height: 240, // Adjust the height to one third of the original size
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0), // More rounded corners for the image container
      border: Border.all(color: Colors.black, width: 2.0), // Dark border around the image
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end, // Align text at the bottom
      crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch text to fill container width
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25.0), // Clip the image container with rounded corners
          child: Image.asset(
            'assets/images/grade_icon.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.lightBlue, // White background for text
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ), // Apply rounded corners only to the bottom
          ),
          child: Text(
            'Grade Assignments',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black, // Black text color
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  ),
),
   
           MaterialButton(
  padding: EdgeInsets.all(8.0),
  textColor: Colors.black, // Black text color
  splashColor: Colors.greenAccent,
  elevation: 8.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25.0), // More rounded corners
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionFileList(),
      ),
    );
  },
  child: Container(
    width: 300, // Adjust the width to one third of the original size
    height: 240, // Adjust the height to one third of the original size
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0), // More rounded corners for the image container
      border: Border.all(color: Colors.black, width: 2.0), // Dark border around the image
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end, // Align text at the bottom
      crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch text to fill container width
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25.0), // Clip the image container with rounded corners
          child: Image.asset(
            'assets/images/resources_icon.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.lightBlue, // White background for text
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ), // Apply rounded corners only to the bottom
          ),
          child: Text(
            'Resources',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black, // Black text color
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  ),
           ),
          ], 
          ),
            ], 
          ),
          ), 
          ], 
          ),   
);
   
  }

  Widget _buildMobileLayout() {
    return Container(
      color: Colors.lightBlue[100],
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 150,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuestionGeneratorScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text('Generate Questions'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FileUploadScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text('Upload File'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SuggestScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text('Activity Suggestions'),
          ),
          ElevatedButton(
            onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GradingScreen()),
                  );},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text('Grade'),
          ),
          ElevatedButton(
            onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuestionFileList()),
                  );},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text('Archives'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuestionDisplayScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text('Archives'),
          ),
           MaterialButton(
        padding: EdgeInsets.all(8.0),
        textColor: Colors.white,
        splashColor: Colors.greenAccent,
        elevation: 8.0,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/resources_icon.png'),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Resources"),
          ),
        ),
        // ),
        onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuestionDisplayScreen()),
              );
        },
      ),
        ],
      ),
    );
  }
}
