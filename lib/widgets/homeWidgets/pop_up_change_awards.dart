import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class PopUpChangeAwards extends StatefulWidget {
  final Map<String, String> myAwards;

  PopUpChangeAwards({required this.myAwards});

  @override
  _PopUpChangeAwardsState createState() => _PopUpChangeAwardsState();
}

class _PopUpChangeAwardsState extends State<PopUpChangeAwards> {
  String? selectedImageUrl1;
  String? selectedImageUrl2;
  String? selectedImageUrl3;

  @override
  Widget build(BuildContext context) {
    final Logger logger = Logger();
    return AlertDialog(
      contentPadding:
          const EdgeInsets.only(top: 2, right: 20, left: 20, bottom: 20),
      backgroundColor: const Color(0xFF083344),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Seleccione un logro',
                    style: TextStyle(
                      color: Color(0xFFEA970A),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 2),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(4.0),
                color: const Color(0xFFEA970A),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  _buildImageDropdown(1),
                  const SizedBox(height: 8),
                  _buildImageDropdown(2),
                  const SizedBox(height: 8),
                  _buildImageDropdown(3),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Realizar alguna acción con las URLs de las imágenes seleccionadas
                      logger.d('URL de la imagen seleccionada para celda 1: $selectedImageUrl1');
                      logger.d('URL de la imagen seleccionada para celda 2: $selectedImageUrl2');
                      logger.d('URL de la imagen seleccionada para celda 3: $selectedImageUrl3');
                      Navigator.of(context).pop(); // Cerrar el popup
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0066CC),
                      foregroundColor: Colors.white,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Aceptar'),
                        SizedBox(width: 10),
                        Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildImageDropdown(int cellNumber) {
    return DropdownButtonFormField<String>(
      value: cellNumber == 1 ? selectedImageUrl1 : cellNumber == 2 ? selectedImageUrl2 : selectedImageUrl3,
      onChanged: (String? newValue) {
        setState(() {
          if (cellNumber == 1) {
            selectedImageUrl1 = newValue;
          } else if (cellNumber == 2) {
            selectedImageUrl2 = newValue;
          } else {
            selectedImageUrl3 = newValue;
          }
        });
      },
      items: widget.myAwards.entries.map<DropdownMenuItem<String>>((MapEntry<String, String> entry) {
        return DropdownMenuItem<String>(
          value: entry.key,
          child: Row(
            children: [
              Image.network(entry.value, width: 50, height: 50), // Muestra la imagen en el dropdown
              SizedBox(width: 10), // Espacio entre la imagen y el texto
              Text(entry.key, style: TextStyle(color: Colors.black)), // Muestra el título del logro
            ],
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Celda $cellNumber',
        border: OutlineInputBorder(),
        labelStyle: TextStyle(color: Colors.black),
        filled: true, // Establece el campo como lleno
        fillColor: const Color(0xFF005A88), // Establece el color de fondo del seleccionable
      ),
      dropdownColor: const Color(0xFF005A88), // Establece el color de fondo del menú desplegable
    );
  }

}
