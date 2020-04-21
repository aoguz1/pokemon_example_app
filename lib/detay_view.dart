import 'package:flutter/material.dart';
import 'package:pokedex/model/pokedex_model.dart';

class DetayView extends StatelessWidget {
  Pokemon pokemon;

  DetayView({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade400,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(pokemon.name),
      ),
      body: Center(
        child: Container(

          child: Stack(
            children: <Widget>[
              Positioned(
                top: MediaQuery.of(context).size.height * 0.06,
                left: 20,
                width: (MediaQuery.of(context).size.width) - 40,
                height: (MediaQuery.of(context).size.height) *  2.60/4,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26)),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 70,
                      ),
                      Text(
                        pokemon.name,
                        style:
                            TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text("Height :" + pokemon.height),
                      Text("Weight : " + pokemon.weight),
                      Text(
                        "Types",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: pokemon.type.map((type) {
                          return Chip(label: Text(type));
                        }).toList(),
                      ),
                      Text("Pre Evolotion",style: TextStyle(fontWeight: FontWeight.bold),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: pokemon.prevEvolution != null ? pokemon.prevEvolution.map((pre) {
                          return Chip(label: Text(pre.name));
                        }).toList() : [Text("Ilk hali")],
                      ),


                      Text("Next Evolotion",style: TextStyle(fontWeight: FontWeight.bold),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: pokemon.nextEvolution != null ? pokemon.type.map((type) {
                          return Chip(label: Text(type));
                        }).toList() : [Text("İlk hali")],
                      ),


                      Text("Weakness",style: TextStyle(fontWeight: FontWeight.bold),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: pokemon.weaknesses.map((weakness) {
                          return Chip(label: Text(weakness));
                        }).toList(),
                      )

                    ],
                  ),
                ),
              ),

              Align(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: pokemon.img,
                  child: Container(
                      width: 130,
                      height: 130,

                      child: Image.network(pokemon.img,fit: BoxFit.cover,)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
