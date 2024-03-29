import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../entity/event_entity.dart';

// Widget for event
class EventBox extends StatelessWidget {
  final EventEntity event;

  const EventBox({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      height: 82.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0, color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 50.0,
            width: 50.0,
            margin: const EdgeInsets.only(left: 15.0),
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(width: 0, color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(100)),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "${event.owner?.name} ${event.owner?.surname} - ${DateFormat('dd/MM/yyyy').format(event.eventDt)}",
                  style:
                      const TextStyle(fontSize: 12.0, color: Color(0xFF777777)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
