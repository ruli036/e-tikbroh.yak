import 'package:e_tikbroh_yok/Controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Helpers/helpers.dart';
import '../../Helpers/widgets.dart';

class MapLocation extends StatelessWidget {
  const MapLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Text(
            cek.value.toString(),
            style: const TextStyle(color: Colors.transparent),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: const Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            height: size(context).height,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              // child: GetBuilder<ProfileController>(
              //   builder: (_) {
              //     Set<Circle> circles = MapHelper.addCircle();
              //     MapHelper.isWithinRadius().then((isWithinRadius) {
              //       if (isWithinRadius) {
              //         // Pengguna berada dalam radius, akses sistem di aplikasi Anda
              //         print('Anda berada dalam radius');
              //       } else {
              //         print('Anda berada di luar radius');
              //       }
              //     });
              //
              //     return GoogleMap(
              //       initialCameraPosition: initialCameraPosition,
              //       markers: Set.from(myMarker),
              //       zoomControlsEnabled: false,
              //       mapType: MapType.normal,
              //       onTap: onMapTap,
              //       onMapCreated: (GoogleMapController controller) {
              //         googleMapController = controller;
              //       },
              //       circles: circles.toSet(),
              //     );
              //   }
              // ),
            child: GoogleMap(
              initialCameraPosition: initialCameraPosition,
              markers: Set.from(myMarker),
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              onTap: onMapTap,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
            ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            child: Container(
              height: 30,
              child: FloatingActionButton(
                onPressed: () {
                  Get.defaultDialog(
                      title: "LOADING",
                      barrierDismissible: false,
                      content: LoadingView(text: "Mencari Lokasi Anda..."));
                  cekKoneksi(() => myLocation());
                },
                child: const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
