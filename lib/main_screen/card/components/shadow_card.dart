import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
BoxDecoration shadow_Card() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.grey[300],
      boxShadow: [
        BoxShadow(
            color: Colors.grey.shade500,
            offset: Offset(10.0, 10.0),
            blurRadius: 15.0,
            spreadRadius: 2.0),
        BoxShadow(
            color: Colors.white,
            offset: Offset(-10.0, -10.0),
            blurRadius: 15.0,
            spreadRadius: 2.0),
      ]);
}
