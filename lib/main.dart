// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:quotes_app/widgets/card_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Quotes(),
    );
  }
}

class Quotes extends StatefulWidget {
  const Quotes({Key? key}) : super(key: key);

  @override
  State<Quotes> createState() => _QuotesState();
}

// a class for the quote data (title, author)
class Quotesdata {
  String title;
  String author;
  Quotesdata({required this.title, required this.author}); // constractor
}

class _QuotesState extends State<Quotes> {

  // List for all quotes
  List allQuotes = [
    Quotesdata(title: "تنفس الهواء !", author: "اندرو تيت"),
    Quotesdata(title: "تحيا مصر", author: "اسامة احمد"),
    Quotesdata(title: "طز في الكليه", author: "مجهول"),
  ];

  // to delete data from list when clicked on the icon in the card widget
  delete(Quotesdata item) {
    setState(() {
      allQuotes.remove(item);
    });
  }

  // to add new data to the list when clicked on the textbutton in the modelbottomsheet in the floatingactionbutton
  add() {
    setState(() {
      allQuotes.add(
          Quotesdata(title: myController1.text, author: myController2.text));
    });
  }

  // to get the input text from both textfileds and put it as a data using the datatype we created
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.all(22),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: myController1,
                          decoration: InputDecoration(hintText: "Quote"),
                          maxLength: 50,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: myController2,
                          decoration: InputDecoration(hintText: "Author"),
                          maxLength: 25,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              add();
                            },
                            child: Text(
                              "Add Quote",
                              style: TextStyle(fontSize: 20),
                            ))
                      ],
                    ),
                  );
                });
          },
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 50, 57, 121),
          title: Text(
            "Best Quotes",
            style: TextStyle(fontSize: 27),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ...allQuotes.map((item) => CardWidget(
                    // to pass the item inside the list to "card_widget.dart"
                    item: item,
                    // to pass the delete function to "card_widget.dart"
                    delete: delete,
                  ))
            ],
          ),
        ));
  }
}
