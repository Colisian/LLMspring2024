import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:educ_ai_tion/models/assignment_submission.dart';
import 'package:educ_ai_tion/services/assignment_submission_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class HomeworkFileList extends StatefulWidget {
  const HomeworkFileList({Key? key}) : super(key: key);

  @override
  _HomeworkFileState createState() => _HomeworkFileState();
}

class _HomeworkFileState extends State<HomeworkFileList> {
  final TextEditingController _fileContentController = TextEditingController();
  List<String> fileNames = [];
  String? selectedFile;
  int _numOfLines = 1; // Default to 1 line

  @override
  void initState() {
    super.initState();
    _fetchFileNames();
  }

  Future<void> _fetchFileNames() async {
    try {
      final Reference storageRef =
          FirebaseStorage.instance.ref().child('selected_questions');
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
          _numOfLines = lines > 10 ? lines : 10; // Ensure a minimum size
        });
      } else {
        _showSnackBar('Failed to load file content');
      }
    } catch (e) {
      _showSnackBar('Error fetching file content: $e');
    }
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
                hintText: 'Answers will be displayed here',
                border: OutlineInputBorder(),
              ),
              readOnly: true, // Set to false if you want users to edit inside
            ),
          ],
        ),
      ),
    );
  }
}
