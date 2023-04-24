import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noted/CreateNote.dart';
import 'package:noted/services/crud.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = CrudMethods();

  late QuerySnapshot notesSnapshot;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    crudMethods.getData().then((result) {
      notesSnapshot = result;
    });
  }

   List items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Not', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              'ed',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToCreateNote,
        backgroundColor: Colors.blue,
        label: const Text('Create Note',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),

      //Had to use Streambuilder to get the snapshot data

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('notes').snapshots(),
        builder: (buildContext, snapshot) {
          List<ListTile> notesWidgets = [];

          if(snapshot.hasData) {
            final notes = snapshot.data?.docs.reversed.toList();

            for(var note in notes!) {
              int? index = snapshot.data?.docs.indexOf(note);
              final noteWidget = ListTile(
                leading: CircleAvatar(child: Text('${1 + index!}'),),
                title: Text(note['title']),
                subtitle: Text(note['description']),
              );
              notesWidgets.add(noteWidget);
            }
          }

          return ListView(
            children: notesWidgets,
          );
        },
      ),
    );
  }

  navigateToCreateNote() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateNote(),
        ));
  }
}

class NoteTile extends StatelessWidget {
  String title, description;

  NoteTile({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Text('1'),),
      title: Text(title),
      subtitle: Text(description),
    );
  }
}

