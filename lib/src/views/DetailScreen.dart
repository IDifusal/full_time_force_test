import 'package:flutter/material.dart';
import 'package:full_time_force_test/src/Utils/Colors.dart';
import 'package:full_time_force_test/src/models/PokemonModel.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';

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
            delegate: SliverChildListDelegate([_DetailsPokemon(args: args)]))
      ],
    ));
  }
}

class _DetailsPokemon extends StatelessWidget {
  final List<dynamic> args;

  const _DetailsPokemon({required this.args});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PokemonModel>(
        future: getPokemonsDetails(args[0].name.toString().capitalize()),
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            return _ContentDetails(pokemon: snapshot.data!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

class _ContentDetails extends StatelessWidget {
  PokemonModel pokemon;
  _ContentDetails({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _TypesPokemon(pokemon: pokemon),
          _StatsPokemon(pokemon: pokemon),
        ],
      ),
    );
  }
}

class _TypesPokemon extends StatelessWidget {
  const _TypesPokemon({
    Key? key,
    required this.pokemon,
  }) : super(key: key);
  final PokemonModel pokemon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(pokemon.types.length, (index) {
          return Column(
            children: [
              Chip(
                  backgroundColor: pokemon.types[index].type.name == 'grass'
                      ? CustomColors.green
                      : pokemon.types[index].type.name == 'fire'
                          ? CustomColors.red
                          : CustomColors.blue,
                  label: Text(
                    pokemon.types[index].type.name.capitalize(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ],
          );
        }),
      ),
    );
  }
}

class _StatsPokemon extends StatelessWidget {
  const _StatsPokemon({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    Color green = const Color.fromRGBO(60, 208, 128, 1);
    Color blue = const Color.fromRGBO(112, 152, 200, 1);
    Color red = const Color.fromRGBO(208, 80, 48, 1);
    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        shrinkWrap: true,
        itemCount: pokemon.stats.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      pokemon.stats[index].stat.name.capitalize(),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                  LinearPercentIndicator(
                    barRadius: const Radius.circular(20),
                    width: MediaQuery.of(context).size.width - 100,
                    animation: true,
                    lineHeight: 20.0,
                    animationDuration: 2000,
                    percent: pokemon.stats[index].baseStat < 100
                        ? pokemon.stats[index].baseStat / 100
                        : pokemon.stats[index].baseStat / 200,
                    center: Text(
                      pokemon.stats[index].baseStat.toString(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    progressColor: index < 2
                        ? green
                        : index > 3
                            ? blue
                            : red,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          );
        });
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
  var parseName = pokemon.toLowerCase();
  const String baseUrl = 'https://pokeapi.co/api/v2';
  final response = await http.get(Uri.parse('$baseUrl/pokemon/$parseName'));
  if (response.statusCode == 200) {
    final data = response.body;
    return PokemonModel.fromJson(data);
  } else {
    throw Exception('Failed to load Pokemon');
  }
}
