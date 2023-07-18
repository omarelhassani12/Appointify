import 'package:appointify/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; // Import the geocoding package

class PositionSelectMap extends StatefulWidget {
  const PositionSelectMap({Key? key}) : super(key: key);

  @override
  State<PositionSelectMap> createState() => _PositionSelectMapState();
}

class _PositionSelectMapState extends State<PositionSelectMap> {
  List<Marker> markers = [];
  LatLng? selectedPosition;
  final Geolocator geolocator = Geolocator();

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
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(32.0705308044035, -8.627310516912205),
              zoom: 6,
              maxZoom: 20,
              onTap: (tapPosition, latLng) => _onMapTapped(latLng),
            ),
            children: <Widget>[
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
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
          if (selectedPosition !=
              null) // Show the FAB only when a position is selected
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () => _showConfirmationAlert(context),
                backgroundColor: AppColors.accentClr,
                child: const Icon(Icons.check),
              ),
            ),
        ],
      ),
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
                  const Icon(Icons.location_on, color: AppColors.accentClr),
            ),
          ]
        : [];
  }

  void _onMapTapped(LatLng latLng) {
    setState(() {
      selectedPosition = latLng;
    });
  }

  Future<void> _showConfirmationAlert(BuildContext context) async {
    if (selectedPosition == null) return;

    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        selectedPosition!.latitude,
        selectedPosition!.longitude,
      );

      String locationName = 'Unknown Location';
      if (placemarks.isNotEmpty) {
        final Placemark placemark = placemarks.first;

        // Extract the country or city from the Placemark
        if (placemark.country != null) {
          locationName = placemark.country!;
        } else if (placemark.locality != null) {
          locationName = placemark.locality!;
        }
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirm Location'),
          content: Text('You have selected: $locationName'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the alert
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Do something with the selected position, like make an appointment
                print(
                  'Selected Position: ${selectedPosition!.latitude}, ${selectedPosition!.longitude}',
                );
                // You can proceed with making an appointment here

                Navigator.pop(context); // Close the alert
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error occurred while reverse geocoding: $e');
    }
  }
}




// import 'package:appointify/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// class PositionSelectMap extends StatefulWidget {
//   const PositionSelectMap({Key? key}) : super(key: key);

//   @override
//   State<PositionSelectMap> createState() => _PositionSelectMapState();
// }

// class _PositionSelectMapState extends State<PositionSelectMap> {
//   List<Marker> markers = [];
//   LatLng? selectedPosition;
//   final Geolocator _geolocator = Geolocator();

//   @override
//   void initState() {
//     super.initState();
//     // Add your markers to the list here
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
//           onTap: (tapPosition, latLng) => _onMapTapped(latLng),
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
//                 maxZoom: double.infinity,
//               ),
//               markers: markers + _buildSelectedPositionMarker(),
//               builder: (context, markers) {
//                 return Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: AppColors.accentClr,
//                   ),
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
//               onPressed: () => _showConfirmationAlert(context),
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
//                   const Icon(Icons.location_on, color: AppColors.accentClr),
//             ),
//           ]
//         : [];
//   }

//   void _onMapTapped(LatLng latLng) {
//     setState(() {
//       selectedPosition = latLng;
//     });
//   }

//   Future<void> _showConfirmationAlert(BuildContext context) async {
//     if (selectedPosition == null) return;

//     try {
//       final List<Placemark> placemarks = await placemarkFromCoordinates(
//         selectedPosition!.latitude,
//         selectedPosition!.longitude,
//       );

//       String locationName = 'Unknown Location';
//       if (placemarks.isNotEmpty) {
//         final Placemark placemark = placemarks.first;
//         locationName = placemark.name ??
//             placemark.locality ??
//             placemark.country ??
//             'Unknown Location';
//       }

//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Confirm Location'),
//           content: Text('You have selected: $locationName'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close the alert
//               },
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Do something with the selected position, like make an appointment
//                 print(
//                   'Selected Position: ${selectedPosition!.latitude}, ${selectedPosition!.longitude}',
//                 );
//                 // You can proceed with making an appointment here

//                 Navigator.pop(context); // Close the alert
//               },
//               child: const Text('Confirm'),
//             ),
//           ],
//         ),
//       );
//     } catch (e) {
//       print('Error occurred while reverse geocoding: $e');
//     }
//   }
// }













// import 'package:appointify/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
// import 'package:latlong2/latlong.dart';

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
//           onTap: (tapPosition, latLng) => _onMapTapped(latLng),
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
//                 maxZoom: double.infinity,
//               ),
//               markers: markers + _buildSelectedPositionMarker(),
//               builder: (context, markers) {
//                 return Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: AppColors.accentClr,
//                   ),
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
//               onPressed: () => _showConfirmationAlert(context),
//               // print(
//               //   'Selected Position: ${selectedPosition!.latitude}, ${selectedPosition!.longitude}',
//               // );
//               // },
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
//                   const Icon(Icons.location_on, color: AppColors.accentClr),
//             ),
//           ]
//         : [];
//   }

//   void _onMapTapped(LatLng latLng) {
//     setState(() {
//       selectedPosition = latLng;
//     });
//   }

//   Future<void> _showConfirmationAlert(BuildContext context) async {
//     if (selectedPosition == null) return;

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Confirm Location'),
//         content: Text('You have selected: '),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context); // Close the alert
//             },
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               print(
//                 'Selected Position: ${selectedPosition!.latitude}, ${selectedPosition!.longitude}',
//               );

//               Navigator.pop(context); 
//             },
          
//             child: const Text('Confirm'),
//           ),
//         ],
//       ),
//     );
//   }
// }
