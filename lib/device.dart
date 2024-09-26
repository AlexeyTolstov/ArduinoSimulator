import 'package:arduino_simulator_test/styles/widgets_styles.dart';
import 'package:flutter/material.dart';

class ItemWidget {
  final int id;

  final Image image;
  final String nameDevice;

  final List<Contact> contacts;
  double x, y;  
  bool isDragged;

  ItemWidget({
    required this.id,
    required this.image,
    required this.nameDevice,
    required this.contacts,
    this.x = 0,
    this.y = 0,
    this.isDragged = false,
  });

  Widget itemWidget(){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: image
          ),
          Expanded(
            child: Text(
              nameDevice,
              style: AppTextStyles.itemWidgetTitle,
            ), 
          )
        ],
      ),
    );
  }

  Widget widget(){
    return image;
  }
}


class Contact {
  final int id;
  final String name;

  final double diffX, diffY;

  Contact({
    required this.id,
    required this.name,
    required this.diffX,
    required this.diffY
  });
}