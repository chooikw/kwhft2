import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';

String? formatDate(String? dateStr) {
  if (dateStr != null && dateStr != "" && dateStr != "null") {
    return DateFormat("d MMM HH:mm a").format(DateTime.parse(dateStr));
  }
  return "";
}
