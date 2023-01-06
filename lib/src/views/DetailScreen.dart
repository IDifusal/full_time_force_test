import 'package:flutter/material.dart';
import 'package:full_time_force_test/src/models/PokemonModel.dart';
import 'package:http/http.dart' as http;

import '../models/PokemonApiResponse.dart';
// ignore: unused_import
import "../Utils/StringExtension.dart";

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments! as List;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _SliverAppbar(args: args),
        SliverList(
            delegate: SliverChildListDelegate(
                [const Flexible(child: _DetailsPokemon())]))
      ],
    ));
  }
}

class _DetailsPokemon extends StatelessWidget {
  const _DetailsPokemon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPokemonsDetails('blastoise'),
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            return const _ContentDetails();
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

class _ContentDetails extends StatelessWidget {
  const _ContentDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('data'),
      ],
    );
  }
}

class _SliverAppbar extends StatelessWidget {
  final List<dynamic> args;

  const _SliverAppbar({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final data = args[0] ?? {} as PokemonApiResponse;
    Color green = const Color.fromRGBO(60, 208, 128, 1);
    Color blue = const Color.fromRGBO(112, 152, 200, 1);
    Color red = const Color.fromRGBO(208, 80, 48, 1);
    return SliverAppBar(
        backgroundColor: Colors.black54,
        expandedHeight: 400,
        collapsedHeight: 130,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.all(0),
            title: Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(child: SizedBox(width: 5)),
                    Hero(
                      tag: data.name,
                      child: Image.network(
                          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${args[1] + 1}.png'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(data.name.toString().capitalize(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            background: Paint()
                              ..color = args[1] < 3
                                  ? green
                                  : args[1] > 5
                                      ? blue
                                      : red
                              ..strokeWidth = 20
                              ..strokeJoin = StrokeJoin.round
                              ..strokeCap = StrokeCap.round
                              ..style = PaintingStyle.stroke,
                            color: Colors.white,
                            fontSize: 14)),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            background: Image.network(
              'https://assets.pokemon.com//assets/cms2/img/misc/virtual-backgrounds/sword-shield/dynamax-battle.png',
              fit: BoxFit.cover,
            )));
  }
}

Future<PokemonModel> getPokemonsDetails(String pokemon) async {
  const String baseUrl = 'https://pokeapi.co/api/v2';
  final response = await http.get(Uri.parse('$baseUrl/pokemon/$pokemon'));
  if (response.statusCode == 200) {
    final data = response.body;
    return PokemonModel.fromJson(data);
  } else {
    throw Exception('Failed to load Pokemon');
  }
}
