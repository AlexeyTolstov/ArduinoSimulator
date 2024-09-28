import 'package:arduino_simulator_test/device.dart';
import 'package:arduino_simulator_test/my_logger.dart';
import 'package:arduino_simulator_test/styles/colors.dart';
import 'package:arduino_simulator_test/styles/images.dart';
import 'package:flutter/material.dart';

class ConnectDevicesPage extends StatefulWidget {
  const ConnectDevicesPage({super.key});

  @override
  State<ConnectDevicesPage> createState() => _ConnectDevicesPageState();
}

class _ConnectDevicesPageState extends State<ConnectDevicesPage> {
  int? selectedContactId;

  late List<ItemWidget> itemWidgets = [
    ItemWidget(
      id: 0,
      image: AppDevicesImages.lightRedOff,
      nameDevice: "Красный светодиод",
      contacts: [
        Contact(
          id: 0,
          name: "GND",
          pos: Position(left: 6, bottom: 0),
          onTap: () => changeSelected(0),
        ),
        Contact(
          id: 1,
          name: "VCC",
          pos: Position(right: 5, bottom: 0),
          onTap: () => changeSelected(1),
        ),
      ],
    ),
    ItemWidget(
      id: 1,
      image: AppDevicesImages.arduinoUno,
      nameDevice: "Arduino Uno",
      contacts: [],
    )
  ];

  void changeSelected(int? id) {
    setState(() {
      selectedContactId = id;

      for (int i = 0; i < itemWidgets[0].contacts.length; i++) {
        itemWidgets[0].contacts[i].isSelected =
            itemWidgets[0].contacts[i].id == selectedContactId;
      }
    });
    logger.i("Changing on $selectedContactId");
  }

  void resetItems() {
    setState(() {
      for (int i = 0; i < itemWidgets.length; i++) {
        itemWidgets[i].isDragged = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    for (Contact i in itemWidgets[0].contacts) {
      logger.i("${i.id}, ${i.isSelected}");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Simulator"),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.restore),
        onPressed: resetItems,
      ),
      body: Row(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width / 4,
            height: double.infinity,
            color: AppColors.backgroundColor,
            child: ListView(
              children: itemWidgets.map((ItemWidget item) {
                return item.isDragged
                    ? Container()
                    : Column(
                        children: [
                          Draggable<ItemWidget>(
                            data: item,
                            feedback: Opacity(
                              opacity: 0.7,
                              child: item.widget(),
                            ),
                            childWhenDragging: Container(),
                            child: item.itemWidget(),
                            onDragEnd: (details) {
                              setState(() {
                                item.isDragged = true;
                                item.x = details.offset.dx -
                                    MediaQuery.sizeOf(context).width / 4;
                                item.y = details.offset.dy -
                                    AppBar().preferredSize.height;

                                if (item.x < 0) {
                                  item.x = 0;
                                  item.isDragged = false;
                                }
                              });
                            },
                          ),
                        ],
                      );
              }).toList(),
            ),
          ),
          Expanded(
            child: DragTarget<ItemWidget>(
              onAcceptWithDetails: (details) {
                setState(() {
                  for (ItemWidget i in itemWidgets) {
                    if (i.id == details.data.id) return;
                  }

                  itemWidgets.add(ItemWidget(
                    id: details.data.id,
                    image: details.data.image,
                    nameDevice: details.data.nameDevice,
                    contacts: details.data.contacts,
                    x: details.offset.dx - MediaQuery.sizeOf(context).width / 4,
                    y: details.offset.dy - AppBar().preferredSize.height,
                    isDragged: true,
                  ));
                });
              },
              builder: (context, candidateData, rejectedData) {
                return Stack(
                  children: itemWidgets.map((item) {
                    if (!item.isDragged) return Container();

                    return Positioned(
                      left: item.x,
                      top: item.y,
                      child: Draggable<ItemWidget>(
                        data: item,
                        feedback: Opacity(
                          opacity: 0.7,
                          child: item.widget(),
                        ),
                        childWhenDragging: Container(),
                        onDragEnd: (details) {
                          setState(() {
                            item.x = details.offset.dx -
                                MediaQuery.sizeOf(context).width / 4;
                            item.y = details.offset.dy -
                                AppBar().preferredSize.height;

                            if (item.x < 0) {
                              item.x = 0;
                              item.isDragged = false;
                            }
                          });
                        },
                        child: item.widget(),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
