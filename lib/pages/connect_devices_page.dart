import 'package:flutter/material.dart';

import 'package:arduino_simulator_test/data/contact.dart';
import 'package:arduino_simulator_test/data/contact_id.dart';
import 'package:arduino_simulator_test/data/device.dart';
import 'package:arduino_simulator_test/data/wire.dart';
import 'package:arduino_simulator_test/data/coord.dart';

import 'package:arduino_simulator_test/styles/colors.dart';
import 'package:arduino_simulator_test/styles/contact.dart';
import 'package:arduino_simulator_test/styles/images.dart';

import 'package:arduino_simulator_test/widgets/device_widget.dart';
import 'package:arduino_simulator_test/widgets/item_widget.dart';
import 'package:arduino_simulator_test/widgets/wire_widget.dart';

import 'package:arduino_simulator_test/device/device_contacts.dart';

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
    "ArduinoUno": DeviceContacts.arduinoUnoContacts.map((Contact c) {
      return c
        ..onTap = () {
          changeSelected(c.contactId);
        };
    }).toList(),
  };

  late List<Device> devicesList = [
    Device(
        image: AppDevicesImages.lightRedOff,
        title: "Красный светодиод",
        nameDevice: "Light",
        contacts: contacts["Light"]!,
        size: const Size(42, 100)),
    Device(
        image: AppDevicesImages.arduinoUno,
        title: "Arduino Uno",
        nameDevice: "ArduinoUno",
        contacts: contacts["ArduinoUno"]!,
        size: const Size(510, 370)),
  ];

  List<WireContacts> wireContactsList = [];

  void removeWireWidgetDragging(String nameDevice) {
    for (WireContacts wireContacts in wireContactsList) {
      if (wireContacts.isRemovingDevice(nameDevice)) {
        wireContactsList.remove(wireContacts);
      }
    }
  }

  void changeSelected(ContactId? contactId) {
    setState(() {
      if (selectedContactId == contactId) {
        selectedContactId = null;
      } else if (contactId == null) {
        selectedContactId = null;
      } else if (selectedContactId == null) {
        selectedContactId = contactId;
      } else {
        bool isHave = false;
        for (WireContacts wireContacts in wireContactsList) {
          if (isHave) break;

          if ((wireContacts.first == contactId &&
                  wireContacts.second == selectedContactId) ||
              (wireContacts.first == selectedContactId &&
                  wireContacts.second == contactId)) {
            isHave = true;
          }
        }
        if (!isHave) {
          wireContactsList
              .add(WireContacts(first: contactId, second: selectedContactId!));
        }

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
      wireContactsList.clear();
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
                                device.coordination = Coordination(
                                    x: details.offset.dx -
                                        MediaQuery.sizeOf(context).width / 4,
                                    y: details.offset.dy -
                                        AppBar().preferredSize.height);

                                device.isDragged = device.coordination.x > 0;

                                if (!device.isDragged) {
                                  setState(() => removeWireWidgetDragging(
                                      device.nameDevice));
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
                                      AppBar().preferredSize.height,
                                );

                                device.isDragged = device.coordination.x > 0;
                                
                                if (!device.isDragged) {
                                  setState(() => removeWireWidgetDragging(
                                      device.nameDevice));
                                }
                              });
                            },
                            child: DeviceWidget(device: device),
                          ),
                        );
                      },
                    ),
                    ...wireContactsList.map(
                      (WireContacts wireContacts) {
                        Coordination? first;
                        Coordination? second;

                        for (Device device in devicesList) {
                          if (wireContacts.first.nameDevice ==
                              device.nameDevice) {
                            for (Contact i in device.contacts) {
                              if (wireContacts.first.id == i.contactId.id) {
                                first = Coordination(
                                  x: device.coordination.x +
                                      (i.pos.left ??
                                          (-i.pos.right! +
                                              device.widthImage -
                                              ContactStyle.borderSize)),
                                  y: device.coordination.y +
                                      (i.pos.top ??
                                          (-i.pos.bottom! +
                                              device.heightImage)),
                                );
                                break;
                              }
                            }
                          }
                          if (wireContacts.second.nameDevice ==
                              device.nameDevice) {
                            for (Contact i in device.contacts) {
                              if (wireContacts.second.id == i.contactId.id) {
                                second = Coordination(
                                  x: device.coordination.x +
                                      (i.pos.left ??
                                          (-i.pos.right! +
                                              device.widthImage -
                                              ContactStyle.borderSize)),
                                  y: device.coordination.y +
                                      (i.pos.top ??
                                          (-i.pos.bottom! +
                                              device.heightImage)),
                                );
                                break;
                              }
                            }
                          }
                        }

                        return WireWidget(
                          onTap: (Wire wire) {
                            wireContactsList.removeWhere((element) =>
                                (element.first == wireContacts.first &&
                                    element.second == wireContacts.second) ||
                                (element.first == wireContacts.second &&
                                    element.second == wireContacts.first));
                            setState(() {});
                          },
                          wire: Wire(
                            firstCoord: first!,
                            secondCoord: second!,
                          ),
                        );
                      },
                    ),
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
