import 'package:flutter/material.dart';
import 'package:native_func/providers/great_places.dart';
import 'package:native_func/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: [
          IconButton(
              onPressed: () =>
                  {Navigator.of(context).pushNamed(AddPlacesList.routeName)},
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    child: const Center(
                      child: Text("There are not places Please ad some"),
                    ),
                    builder: (ctx, dataSnap, ch) => myTile(dataSnap, ctx),
                  ),
      ),
    );
  }
}

Widget myTile(GreatPlaces data, ctx) {
  if (data.items.length > 0) {
    return ListView.builder(
        itemCount: data.items.length,
        itemBuilder: (ctx, i) => ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(data.items[i].image),
              ),
              title: Text(data.items[i].title),
            ));
  } else {
    return Text("No Data");
  }
}
