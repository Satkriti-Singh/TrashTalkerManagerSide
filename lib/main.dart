import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dumsters/Screens/mapScreen.dart';
import 'package:dumsters/data/workers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:dumsters/Screens/workerProfile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LogIn(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  String title;
  String user_id,user_name,user_address,user_age,user_date,user_gender;
  int user_credits;

  MyHomePage({Key key, this.title,this.user_id,this.user_address,this.user_age,this.user_credits,this.user_date,this.user_gender,this.user_name}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(12.9721,79.1596);

  void _onMapCreated(GoogleMapController controller) {
   mapController = controller;}

  int _selectedIndex = 0;
  final _widgetOptions = [
    MapServicesScreen(),
    Text('Hello')
    //WorkerDetail(id: MyHomePage(user_id),age: MyHomePage().user_age,address: MyHomePage().user_address,credits: MyHomePage().user_credits,date: MyHomePage().user_date,gender: MyHomePage().user_gender,name: MyHomePage().user_name),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold
    (
    body:_widgetOptions[_selectedIndex],
    bottomNavigationBar: 
    BottomNavigationBar(
      items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon:Icon(Icons.map),title: Text("Map")
      ),
      BottomNavigationBarItem(icon:Icon(Icons.person),title:Text("Profile"))
      ],
       currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
    ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class LogIn extends StatefulWidget{
  @override
  LogInState createState() => LogInState();
}
class LogInState extends State<LogIn> {
  String name;
  List<Workers> allData = [];
  GlobalKey<FormState> _key = new GlobalKey();
  bool autovalidate = false;

  @override
  void initState(){

    DatabaseReference ref =FirebaseDatabase.instance.reference();
    ref.child('workersList').once().then((DataSnapshot snap){
      var keys = snap.value.keys;
      var data =  snap.value;
      allData.clear();
      for(var key in keys){
        allData.add(new Workers(key,data[key]['name'], data[key]['address'], data[key]['age'],data[key]['date'], data[key]['credits'],data[key]['gender']));
      }
      setState(() {
      //print('Length: $allData.length'); 
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
      title: new Text("Trash Talker"),
  ),
  body:Container(
    child: Center(
      child: formUI(),
     )) );
  }

Widget formUI(){
  return Column(
      children: <Widget>[
        Container(
        margin: EdgeInsets.only(top: 150.0,left: 30.0,right: 30.0),
        child: Form(
          key: _key,
          autovalidate: autovalidate,
          child: Column(
            children: <Widget>[
              TextFormField(
        maxLength: 20,
        decoration: InputDecoration(
            labelText: 'UserName',
          ),
         validator: validateName,
          onSaved: (val){
            name=val;
          },
    ),
    RaisedButton(
      child: Text('Log In'),
      onPressed: _onItemTapped,
      color: Colors.lightBlue,
      textColor: Colors.white,
    )
            ],
          ),
        ) 
        
        
        ),
        
      ],
    );
}
   String validateName(String val){
    return val.length == 0 ? "Enter your name" : null;
    }

  void _onItemTapped() {

    if(_key.currentState.validate()){
    _key.currentState.save();
    

    for(int i=0;i<allData.length;i++){
      if(allData[i].name==name){
        print(name +"       "+allData[i].name);
        print(allData[i].address);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>  MyHomePage(title: 'Flutter Demo Home Page',user_id: allData[i].id,user_address:allData[i].address,user_age:allData[i].age,user_credits:allData[i].credits,user_date:allData[i].date,user_gender:allData[i].gender,user_name: allData[i].name)));
      }
      else{
        print(name);
      }
    }
    } 
  else{
    setState(() {
     autovalidate=true; 
    });
  }}
}