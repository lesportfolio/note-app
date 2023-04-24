import 'package:flutter/material.dart';
import 'package:noted/services/crud.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key? key}) : super(key: key);

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String title, description;
    bool _isLoading = false;

    CrudMethods crudMethods = CrudMethods();

    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    uploadNote() async{
      Map<String, String> noteMap = {
        'title': titleController.text,
        'description': descController.text,
      };
      
      crudMethods.addData(noteMap).then((result) {
        Navigator.pop(context);
        showSuccessMessage('Note created successfully!');
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create Note',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          //title field
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: 'Note Title',
              border: inputBorder,
              focusedBorder: inputBorder,
              enabledBorder: inputBorder,
              filled: true,
              //contentPadding: const EdgeInsets.all(8),
            ),
            onChanged: (val) {
              title = val;
            },
          ),

          const SizedBox(
            height: 8.0,
          ),
          //description field
          TextField(
            controller: descController,
            decoration: const InputDecoration(
              hintText: 'Note Description',
              border: InputBorder.none,
              filled: true,
              //contentPadding: const EdgeInsets.all(8),
            ),
            onChanged: (val) {
              description = val;
            },
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),

          const SizedBox(
            height: 12.0,
          ),

          ElevatedButton(
            onPressed: uploadNote,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Create', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
