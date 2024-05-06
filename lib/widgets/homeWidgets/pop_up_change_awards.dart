import 'package:flutter/material.dart';
import 'package:wealth_wars/widgets/homeWidgets/pop_up_change_username.dart';

class PopUpChangeAwards extends StatefulWidget {
  final List<String> myAwards;

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
    return AlertDialog(
      title: Text('Selecciona una imagen'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            _buildImageDropdown(1),
            _buildImageDropdown(2),
            _buildImageDropdown(3),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Cerrar el popup
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            // Realizar alguna acción con las URLs de las imágenes seleccionadas
            print('URL de la imagen seleccionada para celda 1: $selectedImageUrl1');
            print('URL de la imagen seleccionada para celda 2: $selectedImageUrl2');
            print('URL de la imagen seleccionada para celda 3: $selectedImageUrl3');
            Navigator.of(context).pop(); // Cerrar el popup
          },
          child: Text('Aceptar'),
        ),
      ],
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
      items: widget.myAwards.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Celda $cellNumber',
        border: OutlineInputBorder(),
      ),
    );
  }
}