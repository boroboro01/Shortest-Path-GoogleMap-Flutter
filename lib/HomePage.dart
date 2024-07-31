import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maptest/function/dijkstra.dart';
import 'package:haversine_distance/haversine_distance.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(37.3020925824326, 127.017628695068),
    zoom: 14,
  );

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  List<LatLng> latLen = [];

  List<Location> locations = [
    Location(37.30109771543584, 127.0351513527889), // kgu
    Location(37.30208375426835, 127.01761538348133), // phantom
    Location(37.29965411467012, 127.00978444287053), // wizPark
  ];

  // Future<List<geo.Location>> convert(String address) async {
  //   List<geo.Location> locations = await geo.locationFromAddress(address);
  //   for (var location in locations) {
  //     latLen.add(LatLng(location.latitude, location.longitude));
  //   }
  //   return locations;
  // }

  // List<String> addresses = [
  //   "Starfield Suwon",
  //   "34 Sammi-ro, Osan-si, Gyeonggi-do, South Korea",
  //   "Gumi-si"
  // ];

  Future<void> initMarkers() async {
    // for (var address in addresses) {
    //   await convert(address);
    // }
    for (var location in locations) {
      latLen.add(LatLng(location.latitude, location.longitude));
    }
    for (int i = 0; i < latLen.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: latLen[i],
        infoWindow: const InfoWindow(
          title: 'This is title',
          snippet: 'This is snippet',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      setState(() {});
      _polyline.add(Polyline(
        polylineId: const PolylineId('1'),
        points: latLen,
        color: Colors.green,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    Dijkstra dijikstra = Dijkstra();
    initMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F9D58),
        // title of app
        title: const Text("GFG"),
      ),
      body: Container(
        child: SafeArea(
          child: GoogleMap(
            //given camera position
            initialCameraPosition: _kGoogle,
            // on below line we have given map type
            mapType: MapType.normal,
            // specified set of markers below
            markers: _markers,
            // on below line we have enabled location
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            // on below line we have enabled compass location
            compassEnabled: true,
            // on below line we have added polylines
            polylines: _polyline,
            // displayed google map
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ),
    );
  }
}
