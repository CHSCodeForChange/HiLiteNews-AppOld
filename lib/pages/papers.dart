import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';

import './paper.dart';
import 'package:http/http.dart' as http;

class Papers extends StatefulWidget {

    @override
    PapersState createState() => new PapersState();

}

class PapersState extends State<Papers> {

  List papers;
  
  Future<String> getData() async {
    var response = await http.get(
      Uri.encodeFull("http://pearlnews.herokuapp.com/api/?format=json"),
      headers: {
        "Accept": "application/json"
      }
    );
    
    this.setState(() {
      papers = JSON.decode(response.body);
    });
  }

  @override
  void initState() {
    this.getData();
  }


  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.deepPurple,
      child: new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top:20.0, bottom: 5.0),
            child: new Text(
              'Pearl News',
              
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white),

            )
          ),
          new Expanded(
            child: new ListView.builder(
              itemCount: papers == null ? 0 : papers.length,
              padding: new EdgeInsets.all(8.0),
              itemExtent: 70.0,
              itemBuilder: (BuildContext context, int index) {
                return new GestureDetector(
                  onTap: () {
                     Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => Paper(papers[index]["name"], papers[index]["school"], papers[index]["description"], papers[index]["website"]))
                      );
                  },
                  child: new Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    child:new Container(
                      alignment: Alignment.center,
                      child: new Text(
                        papers[index]["name"],
                        style: TextStyle(fontSize: 20.0, color:Colors.black),
                      ),
                    )
                  )
                );
              },
            )
          )
        ],
      )
    );
  }
}