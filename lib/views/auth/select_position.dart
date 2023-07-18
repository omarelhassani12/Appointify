import 'package:appointify/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

class PositionSelectMap extends StatefulWidget {
  const PositionSelectMap({Key? key}) : super(key: key);

  @override
  State<PositionSelectMap> createState() => _PositionSelectMapState();
}

class _PositionSelectMapState extends State<PositionSelectMap> {
  List<Marker> markers = [];
  LatLng? selectedPosition;

  @override
  void initState() {
    super.initState();
    // Add your markers to the list here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Hubs'),
        centerTitle: true,
        backgroundColor: AppColors.accentClr,
        elevation: 0,
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(32.0705308044035, -8.627310516912205),
          zoom: 6,
          maxZoom: 20,
          onTap: (tapPosition, latLng) => _onMapTapped(latLng),
        ),
        children: <Widget>[
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              maxClusterRadius: 45,
              size: const Size(40, 40),
              anchor: AnchorPos.align(AnchorAlign.center),
              fitBoundsOptions: const FitBoundsOptions(
                padding: EdgeInsets.all(50),
                maxZoom: double.infinity,
              ),
              markers: markers + _buildSelectedPositionMarker(),
              builder: (context, markers) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.accentClr,
                  ),
                  child: Center(
                    child: Text(
                      markers.length.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: selectedPosition != null
          ? FloatingActionButton(
              onPressed: () {
                // Do something with the selected position, like make an appointment
                print(
                  'Selected Position: ${selectedPosition!.latitude}, ${selectedPosition!.longitude}',
                );
                // You can proceed with making an appointment here
              },
              backgroundColor: AppColors.accentClr,
              child: const Icon(Icons.check),
            )
          : null,
    );
  }

  List<Marker> _buildSelectedPositionMarker() {
    return selectedPosition != null
        ? [
            Marker(
              width: 40.0,
              height: 40.0,
              point: selectedPosition!,
              builder: (ctx) =>
                  const Icon(Icons.location_on, color: Colors.blue),
            ),
          ]
        : [];
  }

  void _onMapTapped(LatLng latLng) {
    setState(() {
      selectedPosition = latLng;
    });
  }
}




// class _PositionSelectMapState extends State<PositionSelectMap> {
//   List<Marker> markers = [];
//   LatLng? selectedPosition;

//   @override
//   void initState() {
//     super.initState();
//     // Add your markers to the list here
//     markers.add(
//       Marker(
//         width: 40.0,
//         height: 40.0,
//         point: LatLng(32.0705308044035, -8.627310516912205),
//         builder: (ctx) => const Icon(Icons.location_on, color: Colors.red),
//       ),
//     );
//     markers.add(
//       Marker(
//         width: 40.0,
//         height: 40.0,
//         point: LatLng(32.0705308044035, -8.627310516912205),
//         builder: (ctx) => const Icon(Icons.location_on, color: Colors.red),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Appointment Hubs'),
//         centerTitle: true,
//         backgroundColor: AppColors.accentClr,
//         elevation: 0,
//       ),
//       body: FlutterMap(
//         options: MapOptions(
//           center: LatLng(32.0705308044035, -8.627310516912205),
//           zoom: 6,
//           maxZoom: 20,
//           onTap: (tapPosition, latLng) => _onMapTapped(tapPosition, latLng),
//         ),
//         children: <Widget>[
//           TileLayer(
//             urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//             subdomains: const ['a', 'b', 'c'],
//           ),
//           TileLayer(
//             urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//             subdomains: const ['a', 'b', 'c'],
//           ),
//           MarkerClusterLayerWidget(
//             options: MarkerClusterLayerOptions(
//               maxClusterRadius: 45,
//               size: const Size(40, 40),
//               anchor: AnchorPos.align(AnchorAlign.center),
//               fitBoundsOptions: const FitBoundsOptions(
//                 padding: EdgeInsets.all(50),
//                 maxZoom: double.infinity,
//               ),
//               markers: markers + _buildSelectedPositionMarker(),
//               builder: (context, markers) {
//                 return Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: AppColors.accentClr),
//                   child: Center(
//                     child: Text(
//                       markers.length.toString(),
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: selectedPosition != null
//           ? FloatingActionButton(
//               onPressed: () {
//                 // Do something with the selected position, like make an appointment
//                 print(
//                     'Selected Position: ${selectedPosition!.latitude}, ${selectedPosition!.longitude}');
//                 // You can proceed with making an appointment here
//               },
//               backgroundColor: AppColors.accentClr,
//               child: const Icon(Icons.check),
//             )
//           : null,
//     );
//   }

//   List<Marker> _buildSelectedPositionMarker() {
//     return selectedPosition != null
//         ? [
//             Marker(
//               width: 40.0,
//               height: 40.0,
//               point: selectedPosition!,
//               builder: (ctx) =>
//                   const Icon(Icons.location_on, color: Colors.blue),
//             ),
//           ]
//         : [];
//   }

//   void _onMapTapped(TapPosition tapPosition, LatLng latLng) {
//     setState(() {
//       selectedPosition = latLng;
//     });
//   }
// }






//without pointeur

// class PositionSelectMap extends StatefulWidget {
//   const PositionSelectMap({Key? key}) : super(key: key);

//   @override
//   State<PositionSelectMap> createState() => _PositionSelectMapState();
// }

// class _PositionSelectMapState extends State<PositionSelectMap> {
//   List<Marker> markers = [];
//   LatLng? selectedPosition;

//   @override
//   void initState() {
//     super.initState();
//     // Add your markers to the list here
//     markers.add(
//       Marker(
//         width: 40.0,
//         height: 40.0,
//         point: LatLng(51.509364, -0.128918),
//         builder: (ctx) => const Icon(Icons.location_on, color: Colors.red),
//       ),
//     );
//     markers.add(
//       Marker(
//         width: 40.0,
//         height: 40.0,
//         point: LatLng(51.5074, -0.1278),
//         builder: (ctx) => const Icon(Icons.location_on, color: Colors.red),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Appointment Hubs'),
//         centerTitle: true,
//         backgroundColor: AppColors.accentClr,
//         elevation: 0,
//       ),
//       body: FlutterMap(
//         options: MapOptions(
//           center: LatLng(51.509364, -0.128918),
//           zoom: 6,
//           maxZoom: 15,
//           onTap: (tapPosition, latLng) => _onMapTapped(tapPosition, latLng),
//         ),
//         children: <Widget>[
//           TileLayer(
//             urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//             subdomains: const ['a', 'b', 'c'],
//           ),
//           MarkerClusterLayerWidget(
//             options: MarkerClusterLayerOptions(
//               maxClusterRadius: 45,
//               size: const Size(40, 40),
//               anchor: AnchorPos.align(AnchorAlign.center),
//               fitBoundsOptions: const FitBoundsOptions(
//                 padding: EdgeInsets.all(50),
//                 maxZoom: 15,
//               ),
//               markers: markers,
//               builder: (context, markers) {
//                 return Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: AppColors.accentClr),
//                   child: Center(
//                     child: Text(
//                       markers.length.toString(),
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: selectedPosition != null
//           ? FloatingActionButton(
//               onPressed: () {
//                 // Do something with the selected position, like make an appointment
//                 print(
//                     'Selected Position: ${selectedPosition!.latitude}, ${selectedPosition!.longitude}');
//                 // You can proceed with making an appointment here
//               },
//               backgroundColor: AppColors.accentClr,
//               child: const Icon(Icons.check),
//             )
//           : null,
//     );
//   }

//   void _onMapTapped(TapPosition tapPosition, LatLng latLng) {
//     setState(() {
//       selectedPosition = latLng;
//     });
//   }
// }
