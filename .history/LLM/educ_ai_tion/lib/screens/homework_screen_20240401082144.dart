import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educ_ai_tion/models/assignment_submission.dart';
import 'package:educ_ai_tion/services/assignment_submission_data.dart';

class HomeworkFileList extends StatefulWidget {
  const HomeworkFileList({Key? key}) : super(key: key);

  @override
  _HomeworkFileState createState() => _HomeworkFileState();
}

class _HomeworkFileState extends State<HomeworkFileList> {
  final TextEditingController _fileContentController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  List<String> fileNames = [];
  String? selectedFile;
  int _numOfLines = 1; // Default to 1 line

  final AssignmentData _assignmentData = AssignmentData();

  @override
  void initState() {
    super.initState();
    _fetchFileNames();
    _populateUserDetails();
  }

  Future<void> _populateUserDetails() async {
    try {
      String? email = FirebaseAuth.instance.currentUser?.email;
      if (email != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(email)
            .get();
        setState(() {
          _firstNameController.text = userDoc['firstName'] ?? '';
          _lastNameController.text = userDoc['lastName'] ?? '';
          _emailController.text = email;
        });
      }
    } catch (e) {
      _showSnackBar('Error fetching user details: $e');
    }
  }

  Future<void> _fetchFileNames() async {
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('selected_questions');
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
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('selected_questions/$fileName');
    try {
      final downloadUrl = await storageRef.getDownloadURL();
      final response = await http.get(Uri.parse(downloadUrl));

      if (response.statusCode == 200) {
        final lines = '\n'.allMatches(response.body).length + 1;
        setState(() {
          _fileContentController.text = response.body;
          _numOfLines = math.max(lines, 10); // Corrected to use math.max
        });
      } else {
        _showSnackBar('Failed to load file content');
      }
    } catch (e) {
      _showSnackBar('Error fetching file content: $e');
    }
  }

  Future<void> _saveSubmission() async {
    try {
      AssignmentSubmission submission = AssignmentSubmission(
        assignmentName: selectedFile ?? '',
        studentName:
            '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}',
        studentEmail: _emailController.text.trim(),
        answers: _fileContentController.text.trim(),
        submissionDateTime: DateTime.now(),
      );

      await _assignmentData.addAssignmentSubmission(submission);
      _showSnackBar('Submission saved to Firebase');
      _clearFields();
    } catch (e) {
      _showSnackBar('Error saving submission: $e');
    }
  }

  void _clearFields() {
    _fileContentController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
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
      body: SingleChildScrollView(
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
                });
              },
              items: fileNames.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedFile != null) {
                  _fetchFileContent(selectedFile!);
                }
              },
              child: Text('Input Answers'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _fileContentController,
              maxLines: _numOfLines,
              decoration: InputDecoration(
                hintText:
                    'Assignment will be loaded here. Please input your answer following each specific question.',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text("First Name:"),
            TextField(controller: _firstNameController, readOnly: true),
            SizedBox(height: 20),
            Text("Last Name:"),
            TextField(controller: _lastNameController, readOnly: true),
            SizedBox(height: 20),
            Text("Email:"),
            TextField(controller: _emailController, readOnly: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveSubmission,
              child: Text('Save Submission'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _clearFields,
              child: Text('Clear Fields'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
