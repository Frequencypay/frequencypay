

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoanRequestWidgets {

  static const Color blueHighlight = const Color(0xFF3665FF);

  static Widget LoanRequestFloatingActionButton(BuildContext context) {

    return FloatingActionButton(
      onPressed: () {

        Navigator.pushNamed(context, '/loan_request_page');
      },
      child: Icon(Icons.add, size: 30),
      backgroundColor: blueHighlight,
    );
  }
}