import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frontend/util/locationmanager.dart';
import 'package:frontend/util/locations.dart';
import 'package:frontend/util/palette.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
// Suitable for most situations

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  keyRow(Color color, String text) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          markerCircle(color),
          const SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 18),
          )
        ],
      );

  markerCircle(Color color) => Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ));

  Marker buildMarker(double lat, double long, Color color) => Marker(
      width: 20,
      height: 20,
      point: LatLng(lat, long),
      builder: (ctx) => markerCircle(color)
      // const FlutterLogo(
      //   textColor: Colors.blue,
      //   key: ObjectKey(Colors.blue),
      // ),
      );

  // List<List<double>> stores = [
  //   [51.52508720339613, -0.13688997453422003],
  //   [51.523094618447885, -0.14107422059745245],
  //   [51.52409092182112, -0.13898209756583624],
  // ];

  // List<List<double>> foodbanks = [
  //   [51.52661010733251, -0.10202039135743135],
  //   [51.51066751941836, -0.13549435986329073],
  //   [51.518639510948724, -0.11875737561036104],
  // ];

  late List<Marker> markers = PinLocation.allLocs.map(
    (PinLocation val) {
      Color pinColor = Palette.background;
      switch (val.type) {
        case LocationType.Store:
          pinColor = Palette.secondary;
          break;
        case LocationType.FoodBank:
          pinColor = Palette.primary;
          break;
      }

      return buildMarker(val.coords[0], val.coords[1], pinColor);
    },
  ).toList();
  // .addAll(foodbanks.map(
  //   (List<double> val) {
  //     return buildMarker(val[0], val[1], Palette.primary);
  //   },
  // ));

  Future<Position> getCurrentPos = LocationManager.determinePosition();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Map View",
          style: TextStyle(fontSize: 24, color: Palette.highEmphasis),
        ),
        centerTitle: true,
        backgroundColor: Palette.background,
      ),
      // drawer: drawer(context, route),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // const Padding(
            //   padding: EdgeInsets.only(top: 8, bottom: 8),
            //   // child: Text('This is a map that is showing (51.5, -0.9).'),
            // ),
            Container(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  keyRow(Colors.red[600]!, "Your location"),
                  keyRow(Palette.secondary, "Supermarkets and stores"),
                  keyRow(Palette.primary, "Food banks"),
                ],
                mainAxisSize: MainAxisSize.min,
              ),
            ),

            Flexible(
              child: FutureBuilder<Position>(
                  future: getCurrentPos,
                  builder: (context, snapshot) {
                    print(snapshot.connectionState);
                    if (snapshot.hasData) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          markers.add(buildMarker(snapshot.data!.latitude,
                              snapshot.data!.longitude, Colors.red[600]!));
                        });
                      });
                      return FlutterMap(
                        options: MapOptions(
                            center: LatLng(
                              snapshot.data!.latitude,
                              snapshot.data!.longitude,
                            ),
                            zoom: 14
                            // zoom: 5,
                            ),
                        nonRotatedChildren: [
                          AttributionWidget.defaultWidget(
                            source: 'OpenStreetMap contributors',
                            onSourceTapped: () {},
                          ),
                        ],
                        layers: [
                          TileLayerOptions(
                            urlTemplate:
                                "https://snowmap.fast-sfc.com/base_snow_map/{z}/{x}/{y}.png",
                            //change base_snow_map to pistes
                            subdomains: ['a', 'b', 'c'],
                          ),
                          TileLayerOptions(
                              urlTemplate:
                                  "https://snowmap.fast-sfc.com/pistes/{z}/{x}/{y}.png",
                              //change base_snow_map to pistes
                              subdomains: ['a', 'b', 'c'],
                              backgroundColor: Colors.transparent),
                          MarkerLayerOptions(markers: markers)
                        ],
                        // children: [
                        //   TileLayer(
                        //     urlTemplate:
                        //         'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        //     userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                        //   ),
                        //   MarkerLayer(markers),
                        // ],
                      );
                    } else {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }
                      return const Center(
                        child:
                            CircularProgressIndicator(color: Palette.primary),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
