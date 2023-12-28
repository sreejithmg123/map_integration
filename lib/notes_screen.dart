import 'dart:async';
import 'package:dependency_injection/models/notes.dart';
import 'package:dependency_injection/ssembast_example.dart';
import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Note> notesList = [];
  bool isLoading = false;
  late Stream<List<Note>> noteStream;
  StreamSubscription<List<Note>>? _subscription;

  @override
  void initState() {
    super.initState();
    getAllNotes();
  }

  getAllNotes() async {
    // _subscription?.cancel();
    setState(() {
      isLoading = true;
    });

    final db = await SemDBExample().openDatabase(SemDBExample().notesDb);
    await SemDBExample().insertNote(
        Note(id: 1, title: 'title', content: 'content', isSelected: false), db);
    await SemDBExample().insertNote(
        Note(id: 2, title: 'title', content: 'content', isSelected: false), db);
    await SemDBExample().insertNote(
        Note(id: 3, title: 'title', content: 'content', isSelected: false), db);
    notesList = await SemDBExample().getAllNotes(db);
    SemDBExample().watchAllNotes(db);
    // _subscription = noteStream.listen((event) {});
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                return ValueListenableBuilder<List<Note>>(
                  valueListenable: SemDBExample().notesNotifier,
                  builder: (context, value, child) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: value.isNotEmpty
                              ? value[index].isSelected
                                  ? Colors.red
                                  : Colors.grey.shade500
                              : Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text('Title'),
                              const Spacer(),
                              Text(notesList[index].title)
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (value.isNotEmpty)
                                Text(value[index].isSelected
                                    ? 'Selected'
                                    : 'Select'),
                              const Spacer(),
                              TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    final db = await SemDBExample()
                                        .openDatabase(SemDBExample().notesDb);
                                    await SemDBExample().updateNote(
                                        Note(
                                            id: notesList[index].id,
                                            title: 'title',
                                            content: 'content',
                                            isSelected:
                                                !(value[index].isSelected)),
                                        db);
                                    await SemDBExample().watchAllNotes(db);
                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                  child: const Text('Update value'))
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
