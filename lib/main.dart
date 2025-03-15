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
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 60, 27, 179)),
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
  var favorites = <WordPair>[];
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) { // ← every widget defines a build() method that automatically called everytime the widget changes
    var appState = context.watch<MyAppState>(); // watch method tracks changes to the apps current state  
    var pair = appState.current; //gets the current word pair from the appState

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }


    return Scaffold( // In this case the top-level widget is Scaffold. Typically a nested tree of widgets 
      body: Center(
        child: Column( //puts children into a colunmn from top to bottom
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(pair: pair),
            SizedBox(height: 10), //adds space between the widgets
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon( //button widget
                  onPressed: () {  
                    appState.toggleFavorite(); //calls the toggleFavorite method of the appState
                  },
                  icon: Icon(icon),
                  label: Text('Favorite'),
                ),


                ElevatedButton( //button widget
                  onPressed: () {
                    appState.getNext(); //calls the getNext method of the appState  
                  },
                  child: Text('Next'),
                ),
              ],
            ),
        
          ],
        ),
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

    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
      fontSize: 50.0,
      letterSpacing: 2.0,
      height: 1.2, //line height
      shadows: const [
        Shadow(
          color: Colors.black,
          offset: Offset(2.0, 2.0),
          blurRadius: 3.0,
        ),
      ],
    );


    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase, 
          style: style,
          semanticsLabel: '${pair.first} ${pair.second}', //accessibility feature),
      ),
    ),
    );
  }
}