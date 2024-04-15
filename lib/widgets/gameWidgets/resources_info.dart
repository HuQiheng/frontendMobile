import 'package:flutter/material.dart';

class ResourcesInfo extends StatelessWidget {
  const ResourcesInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(7.5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF083344),
          width: 2.0,
        ),
      ),
      child: const IntrinsicHeight(
        child: IntrinsicWidth(
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.monetization_on_outlined,
                    size: 30,
                    color: Color(0xFFEA970A),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '400',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Icon(
                    Icons.map,
                    size: 30,
                    color: Color(0xFFEA970A),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '10/42',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Icon(
                    Icons.factory,
                    size: 30,
                    color: Color(0xFFEA970A),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '00/10',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
