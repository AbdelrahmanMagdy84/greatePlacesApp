import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LoactionInput extends StatefulWidget {
  @override
  _LoactionInputState createState() => _LoactionInputState();
}

class _LoactionInputState extends State<LoactionInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentLocation() async {
    final locationData = await Location().getLocation();
    print(locationData.longitude);
    print(locationData.latitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
          ),
          child: _previewImageUrl == null
              ? Text('no location chosen')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              onPressed: _getCurrentLocation,
              icon: Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              label: Text(
                'current Location',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              onPressed: null,
              icon: Icon(
                Icons.map,
                color: Colors.white,
              ),
              label: Text(
                'select on map',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        )
      ],
    );
  }
}
