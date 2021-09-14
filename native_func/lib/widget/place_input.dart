import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:native_func/helpers/location_helper.dart';

class PlaceInput extends StatefulWidget {
  const PlaceInput({Key? key}) : super(key: key);

  @override
  _PlaceInputState createState() => _PlaceInputState();
}

class _PlaceInputState extends State<PlaceInput> {
  String? _perviewImageUrl;
  Location location = new Location();

  Future<bool> permision() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<void> _getCurretUserLocation() async {
    LocationData _locationData;
    bool permisionstate = await permision();
    if (permisionstate) {
      _locationData = await location.getLocation();
      final preivw = LocationHelper.generateLocationPerviewImage(
          _locationData.latitude, _locationData.latitude);
      print(preivw);
      setState(() {
        _perviewImageUrl = preivw;
      });
    } else {
      print("Declined");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.infinity,
          child: _perviewImageUrl == null
              ? Text("No Location", textAlign: TextAlign.center)
              : Image.network(
                  _perviewImageUrl.toString(),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: _getCurretUserLocation,
                icon: Icon(Icons.location_on),
                label: Text("Current Location")),
            TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.map),
                label: Text("Select on Map"))
          ],
        )
      ],
    );
  }
}
