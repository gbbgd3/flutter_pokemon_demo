import 'dart:convert';

import 'package:flutter/material.dart';
import 'models/pokemon_model.dart';
import 'package:http/http.dart' as http;

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({Key? key}) : super(key: key);

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  List<Pokemon> _pokemonList = [];

  @override
  void initState() {
    super.initState();
    fetchPokemonData();
  }

  Future<void> fetchPokemonData() async {
    try {
      final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=151&offset=0'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<Map<String, dynamic>> pokemonList = List<Map<String, dynamic>>.from(data['results']);
        final pokemonData = await Pokemon.fetchPokemonData(pokemonList);

        setState(() {
          _pokemonList = pokemonData;
        });
      } else {
        throw Exception('Failed to fetch Pokemon data');
      }
    } catch (e) {
      print('Failed to fetch Pokemon data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 20,
        leading: IconButton(
          padding: EdgeInsets.only(left: 20),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey.shade600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              iconSize: 30,
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none,
                color: Colors.grey.shade400,
              ),
            ),
          )
        ],
        title: Container(
          height: 45,
          margin: EdgeInsets.only(left: 20),
          child: TextField(
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              filled: true,
              fillColor: Colors.grey.shade200,
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              hintText: "Search e.g Pokemon",
              hintStyle: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
      body: _pokemonList.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _pokemonList.length,
        itemBuilder: (context, index) {
          final pokemon = _pokemonList[index];
          return ListTile(
            leading: Image.network(pokemon.pokemon_images),
            title: Text(pokemon.pokemon_name),
            subtitle: Text('Type: ${pokemon.pokemon_type}'),
          );
        },
      ),
    );
  }
}
