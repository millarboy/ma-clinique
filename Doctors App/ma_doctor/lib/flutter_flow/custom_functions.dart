import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

DateTime plusDay(DateTime day) {
  return day.add(Duration(days: 1));
}

DateTime resettime2midnig(DateTime day) {
  return DateTime(day.year, day.month, day.day, 0, 0, 0, 0);
}

DateTime minusDay(DateTime day) {
  return day.subtract(Duration(days: 1));
}

int calculateAgeFromDOB(DateTime dateofBirth) {
  // calculate age from date of birth
  DateTime today = DateTime.now();
  int age = today.year - dateofBirth.year;
  if (today.month < dateofBirth.month ||
      (today.month == dateofBirth.month && today.day < dateofBirth.day)) {
    age--;
  }
  return age;
}

List<PointIDStruct>? combine(
  List<PointIDStruct>? appstate,
  List<PointIDStruct>? firestore,
) {
  // combine appstate and firestore
// Create a set to hold unique PointIDStructs
  final Set<PointIDStruct> combinedSet = {};

  // Add appstate items to the set
  if (appstate != null) {
    combinedSet.addAll(appstate);
  }

  // Add firestore items to the set
  if (firestore != null) {
    combinedSet.addAll(firestore);
  }

  // Convert the set back to a list and return
  return combinedSet.toList();
}
