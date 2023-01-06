import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import './src/views/Views.dart';
import 'src/services/PokeapiService.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonProvider(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Fulltime Force Test',
        initialRoute: 'homeScreen',
        debugShowCheckedModeBanner: false,
        home: const Scaffold(
          body: Center(
            child: Text('Hello World'),
          ),
        ),
        routes: {
          'homeScreen': (_) => HomeScreen(),
          'detailScreen': (_) => DetailScreen()
        },
      ),
    );
  }
}
