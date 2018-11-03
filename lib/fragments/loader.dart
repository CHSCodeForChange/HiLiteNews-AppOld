import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../models/colors.dart';

class Loader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Card (
      child: new Container(
        padding: EdgeInsets.all(30.0),
        child: new Container(
          child: new LinearProgressIndicator(
            backgroundColor: MyColors.semiTransYellow(),
            valueColor: AlwaysStoppedAnimation<Color>(MyColors.yellow()),
          ),
        )
      )
    );
  }

}