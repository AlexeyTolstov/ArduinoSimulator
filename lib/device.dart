import 'package:arduino_simulator_test/styles/colors.dart';
import 'package:arduino_simulator_test/styles/widgets_styles.dart';
import 'package:flutter/material.dart';


class Position{
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  Position({
    this.top,
    this.bottom,
    this.left,
    this.right,
  });
}


class ItemWidget {
  final int id;

  final Image image;
  final String nameDevice;

  final List<Contact> contacts;
  double x, y;  
  bool isDragged;

  late final double width, height;
  
  ItemWidget({
    required this.id,
    required this.image,
    required this.nameDevice,
    required this.contacts,
    this.x = 0,
    this.y = 0,
    this.isDragged = false,
  }){
    width = image.width ?? 0;
    height = image.height ?? 0;
  }

  Widget itemWidget(){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            height: 200,
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Stack(
        children: [
          image,
          
          ...contacts.map((Contact c) {
            return c.widget();
          }),
        ],
      ),
    );
  }
}


class Contact {
  final int id;
  final String name;

  final Position pos;
  void Function() onTap;
  
  bool isSelected;

  Contact({
    required this.id,
    required this.name,
    required this.pos,
    required this.onTap,
    this.isSelected = false,
  });

  Widget widget(){
    return Positioned(
      left: pos.left,
      right: pos.right,
      bottom: pos.bottom,
      top: pos.top,
      
      child: GestureDetector(
        onTap: onTap,

        child: Stack(
          children: [
            Icon(
              Icons.circle,
              size: 14,
              color: isSelected 
                ?AppColors.selectedContactColor
                :AppColors.unselectedContactColor,
            ),
            const Positioned(
              top: 2,
              left: 2,
              child: Icon(
                Icons.circle,
                size: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}