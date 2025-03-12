import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

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
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext(){
    current = WordPair.random(); //assigns a new random word pair to current
    notifyListeners(); //method of ChangeNotifier
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) { // ← every widget defines a build() method that automatically called everytime the widget changes
    var appState = context.watch<MyAppState>(); // watch method tracks changes to the apps current state  
    var pair = appState.current; //gets the current word pair from the appState


    return Scaffold( // In this case the top-level widget is Scaffold. Typically a nested tree of widgets 
      body: Column( //puts children into a colunmn from top to bottom
        children: [
          Text('A random AWESOME idea:'),  // ← text widget 
          BigCard(pair: pair),

          ElevatedButton( //button widget
            onPressed: () {
              appState.getNext(); //calls the getNext method of the appState  
            },
            child: Text('Next'),
          ),



        ],
      ), // ← Column
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    return Text(pair.asLowerCase);
  }
}