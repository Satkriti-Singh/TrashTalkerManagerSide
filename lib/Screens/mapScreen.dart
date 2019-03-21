import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dumsters/Screens/detailScreen.dart';
import 'package:dumsters/data/bindata.dart';
import 'package:dumsters/data/locationdata.dart';

class MapServicesScreen extends StatefulWidget {
 

  MapServicesScreen();
  @override
  @override
  State<StatefulWidget> createState() {
    return _MapServicesScreen();
  }
}

class _MapServicesScreen extends State<MapServicesScreen> {

 @override
  void initState() {
    
    super.initState();
   
  }


  GoogleMapController mapController;

 final LatLng _center = const LatLng(12.9721,79.1596);

 void _onMapCreated(GoogleMapController controller) {
   mapController = controller;
   addMarkerWrapper();
   
}

   MapType _currentMapType = MapType.normal;

  _MapServicesScreen();
  

  @override
  Widget build(BuildContext context) {

  
    // TODO: implement build
    return  Container
    (child:Stack(
          children: <Widget>[
                            GoogleMap(
onMapCreated: _onMapCreated,
//mapType: _currentMapType,
         options: GoogleMapOptions(
           mapType: _currentMapType,
           cameraPosition: CameraPosition(
             target: _center,
             
             zoom: 11.0,
           ),
           
),
    ),
          ],
        ),
);
     
//           child: Stack(
//             children: <Widget>[
//                  GoogleMap(
// onMapCreated: _onMapCreated,
//          options: GoogleMapOptions(
//            cameraPosition: CameraPosition(
//              target: _center,
//              zoom: 11.0,
//            ),
           
// ),
//     ),
   
//             ],
//           ),
      
//      );
  }

  void _change()
  {
        Navigator.push(
   context,
   MaterialPageRoute(builder: (context) =>LoadingPage()));
    
  }

  int id;

    var map = <String, Bin> {};
    

 Future<Marker> addMarkerWrapper() async {
   
   for(int i=0;i<binData.length;i++)
   {
     double col;
     if(binData[i].level<=5)
     {
        mapController.addMarker(
     MarkerOptions(
       position: LatLng(
        //  mapController.cameraPosition.target.latitude,
        //  mapController.cameraPosition.target.longitude,
        binData[i].latitude,binData[i].longitude
       ),
      
       infoWindowText: InfoWindowText(binData[i].title,binData[i].description),
       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
       
     ),
     
   ).then((marker){
     map[marker.id]=binData[i];
     return marker;
   });
     }
     else if(binData[i].level<=7)
     {
       mapController.addMarker(
     MarkerOptions(
       position: LatLng(
        //  mapController.cameraPosition.target.latitude,
        //  mapController.cameraPosition.target.longitude,
        binData[i].latitude,binData[i].longitude
       ),
      
       infoWindowText: InfoWindowText(binData[i].title,binData[i].description),
       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
       
     ),
     
   ).then((marker){
     map[marker.id]=binData[i];
     return marker;
   });
     }
     else{
       mapController.addMarker(
     MarkerOptions(
       position: LatLng(
        //  mapController.cameraPosition.target.latitude,
        //  mapController.cameraPosition.target.longitude,
        binData[i].latitude,binData[i].longitude
       ),
      
       infoWindowText: InfoWindowText(binData[i].title,binData[i].description),
       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
       
     ),
     
   ).then((marker){
     map[marker.id]=binData[i];
     return marker;
   });
     }
  
  

   }
    mapController.onMarkerTapped.add((marker) {

      var selectedMarker = map[marker.id];
      print(selectedMarker.latitude);
      print(selectedMarker.longitude);
      print(selectedMarker.title);
      String lat=selectedMarker.latitude.toString();
      String long=selectedMarker.longitude.toString();
      String title=selectedMarker.title.toString();

      showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
          return Container(
            child: new Wrap(
            children: <Widget>[
new ListTile(
            leading: new Icon(Icons.map),
            title: new Text('$lat'),
            onTap: () => {}          
          ),
          new ListTile(
            leading: new Icon(Icons.map),
            title: new Text('$long'),
            onTap: () => {},          
          ),
           new ListTile(
            leading: new Icon(Icons.delete),
            title: new Text('$title'),
            onTap: () => {},          
          ),
            ],
          ),
          );
      }
    );
         
        
         
        });
  
}

void _onMapTypeButtonPressed() {
  setState(() {
    print("yoyooy");
    if(_currentMapType==MapType.normal){
      _currentMapType=MapType.satellite;
      print(_currentMapType);
    }
    else{
      _currentMapType=MapType.normal;
    }
  });
}

}