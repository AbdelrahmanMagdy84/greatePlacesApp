import 'package:flutter/material.dart';
import 'package:greate_places_app/providers/placeProvider.dart';
import 'package:greate_places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("PlacesListScreen build");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Greate Places"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future:
              Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return Consumer<Places>(
              child: const Center(child: Text("there is no places yet")),
              builder: (context, places, child) {
                if (places.getPlaces.isEmpty) {
                  return child!;
                } else {
                  return ListView.builder(
                    itemCount: places.getPlaces.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(
                              places.getPlaces[index].image,
                              scale: 0.5),
                        ),
                        title: Text(places.getPlaces[index].title),
                      );
                    },
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
