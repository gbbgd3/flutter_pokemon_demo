import 'dart:convert';
import 'package:http/http.dart' as http;


class Pokemon {
  final String pokemon_name;
  final String pokemon_images;
  final String pokemon_type;

  Pokemon(this.pokemon_name, this.pokemon_images, this.pokemon_type);

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      json['name'],
      json['sprites']['front_default'],
      json['types'][0]['type']['name'],
    );
  }

  static Future<List<Pokemon>> fetchPokemonData(List<Map<String, dynamic>> pokemonList) async {
    List<Pokemon> pokemonData = [];

    for (dynamic pokemonInfo in pokemonList) {
      final response = await http.get(Uri.parse(pokemonInfo['url']));
      if (response.statusCode == 200) {
        final pokemonJson = jsonDecode(response.body);
        final pokemon = Pokemon.fromJson(pokemonJson);
        pokemonData.add(pokemon);
      } else {
        throw Exception('Failed to fetch Pokémon data');
      }
    }

    return pokemonData;
  }
}
