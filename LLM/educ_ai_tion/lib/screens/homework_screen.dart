import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:educ_ai_tion/models/assignment_submission.dart';
import 'package:educ_ai_tion/services/assignment_submission_data.dart';

class HomeworkFileList extends StatefulWidget {
  const HomeworkFileList({Key? key});

  @override
  _HomeworkFileState createState() => _HomeworkFileState();
}

class _HomeworkFileState extends State<HomeworkFileList> {
  final TextEditingController _controllerOne = TextEditingController();
  final TextEditingController _controllerTwo = TextEditingController();
  final TextEditingController _controllerThree = TextEditingController();
  final TextEditingController _controllerFour = TextEditingController();
  final TextEditingController _controllerFive = TextEditingController();

  final Reference storageRef =
      FirebaseStorage.instance.ref().child('selected_questions');
  List<String> fileNames = [];
  String? selectedFile;

  final AssignmentData _assignmentData = AssignmentData();

  @override
  void initState() {
    super.initState();
    _fetchFileNames();
    _populateUserDetails();
  }

  Future<void> _populateUserDetails() async {
    try {
      // Get the current user's email from Firebase Auth
      String? email = FirebaseAuth.instance.currentUser?.email;
      if (email != null) {
        // Query Firestore for the user's data based on their email
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(email)
            .get();
        if (snapshot.exists) {
          // If user exists, populate the first and last name fields
          setState(() {
            _controllerTwo.text = snapshot['firstName'] ?? '';
            _controllerThree.text = snapshot['lastName'] ?? '';
            _controllerFour.text = email;
          });
        }
      }
    } catch (e) {
      _showSnackBar('Error populating user details: $e');
    }
  }

  Future<void> _fetchFileNames() async {
    try {
      final result = await storageRef.listAll();
      final names = result.items
          .map((item) => item.name)
          .where((name) => name.endsWith('.txt'))
          .toList();
      setState(() {
        fileNames = names;
      });
    } catch (e) {
      _showSnackBar('Error fetching file names: $e');
    }
  }

  Future<void> _fetchFileContent(String fileName) async {
    try {
      final downloadUrl = await storageRef.child(fileName).getDownloadURL();
      final response = await http.get(Uri.parse(downloadUrl));

      if (response.statusCode == 200) {
        // If the server returns an OK response, update the text controller
        setState(() {
          _controllerOne.text = response.body;
        });
      } else {
        // If the server did not return an OK response, throw an error
        _showSnackBar('Failed to load file content');
      }
    } catch (e) {
      _showSnackBar('Error fetching file content: $e');
    }
  }

  Future<void> _saveSubmission() async {
    try {
      String firstName = _controllerTwo.text.trim();
      String lastName = _controllerThree.text.trim();
      String assignmentName = selectedFile ?? '';
      String studentEmail = _controllerFour.text.trim();

      AssignmentSubmission submission = AssignmentSubmission(
        assignmentName: assignmentName,
        studentName: '$firstName $lastName',
        studentEmail: studentEmail,
        answers: _controllerFive.text.trim(),
        submissionDateTime: DateTime.now(),
      );

      await _assignmentData.addAssignmentSubmission(submission);
      _showSnackBar('Submission saved to Firebase');
      _clearFields();
    } catch (e) {
      _showSnackBar('Error saving submission');
    }
  }

  void _clearFields() {
    _controllerOne.clear();
    _controllerTwo.clear();
    _controllerThree.clear();
    _controllerFour.clear();
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View and Submit Homework'),
        backgroundColor: Color.fromARGB(255, 100, 34, 153),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Assignment Questions:"),
            DropdownButton<String>(
              value: selectedFile,
              hint: Text('Select a file'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedFile = newValue;
                  _fetchFileContent(newValue!);
                });
              },
              items: fileNames.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text('File Content:'),
            TextField(
              controller: _controllerOne,
              decoration: InputDecoration(
                hintText: 'File content will be displayed here',
              ),
              maxLines: 10,
              readOnly: true,
            ),
            SizedBox(height: 10),
            Text('First Name:'),
            TextField(
              controller: _controllerTwo,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Enter your first name',
              ),
            ),
            SizedBox(height: 10),
            Text('Last Name:'),
            TextField(
              controller: _controllerThree,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Enter your last name',
              ),
            ),
            SizedBox(height: 10),
            Text('Student Email:'),
            TextField(
              controller: _controllerFour,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(height: 10),
            Text('Enter Answers:'),
            TextField(
              controller: _controllerFive,
              decoration: InputDecoration(
                hintText: 'Enter your answers',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveSubmission,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 92, 20, 224),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Save Submission'),
            ),
          ],
        ),
      ),
    );
  }
}
