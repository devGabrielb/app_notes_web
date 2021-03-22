import 'package:flutter/material.dart';
import 'package:notes_app/home/models/note-model.dart';

class NotesWidget extends StatelessWidget {
  final Size size;
  final NoteModel note;

  const NotesWidget({Key key, this.size, this.note}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      width: size.width > 780 ? (size.width / 2) - 20 : size.width - 60,
      height: size.height / 5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.blue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value) {},
                          checkColor: Colors.white.withOpacity(0.4)),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            note.title,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.edit, color: Colors.white.withOpacity(0.4)),
                        Icon(Icons.delete,
                            color: Colors.white.withOpacity(0.4)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(note.description,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, color: Colors.white)),
          )),
        ],
      ),
    );
  }
}
