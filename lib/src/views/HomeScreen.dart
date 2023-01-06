import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../Utils/StringExtension.dart";
import '../services/PokeapiService.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color black = Colors.black87;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pokedex',
              style: TextStyle(
                  color: black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: _ListPokemons(),
            )
          ],
        ),
      ),
    ));
  }
}

class _ListPokemons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listPokemons = Provider.of<PokemonProvider>(context).listPokemons;

    Color green = const Color.fromRGBO(60, 208, 128, 1);
    Color blue = const Color.fromRGBO(112, 152, 200, 1);
    Color red = const Color.fromRGBO(208, 80, 48, 1);
    return ListView.builder(
        itemCount: listPokemons.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'detailScreen',
                  arguments: [listPokemons[index], index]);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Container(
                  color: index < 3
                      ? green
                      : index > 5
                          ? blue
                          : red,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          listPokemons[index].name.capitalize(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Hero(
                              tag: listPokemons[index].name,
                              child: Image.network(
                                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
