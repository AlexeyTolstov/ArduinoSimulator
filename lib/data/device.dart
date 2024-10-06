import 'package:arduino_simulator_test/data/contact.dart';
import 'package:arduino_simulator_test/data/coord.dart';
import 'package:flutter/material.dart';

class Device {
  final Image image;
  final String title;
  final String nameDevice;

  final List<Contact> contacts;
  Size size;

  Coordination coordination;
  bool isDragged;

  late final double widthImage, heightImage;

  Device({
    required this.title,
    required this.nameDevice,
    required this.image,
    required this.contacts,
    required this.size,
    this.coordination = const Coordination(x: 0, y: 0),
    this.isDragged = false,
  }) {
    widthImage = image.width ?? 0;
    heightImage = image.height ?? 0;
  }
}