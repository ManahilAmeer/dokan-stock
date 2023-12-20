// ignore_for_file: empty_constructor_bodies

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: AddUser('name',9,9,9),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

   return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Name for stock item'),
                    controller: myController,
              )),
              ElevatedButton(onPressed: (){
                AddUser('Joe', 8, 9, 8);
              }, child: Text('Add new stock'))
        ])
        // Column(
        //   children: [
        //     Text('A random idea:'),
        //     Text(appState.current.asLowerCase),

        //      
        );
  }
}

class DropDownButtonForStock extends StatefulWidget {
  DropDownButtonForStock({super.key});

  @override
  State<DropDownButtonForStock> createState() {
    return _DropDownButtonForStockState();
  }
}

class _DropDownButtonForStockState extends State<DropDownButtonForStock> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.earbuds_battery),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class AddUser extends StatelessWidget {
  final String fullName;
  final int Amount;
  final int Wieght;
  final int Rate;

  AddUser(this.fullName, this.Amount, this.Wieght, this.Rate);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('stock');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users.doc('Stock')
          .set({
            'Name': fullName, // John Doe
            'Amount': Amount, // Stokes and Sons
            'Wieght': Wieght, // 42
            'Rate': Rate // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addUser,
      child: Text(
        "Add Stock",
      ),
    );
  }
}

// Define a custom Form widget.
class NewStockForm extends StatefulWidget {
  const NewStockForm({super.key});

  @override
  State<NewStockForm> createState() => _NewStockFormState();
}

class _NewStockFormState extends State<NewStockForm> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Name for stock item'),
                    controller: myController,
              ))
        ])
        // Column(
        //   children: [
        //     Text('A random idea:'),
        //     Text(appState.current.asLowerCase),

        //      ElevatedButton(
        //       onPressed: () {
        //         print('button pressed!');
        //       },
        //       child: Text('Next'),
        //     ),
        //   ],
        // ),
        );
  }
}
