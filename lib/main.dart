import 'package:flutter/material.dart';
import './components/generic_button.dart';

void main() {
  final List<String> buttonTexts = ['Pokedex', 'Moves', 'Abilities', 'Items'];
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 20,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                iconSize: 30,
                onPressed: () {},
                icon: Icon(Icons.notifications_none, color: Colors.grey.shade400,)
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
                  borderSide: BorderSide.none
              ),
              hintText: "Search e.g Pokemon",
              hintStyle: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
              child: Text(
                'What Pokemon information are you looking for?',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 300,
              margin: EdgeInsets.only(top: 5.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Adjust the number of items per row
                  crossAxisSpacing: 40.0,
                  mainAxisSpacing: 40.0,
                ),
                itemCount: buttonTexts.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GenericButton(text: buttonTexts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    ),
  ));
}
