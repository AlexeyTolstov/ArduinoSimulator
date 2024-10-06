import 'package:arduino_simulator_test/data/contact.dart';
import 'package:arduino_simulator_test/data/contact_id.dart';
import 'package:arduino_simulator_test/data/device.dart';
import 'package:arduino_simulator_test/data/wire.dart';
import 'package:arduino_simulator_test/data/coord.dart';
import 'package:arduino_simulator_test/device/device_contacts.dart';

import 'package:arduino_simulator_test/styles/colors.dart';
import 'package:arduino_simulator_test/styles/images.dart';
import 'package:arduino_simulator_test/widgets/device_widget.dart';
import 'package:arduino_simulator_test/widgets/item_widget.dart';

import 'package:arduino_simulator_test/widgets/wire_widget.dart';

import 'package:flutter/material.dart';

class ConnectDevicesPage extends StatefulWidget {
  const ConnectDevicesPage({super.key});

  @override
  State<ConnectDevicesPage> createState() => _ConnectDevicesPageState();
}

class _ConnectDevicesPageState extends State<ConnectDevicesPage> {
  ContactId? selectedContactId;

  late Map<String, List<Contact>> contacts = {
    "Light": DeviceContacts.lightContacts.map((Contact c) {
      return c
        ..onTap = () {
          changeSelected(c.contactId);
        };
    }).toList(),
    "Arduino Uno": []
  };

  late List<Device> devicesList = [
    Device(
      image: AppDevicesImages.lightRedOff,
      title: "Красный светодиод",
      nameDevice: "Light",
      contacts: contacts["Light"]!,
      size: const Size(42, 100)
    ),
    Device(
      image: AppDevicesImages.arduinoUno,
      title: "Arduino Uno",
      nameDevice: "Arduino Uno",
      contacts: contacts["Arduino Uno"]!,
      size: const Size(510, 380)
    ),
  ];

  // List<Wire> wireList = [];
  List<List<ContactId>> wireNameList = [];

  void changeSelected(ContactId? contactId) {
    setState(() {
      if (selectedContactId == contactId) {
        selectedContactId = null;
      } else if (contactId == null) {
        selectedContactId = null;
      } else if (selectedContactId == null) {
        selectedContactId = contactId;
      } else {
        wireNameList.add([contactId, selectedContactId!]);
        selectedContactId = null;
      }

      for (final el in contacts.entries) {
        List<Contact> contacts = el.value;

        for (Contact contact in contacts) {
          contact.isSelected = selectedContactId != null &&
              contact.contactId == selectedContactId;
        }
      }
    });
  }

  void resetItems() {
    setState(() {
      for (Device device in devicesList) {
        device.isDragged = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
              children: devicesList.map((Device device) {
                return device.isDragged
                    ? Container()
                    : Column(
                        children: [
                          Draggable<Device>(
                            data: device,
                            feedback: Opacity(
                              opacity: 0.7,
                              child: DeviceWidget(device: device),
                            ),
                            childWhenDragging: Container(),
                            child: ItemWidget(device: device),
                            onDragEnd: (details) {
                              setState(() {
                                device.isDragged = true;

                                device.coordination = Coordination(
                                  x: details.offset.dx - MediaQuery.sizeOf(context).width / 4,
                                  y: details.offset.dy - AppBar().preferredSize.height
                                );

                                if (device.coordination.x < 0) {
                                  device.coordination = const Coordination(x: 0, y: 0);
                                  device.isDragged = false;
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
            child: DragTarget<Device>(
              builder: (context, candidateData, rejectedData) {
                return Stack(
                  children: [
                    ...devicesList.map(
                      (Device device) {
                        if (!device.isDragged) return Container();
                        return Positioned(
                          left: device.coordination.x,
                          top: device.coordination.y,
                          child: Draggable<Device>(
                            data: device,
                            feedback: Opacity(
                              opacity: 0.7,
                              child: DeviceWidget(device: device),
                            ),
                            childWhenDragging: Container(),
                            onDragEnd: (details) {
                              setState(() {
                                device.coordination = Coordination(
                                  x: details.offset.dx -
                                    MediaQuery.sizeOf(context).width / 4,
                                  y: details.offset.dy -
                                    AppBar().preferredSize.height);

                                if (device.coordination.x < 0) {
                                  device.coordination = const Coordination(x: 0, y: 0);
                                  device.isDragged = false;
                                }
                              });
                            },
                            child: DeviceWidget(device: device),
                          ),
                        );
                      },
                    ),
                    ...wireNameList.map((List<ContactId> c) {
                      Coordination? first;
                      Coordination? second;

                      for (Device device in devicesList){
                        if (c[0].nameDevice == device.nameDevice){
                          for (Contact i in device.contacts){
                            if (c[0].nameContact == i.contactId.nameContact) {
                              first = Coordination(
                                x: device.coordination.x + (i.pos.left ?? (-i.pos.right! + device.widthImage)),
                                y: device.coordination.y + (i.pos.top ?? (-i.pos.bottom! + device.heightImage+100)),
                              );
                              break;
                            }
                          }
                        }
                        if (c[1].nameDevice == device.nameDevice){
                          for (Contact i in device.contacts){
                            if (c[1].nameContact == i.contactId.nameContact) {
                              second = Coordination(
                                x: device.coordination.x + (i.pos.left ?? (-i.pos.right! + device.widthImage)),
                                y: device.coordination.y + (i.pos.top ?? (-i.pos.bottom! + device.heightImage+100)),
                              );
                              break;
                            }
                          }
                        }
                      }

                      if (first! < second!){
                        (first, second) = (second, first);
                      }

                      return WireWidget(
                        onTap: (Wire wire) {
                          wireNameList.removeWhere((element) => 
                            (element[0] == c[0] || element[0] == c[1]) &&
                            (element[1] == c[0] || element[1] == c[1]));
                          setState(() {});
                        },
                        wire: Wire(
                          firstCoord: first,
                          secondCoord: second,
                        )
                      );
                    }),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
