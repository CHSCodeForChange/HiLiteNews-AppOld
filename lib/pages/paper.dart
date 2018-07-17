import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './stories.dart';

class Paper extends StatelessWidget {
  final String name;
  final String school;
  final String description;
  final String url;

  Paper(this.name, this.school, this.description, this.url);
 
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.deepPurple,
      child: new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top:30.0),
            alignment: Alignment.topLeft,
            child: new RaisedButton(
              child: Icon(
                const IconData(0xe5c4, fontFamily: 'MaterialIcons', matchTextDirection: true),
                color: Colors.deepPurpleAccent,
              ),
              shape: CircleBorder(),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          new Flexible(
            child: new Card(
              margin: const EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              child: new Container(
                margin:const EdgeInsets.all(20.0),
                child: new Column(
                  children: <Widget>[
                    new Expanded (
                      child: new Column(
                        children: <Widget>[
                          new Padding(
                            padding: new EdgeInsets.only(bottom: 5.0),
                            child: new Text(
                              name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                            ),
                          ),

                          new Padding(
                            padding: new EdgeInsets.only(top: 5.0, bottom: 5.0),
                            child: new Text(
                              school,
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.grey)
                            )
                          ),
                          
                          new Padding(
                            padding: new EdgeInsets.only(top: 15.0, bottom: 5.0),
                            child: new Text(
                              description,
                              style: TextStyle(fontSize: 16.0)

                            ),
                          ),
                        ],
                      ),
                    ),
                    

                  ],
                ),
              ),
            ),
          ), 

          new Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0, bottom: 20.0),
            width: 400.0,
            child: new RaisedButton(
              color: Colors.white,
              shape: StadiumBorder(),
              child: new Container(
                child: new Text(
                  'Select',
                  style: TextStyle()
                ),
              ), 
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => Stories(name, url))
                );
              },
            )
          )
          
        ],
      ),
        
      
    );
  }

}

/* new Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        margin: const EdgeInsets.only(top: 60.0, bottom: 80.0, left: 30.0, right: 30.0),
      ), */