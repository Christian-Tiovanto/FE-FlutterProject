import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FilepickerWidget extends StatefulWidget {
  const FilepickerWidget({Key? key});

  @override
  State<FilepickerWidget> createState() => _FilepickerWidgetState();
}

class _FilepickerWidgetState extends State<FilepickerWidget> {
  List<Map<String, String>> _pdfFiles = [];
  String? _errorMessage;

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        // Get file path
        String filePath = result.files.single.path!;
        String fileName = result.files.single.name;

        // Debug prints
        print("File path: $filePath");
        print("File name: $fileName");

        // Add file details to the list
        setState(() {
          _pdfFiles.add({'name': fileName, 'path': filePath});
        });

        // Debug prints
        print("Files: $_pdfFiles");
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Picker Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_errorMessage != null)
              Text(
                'Error: $_errorMessage',
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Pick PDF File'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _pdfFiles.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'File: ${_pdfFiles[index]['name']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Path: ${_pdfFiles[index]['path']}',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(home: FilepickerWidget()));
// }
