import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/model/pokedex_model.dart';

import 'detay_view.dart';

class PokeView extends StatefulWidget {
  @override
  _PokeViewState createState() => _PokeViewState();
}

class _PokeViewState extends State<PokeView> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  Pokedex pokedex;

  Future<Pokedex> veri;

  Future<Pokedex> veriGetir() async {
    var response = await http.get(url);
    var parcalaJson = json.decode(response.body);
    pokedex = Pokedex.fromJson(parcalaJson);
    return pokedex;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    veri = veriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        // ignore: missing_return
        child: FutureBuilder(
          // ignore: missing_return
          builder: (context, AsyncSnapshot<Pokedex> sonuc) {
            if (sonuc.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (sonuc.connectionState == ConnectionState.done) {
              return GridView.builder(
                  itemCount: sonuc.data.pokemon.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetayView(
                                      pokemon: sonuc.data.pokemon[index],
                                    )));
                      },
                      child: Hero(
                        tag: sonuc.data.pokemon[index].img,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 100,
                                child: Image.network(
                                    sonuc.data.pokemon[index].img),
                              ),
                              Text(sonuc.data.pokemon[index].name),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          },
          future: veri,
        ),
      ),
    );
  }
}
