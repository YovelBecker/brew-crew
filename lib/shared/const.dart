import 'package:flutter/material.dart';

var textInputDecoration = (String placeholder) => InputDecoration(
  hintText:placeholder,
  fillColor: Colors.white,
  filled: true,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
);
