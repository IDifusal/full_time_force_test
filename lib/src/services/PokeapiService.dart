import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/PokemonApiResponse.dart';

class PokemonProvider with ChangeNotifier {
  List<PokemonApiResponse> listPokemons = [];
  final String _baseUrl = 'https://pokeapi.co/api/v2';
  PokemonProvider() {
    getPokemonList();
  }

  getPokemonList() async {
    final response = await http.get(Uri.parse('$_baseUrl/pokemon'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var pokemon in data['results']) {
        final pokemonModel = PokemonApiResponse.fromJson(pokemon);
        listPokemons.add(pokemonModel);
      }
      notifyListeners();
    } else {
      throw Exception('Failed to load Pokemon list');
    }
  }
}
