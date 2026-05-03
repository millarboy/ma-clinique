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

DateTime resetTimeToMidnight(DateTime day) {
  return DateTime(day.year, day.month, day.day, 0, 0, 0, 0);
}

DateTime minus1day(DateTime day) {
  // remove 1 day from Date Time
// subtract 1 day from dateTime
  return day.subtract(Duration(days: 1));
}

DateTime plus1day(DateTime day) {
  // add 1 day to dateTime
  return day.add(Duration(days: 1));
}

List<DateTime>? availSlotsDurationfixMinutes(
  List<DateTime>? reservedSlotStartTime,
  List<DateTime>? reservedSlotEndTime,
  DateTime? selectedDate,
  int? durationInMinutes,
) {
  if (selectedDate == null ||
      durationInMinutes == null ||
      durationInMinutes <= 0) {
    return null;
  }

  List<DateTime> availableStartTimes = [];

  // Define working hours
  DateTime availableStartTime = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    10,
    0,
  );
  DateTime availableEndTime = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    19,
    0,
  );

  // Step size between potential slots (e.g., every 30 minutes)
  const int stepMinutes = 30;
  int duration = durationInMinutes;

  // Prepare and sort reserved slots
  List<Map<String, DateTime>> reservedSlots = [];
  if (reservedSlotStartTime != null && reservedSlotEndTime != null) {
    for (int i = 0; i < reservedSlotStartTime.length; i++) {
      if (reservedSlotEndTime[i].isBefore(reservedSlotStartTime[i])) continue;
      reservedSlots.add({
        "start": reservedSlotStartTime[i],
        "end": reservedSlotEndTime[i],
      });
    }
    reservedSlots.sort((a, b) => a["start"]!.compareTo(b["start"]!));
  }

  DateTime currentSlot = availableStartTime;
  while (
      currentSlot.add(Duration(minutes: duration)).isBefore(availableEndTime) ||
          currentSlot
              .add(Duration(minutes: duration))
              .isAtSameMomentAs(availableEndTime)) {
    bool isAvailable = true;

    for (var reserved in reservedSlots) {
      if (currentSlot.isBefore(reserved["end"]!) &&
          currentSlot
              .add(Duration(minutes: duration))
              .isAfter(reserved["start"]!)) {
        isAvailable = false;
        break;
      }
    }

    if (isAvailable) {
      availableStartTimes.add(currentSlot);
    }

    // Move in smaller steps (e.g., 30 min)
    currentSlot = currentSlot.add(const Duration(minutes: stepMinutes));
  }

  return availableStartTimes.isNotEmpty ? availableStartTimes : null;
}

List<DateTime>? availSlotsDurationfixMinutesCopy2(
  List<DateTime>? reservedSlotStartTime,
  List<DateTime>? reservedSlotEndTime,
  DateTime? selectedDate,
  int? durationInMinutes,
) {
  if (selectedDate == null ||
      (durationInMinutes != null && durationInMinutes <= 0)) {
    return null;
  }

  List<DateTime> availableStartTimes = [];

  // Define the start and end of available hours
  DateTime availableStartTime = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    10,
    0,
  );
  DateTime availableEndTime = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    19,
    0,
  );

  // Set a default duration if not provided
  int duration = durationInMinutes ?? 60;

  // If no reserved slots, return all slots for the day
  if (reservedSlotStartTime == null || reservedSlotStartTime.isEmpty) {
    DateTime nextSlot = availableStartTime;
    while (
        nextSlot.add(Duration(minutes: duration)).isBefore(availableEndTime) ||
            nextSlot
                .add(Duration(minutes: duration))
                .isAtSameMomentAs(availableEndTime)) {
      availableStartTimes.add(nextSlot);
      nextSlot = nextSlot.add(Duration(minutes: duration));
    }
    return availableStartTimes.isNotEmpty ? availableStartTimes : null;
  }

  // Merge and sort reserved slots to handle overlaps
  List<Map<String, DateTime>> reservedSlots = [];
  for (int i = 0; i < reservedSlotStartTime.length; i++) {
    if (reservedSlotEndTime == null ||
        reservedSlotEndTime[i].isBefore(reservedSlotStartTime[i])) {
      continue; // Skip invalid slots
    }
    reservedSlots.add({
      "start": reservedSlotStartTime[i],
      "end": reservedSlotEndTime[i],
    });
  }
  reservedSlots.sort((a, b) => a["start"]!.compareTo(b["start"]!));

  // Generate all possible slots
  DateTime currentSlot = availableStartTime;
  while (
      currentSlot.add(Duration(minutes: duration)).isBefore(availableEndTime) ||
          currentSlot
              .add(Duration(minutes: duration))
              .isAtSameMomentAs(availableEndTime)) {
    bool isAvailable = true;

    // Check if current slot overlaps with any reserved slot
    for (var reserved in reservedSlots) {
      if (currentSlot.isBefore(reserved["end"]!) &&
          currentSlot
              .add(Duration(minutes: duration))
              .isAfter(reserved["start"]!)) {
        isAvailable = false;
        break;
      }
    }

    if (isAvailable) {
      availableStartTimes.add(currentSlot);
    }

    currentSlot = currentSlot.add(Duration(minutes: duration));
  }

  return availableStartTimes.isNotEmpty ? availableStartTimes : null;
}

List<DateTime>? availSlotsDurationfixMinutesCopy(
  List<DateTime>? reservedSlotStartTime,
  List<DateTime>? reservedSlotEndTime,
  DateTime? selectedDate,
  int? durationInMinutes,
) {
  if (selectedDate == null ||
      durationInMinutes == null ||
      durationInMinutes <= 0) {
    return null;
  }

  List<DateTime> availableStartTimes = [];

  // Define working hours
  DateTime availableStartTime = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    10,
    0,
  );
  DateTime availableEndTime = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    19,
    0,
  );

  // Step size between potential slots (e.g., every 30 minutes)
  const int stepMinutes = 30;
  int duration = durationInMinutes;

  // Prepare and sort reserved slots
  List<Map<String, DateTime>> reservedSlots = [];
  if (reservedSlotStartTime != null && reservedSlotEndTime != null) {
    for (int i = 0; i < reservedSlotStartTime.length; i++) {
      if (reservedSlotEndTime[i].isBefore(reservedSlotStartTime[i])) continue;
      reservedSlots.add({
        "start": reservedSlotStartTime[i],
        "end": reservedSlotEndTime[i],
      });
    }
    reservedSlots.sort((a, b) => a["start"]!.compareTo(b["start"]!));
  }

  DateTime currentSlot = availableStartTime;
  while (
      currentSlot.add(Duration(minutes: duration)).isBefore(availableEndTime) ||
          currentSlot
              .add(Duration(minutes: duration))
              .isAtSameMomentAs(availableEndTime)) {
    bool isAvailable = true;

    for (var reserved in reservedSlots) {
      if (currentSlot.isBefore(reserved["end"]!) &&
          currentSlot
              .add(Duration(minutes: duration))
              .isAfter(reserved["start"]!)) {
        isAvailable = false;
        break;
      }
    }

    if (isAvailable) {
      availableStartTimes.add(currentSlot);
    }

    // Move in smaller steps (e.g., 30 min)
    currentSlot = currentSlot.add(const Duration(minutes: stepMinutes));
  }

  return availableStartTimes.isNotEmpty ? availableStartTimes : null;
}

DateTime? endTime(
  DateTime? startTime,
  int? duration,
) {
// add duration to a time
  if (startTime == null || duration == null) {
    return null;
  }
  return startTime.add(Duration(minutes: duration));
}

int? string2int(String? text) {
  // convert string number to integer
  if (text == null) {
    return null;
  }
  return int.tryParse(text);
}

int? double2int(double? double2) {
  // double to integer
  if (double2 == null) {
    return null;
  } else {
    return double2.toInt();
  }
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

List<DocumentReference>? documentIDtoReference(
  String? collectionName,
  List<String>? documentId,
) {
  // return document reference lis from documentid
  if (collectionName == null || documentId == null) {
    return null;
  }

  return documentId
      .map(
          (id) => FirebaseFirestore.instance.collection(collectionName).doc(id))
      .toList();
}
