import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_app/home/controllers/home-controller.dart';
import 'package:notes_app/home/models/note-model.dart';
import 'package:notes_app/home/widgets/categories/category-controller.dart';
import 'package:notes_app/home/widgets/categories/category-list-widget.dart';
import 'package:notes_app/home/widgets/notes-widget.dart';
import 'package:notes_app/home/widgets/search-widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController _homeController = GetIt.I<HomeController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: size.width < 750
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DialogAdd();
                    });
              },
              child: Center(
                child: Icon(Icons.add),
              ),
            )
          : null,
      body: Container(
        color: Color(0xFFF5F5F5),
        width: size.width,
        height: size.height,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800),
            child: LayoutBuilder(
              builder: (_, constraints) {
                return Container(
                  padding: EdgeInsets.only(top: constraints.maxHeight * 0.1),
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SearchWidget(),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        Container(
                          width: constraints.maxWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxHeight: 70),
                                      child: CategoryListWidget())),
                              constraints.maxWidth > 750
                                  ? Material(
                                      borderRadius: BorderRadius.circular(5),
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return DialogAdd();
                                              });
                                        },
                                        child: Container(
                                          width: 140,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.add,
                                                    color: Colors.white),
                                                Text(
                                                  "Add Note",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        Container(
                          width: constraints.maxWidth,
                          margin: EdgeInsets.only(top: 20),
                          child: ValueListenableBuilder(
                              valueListenable: _homeController.listNotes,
                              builder: (context, value, _) {
                                return _homeController.listNotes.value.length >
                                        0
                                    ? Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        direction: constraints.maxWidth > 750
                                            ? Axis.horizontal
                                            : Axis.vertical,
                                        alignment: WrapAlignment.spaceBetween,
                                        children: List.generate(
                                            _homeController
                                                .listNotes.value.length,
                                            (index) => NotesWidget(
                                                  size: Size(
                                                      constraints.maxWidth,
                                                      constraints.maxHeight),
                                                  note: _homeController
                                                      .listNotes.value[index],
                                                )))
                                    : Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Text(
                                                "You Don't have any notes",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(top: 20),
                                                child: SvgPicture.asset(
                                                  "emptynotes.svg",
                                                  width: constraints.maxWidth,
                                                  height:
                                                      constraints.maxHeight / 2,
                                                )),
                                          ],
                                        ),
                                      );
                                ;
                              }),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class DialogAdd extends StatefulWidget {
  @override
  _DialogAddState createState() => _DialogAddState();
}

class _DialogAddState extends State<DialogAdd> {
  final _formKey = GlobalKey<FormState>();
  CategoryController _categoryController = GetIt.I<CategoryController>();
  HomeController _homeController = GetIt.I<HomeController>();

  String dropDownValue;
  var noteModel = NoteModel();
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 800,
        maxHeight: 500,
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 10, bottom: 20, left: 40),
                  width: constraints.maxWidth,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Add Note",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  )),
              Divider(
                height: 3,
                color: Colors.grey,
              ),
              Form(
                key: _formKey,
                child: Container(
                    width: constraints.maxWidth,
                    padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: constraints.maxHeight - 100,
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        fillColor: Colors.grey.withOpacity(0.4),
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.4)),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        hintText: "Add Title..."),
                                    onSaved: (String title) {
                                      this.noteModel.title = title;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 200,
                                  child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    expands: true,
                                    textAlignVertical: TextAlignVertical.top,
                                    decoration: InputDecoration(
                                        fillColor: Colors.grey.withOpacity(0.4),
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.4)),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        hintText: "Add Descrition..."),
                                    onSaved: (String description) {
                                      this.noteModel.description = description;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: constraints.maxWidth * 0.03),
                        Expanded(
                            flex: 1,
                            child: Container(
                              height: constraints.maxHeight - 96,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: DropdownButton<String>(
                                      underline: null,
                                      hint: Text("Select Category"),
                                      value: dropDownValue ?? null,
                                      isExpanded: true,
                                      onChanged: (String v) {
                                        setState(() {
                                          dropDownValue = v;
                                        });
                                      },
                                      items: _categoryController.listCategory
                                          .map((String e) {
                                        return DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(e),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * 0.5,
                                  ),
                                  Container(
                                    width: constraints.maxWidth * 0.25,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Material(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              height: 30,
                                              width: constraints.maxWidth * 0.1,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.blue),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Material(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: InkWell(
                                            onTap: () {
                                              noteModel.category =
                                                  dropDownValue;
                                              _formKey.currentState.save();
                                              _homeController
                                                  .createNote(this.noteModel);
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              height: 30,
                                              width: constraints.maxWidth * 0.1,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Add",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.blue),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    )),
              ),
              Container()
            ],
          ),
        );
      }),
    ));
  }
}
