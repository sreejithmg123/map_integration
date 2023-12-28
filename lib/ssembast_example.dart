import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'models/notes.dart'; // For IO database

class SemDBExample {
  SemDBExample._privateConstructor();

  static final SemDBExample _instance = SemDBExample._privateConstructor();

  factory SemDBExample() {
    return _instance;
  }
  String yourDataBase = 'your_database.db';
  String notesDb = 'notes.db';

  ValueNotifier<List<Note>> notesNotifier = ValueNotifier<List<Note>>([]);

  Future<Database> openDatabase(String dbName) async {
    final dbPath = await getApplicationDocumentsDirectory();
    final database =
        await databaseFactoryIo.openDatabase(join(dbPath.path, dbName));

    return database;
  }

  Future<void> insertData(Database database, String key, String value) async {
    final store = StoreRef<String, String>.main();
    await store.record(key).put(database, value);
  }

  Future<String?> getData(Database database, String key) async {
    final store = StoreRef<String, String>.main();
    final value = await store.record(key).get(database);
    return value;
  }

  Future<void> insertNote(Note note, Database database) async {
    final store = intMapStoreFactory.store('notes');
    await store.add(database, note.toMap());
  }

  Future<List<Note>> getAllNotes(Database database) async {
    final store = intMapStoreFactory.store('notes');
    final snapshots = await store.find(database);
    return snapshots.map((snapshot) => Note.fromMap(snapshot.value)).toList();
  }

  watchAllNotes(Database database) async {
    final store = intMapStoreFactory.store('notes');
    final snapshots = await store.find(database);
    final notes =
        snapshots.map((snapshot) => Note.fromMap(snapshot.value)).toList();
    notesNotifier.value = notes;
    return notes;
  }

  Future<void> updateNote(Note updatedNote, Database database) async {
    final store = intMapStoreFactory.store('notes');
    await store.update(database, updatedNote.toMap(),
        finder: Finder(filter: Filter.byKey(updatedNote.id)));
  }

  Future<void> clearDatabase(Database database) async {
    final store = intMapStoreFactory.store('notes');
    await store.delete(database);
  }

}
