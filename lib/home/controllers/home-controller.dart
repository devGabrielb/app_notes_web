import 'package:flutter/material.dart';
import 'package:notes_app/home/models/note-model.dart';

class HomeController {
  final listNotes = ValueNotifier<List<NoteModel>>([]);
  final filterlistNotes = ValueNotifier<List<NoteModel>>([]);

  void getNotes(String category) {
    if (category != 'All') {
      listNotes.value = listNotes.value
          .where((element) => element.category == category)
          .toList();
    }
  }

  createNote(NoteModel noteModel) {
    listNotes.value = List.from(listNotes.value..add(noteModel));
  }
}
