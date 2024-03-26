import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/file_service.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:educ_ai_tion/widgets/custom_app_bar.dart';

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  final FileStorageService _storageService = FileStorageService();
final Reference storageRef =
      FirebaseStorage.instance.ref().child('selected_questions');

  late List<String> fileNames = [];

  @override
  void initState() {
    super.initState();
    getFileNames();
  }

  Future<void> getFileNames() async {
    try {
      ListResult result = await storageRef.listAll();
      setState(() {
        fileNames = result.items.map((item) => item.name).toList();
      });
    } catch (e) {
      print('Error fetching file names: $e');
    }
  }

  Future<void> downloadFile(String fileName) async {
    try {
      String downloadUrl = await storageRef.child(fileName).getDownloadURL();

      // Open the download URL in a new browser tab
      if (await canLaunch(downloadUrl)) {
        await launch(downloadUrl);
      } else {
        throw 'Could not launch $downloadUrl';
      }
    } catch (e) {
      print('Error downloading file: $e');
    }
  }
  // Store file names and their bytes
  Map<String, Uint8List> _pickedFilesBytes = {};
  Map<String, bool> _pickedFilesSelection = {};

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
      type: FileType.any, // Keep this to allow any file type
    );

    if (result != null) {
      for (var file in result.files) {
        final fileName = file.name ?? '';
        if (!_pickedFilesSelection.containsKey(fileName)) {
          _pickedFilesSelection[fileName] = false;
          _pickedFilesBytes[fileName] = file.bytes!;
        }
      }

      setState(() {});
    }
  }

  Future<void> _uploadToAI() async {
    if (_pickedFilesSelection.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No files selected")),
      );
      return;
    }

    var filesToUpload = _pickedFilesSelection.keys
        .where((name) => _pickedFilesSelection[name]!)
        .toList();

    if (filesToUpload.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No files selected to upload")),
      );
      return;
    }

    try {
      for (String fileName in filesToUpload) {
        Uint8List fileBytes =
            _pickedFilesBytes[fileName]!; // Use bytes directly
        await _storageService.uploadFile(fileName, fileBytes); // Upload file
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Uploaded file to Storage: $fileName")),
        );
        setState(() {
          _pickedFilesSelection.remove(fileName);
          _pickedFilesBytes.remove(fileName);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error uploading file: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Content'),
        backgroundColor: Colors.blue[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _pickedFilesSelection.length,
              itemBuilder: (context, index) {
                String fileName = _pickedFilesSelection.keys.elementAt(index);
                return CheckboxListTile(
                  title: Text(fileName),
                  value: _pickedFilesSelection[fileName],
                  onChanged: (bool? value) {
                    setState(() {
                      _pickedFilesSelection[fileName] = value!;
                    });
                  },
                  secondary: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _pickedFilesSelection.remove(fileName);
                        _pickedFilesBytes.remove(fileName);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: ListView.builder(
          itemCount: fileNames.length,
          itemBuilder: (context, index) {
            String fileName = fileNames[index];

            
          return Card(child: ListTile(title: Text(fileName),
              
              trailing: TextButton(
                onPressed: () => downloadFile(fileName),
                child: Text('Download'),
              ),),);
            
          },
        ),
      ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _pickFile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Pick a File'),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _uploadToAI,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Upload to Storage'),
            ),
          ),
        ],
      ),
    );
  }
}
