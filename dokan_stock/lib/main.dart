// ignore_for_file: empty_constructor_bodies
import 'dart:html';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {
  // Initialed Firebase
  await Firebase.initializeApp(options: defaultFirebaseOptions);
  runApp(MyApp());
}

// dummy list for dropdown
const List<String> list = <String>['Name', 'Two', 'Three', 'Four'];
// actual list of stocks
List<Movie> stockList = <Movie>[];

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
        home: MyHomePage(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  // DbRef
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  // get Stocks
  Future<void> getStock() {
    return users.get().then((QuerySnapshot querySnapshot) {
      print(querySnapshot);
      querySnapshot.docs.forEach((doc) {
        var movie = Movie(
            name: doc['Name'],
            amount: doc['Amount'],
            rate: doc['Rate'],
            weight: doc['Weight']);
        stockList.add(movie);
        print(stockList);
      });
    });
  }

  bool isAddingStock = false;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddStock()));
            },
            child: Text('Add new stock'),
          ),
          ElevatedButton(
            onPressed: () {
              EasyLoading.show(status: 'Getting Stocks');
              getStock().then((value) => {
                    print(stockList[0].name),
                    EasyLoading.showSuccess('Data'),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DropDownButtonForStock()))
                  });
            },
            child: Text('Entry'),
          ),
        ]));
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
  // String dropdownValue = stockList[0].name.toString();
  final users = FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down),
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
        items: list.map((String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
    ]));
  }
}

class AddStock extends StatelessWidget {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final rateController = TextEditingController();
  final weightController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  bool isAddingStock = false;
  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    EasyLoading.show(status: 'Adding stock');
    isAddingStock = true;
    return users
        // .doc('Stock')
        .add({
          'Name': nameController.text, // John Doe
          'Amount': int.parse(amountController.text), // Stokes and Sons
          'Weight': int.parse(weightController.text), // 42
          'Rate': int.parse(rateController.text) // 42
        })
        .then((value) => {
              // print("User Added"),
              this.isAddingStock = false,
              EasyLoading.showSuccess('Stock Added')
            })
        .catchError((error) => print("Failed to add user: $error"));
  }

  AddStock({super.key});
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    amountController.dispose();
    rateController.dispose();
    weightController.dispose();
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<MyAppState>();
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate back to first route when tapped.
            },
            child: const Text('Go back!'),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Name for stock item'),
                controller: nameController,
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Rate for stock item'),
                controller: rateController,
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Weight for stock item'),
                controller: weightController,
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Amount for stock item'),
                controller: amountController,
              )),
          ElevatedButton(
            onPressed: isAddingStock ? null : addUser,
            child: Text('Add new stock'),
          )
        ])
        // Column(
        //   children: [
        //     Text('A random idea:'),
        //     Text(appState.current.asLowerCase),
        //
        );
  }
}

@immutable
class Movie {
  Movie(
      {required this.name,
      required this.amount,
      required this.rate,
      required this.weight});
  Movie.fromJson(Map<String, Object?> json)
      : this(
            name: (json['name']! as String),
            amount: json['amount']! as int,
            rate: json['rate']! as int,
            weight: json['weight']! as int);
  final int rate;
  final int amount;
  final int weight;
  final String name;
  Map<String, Object?> toJson() {
    return {'name': name, 'amount': amount, 'rate': rate, 'weight': weight};
  }
}

const defaultFirebaseOptions = FirebaseOptions(
  apiKey: 'AIzaSyAwMiKe4nLZir2f1fGNhJhQ8EnkLWCPViQ',
  appId: '1:440030831367:android:d822ad70a1dd1a12cd1ba2',
  messagingSenderId: '440030831367',
  projectId: 'dokan-stock-ca76e',
  storageBucket: 'dokan-stock-ca76e.appspot.com',
  authDomain: 'dokan-stock-ca76e.firebaseapp.com',
);
