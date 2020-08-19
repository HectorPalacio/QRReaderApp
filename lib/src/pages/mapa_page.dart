import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final map = new MapController();
  String tipoMapa = 'mapbox/streets-v11';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: [
          IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {
                map.move(scan.getLatLng(), 15);
              }),
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15,
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan),
      ],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
        urlTemplate:
            'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1IjoiaGVjdG9ycGFsYWNpbyIsImEiOiJja2Uwcm1tdGwzaG5rMzNqejF2MTh1dWR5In0.qVZ_Cbtx62288BWiLEYBHw',
          'id': tipoMapa
        }
        //streets: streets-v11
        //dark: dark-v10
        //light: light-v10
        //outdoors: outdoors-v11
        //satellite: satellite-streets-v11
        );
  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) {
            return Container(
              child: Icon(
                Icons.location_on,
                size: 45.0,
                color: Theme.of(context).primaryColor,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _crearBotonFlotante(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        //streets: streets-v11
        //dark: dark-v10
        //light: light-v10
        //outdoors: outdoors-v11
        //satellite: satellite-streets-v11
        if (tipoMapa == 'mapbox/streets-v11') {
          tipoMapa = 'mapbox/dark-v10';
        } else if (tipoMapa == 'mapbox/dark-v10') {
          tipoMapa = 'mapbox/light-v10';
        } else if (tipoMapa == 'mapbox/light-v10') {
          tipoMapa = 'mapbox/outdoors-v11';
        } else if (tipoMapa == 'mapbox/outdoors-v11') {
          tipoMapa = 'mapbox/satellite-streets-v11';
        } else {
          tipoMapa = 'mapbox/streets-v11';
        }
        setState(() {
          print(tipoMapa);
        });
      },
    );
  }
}
