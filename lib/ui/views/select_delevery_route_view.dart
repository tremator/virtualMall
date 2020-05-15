import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

@widget
Widget selectRouteView(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Center(
        child: Text('Seleccione Ruta'),
      ),
    ),
    body: Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          color: Colors.black,
        ),
        Row(
          children: <Widget>[
            Icon(Icons.location_on),
            SizedBox(
              width: 2.0,
            ),    
            Text('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx')
          ],
        ),
        Text('DETALLES DE DIRECCION'),
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FlatButton(
            onPressed: () {},
            child: Text('Detalles de Direccion'),
          ),
        ),
        Row(
          children: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {},
            ),
            FlatButton(
              child: Text('Guardar'),
              onPressed: () {},
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          alignment: Alignment.bottomCenter,
          child: ButtonTheme(
            minWidth: MediaQuery.of(context).size.width * 0.8,
            child: RaisedButton(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Color(0xfff6a45a),
                highlightColor: Color(0xffd88a43),
                child: Text(
                  'Seleccionar Direccion',
                  style: TextStyle(fontSize: 14.0),
                ),
                onPressed: () {}),
          ),
        ),
      ],
    ),
  );
}
