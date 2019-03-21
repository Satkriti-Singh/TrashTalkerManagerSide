import 'package:flutter/material.dart';

class WorkerDetail extends StatelessWidget{
   final String name,address,date,age,gender,id;
   int credits;
  WorkerDetail({Key key,@required this.id,@required this.name,@required this.address,@required this.date,@required this.age,@required this.credits,@required this.gender}) :super(key:key);

  @override
  Widget build(BuildContext context){
return Scaffold(
  appBar: new AppBar(
    title: new Text('Worker Details : $name'),
  ),
  body: Column(
    children: <Widget>[
Stack(
  children: <Widget>[

new Container(
  margin: EdgeInsets.only(top: 135.0),
        child: new  Center(
          child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 8.0,
          child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
             // padding: EdgeInsets.symmetric(horizontal: 115.0),
              margin:EdgeInsets.only(top: 50.0,bottom: 10.0),
              child: new Text('$name',style: Theme.of(context).textTheme.title),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: new Text('Address : $address',style: Theme.of(context).textTheme.subhead),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 115.0),
              margin: EdgeInsets.all(10.0),
              child: new Text('Age : $age',style: Theme.of(context).textTheme.subhead),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: new Text('Date of joining : $date',style: Theme.of(context).textTheme.subhead),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: new Text('Gender : $gender',style: Theme.of(context).textTheme.subhead),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 60.0),
              margin: EdgeInsets.only(top:10.0,bottom: 30.0),
              child: 
                new Text('Credits : $credits',style: Theme.of(context).textTheme.subhead),
            ),
          ],
        ) ,
        ),
        )
      ),
      new Center(
  child: new Container(
     margin: new EdgeInsets.only(top: 70.0,left: 125.0),
     alignment: FractionalOffset.centerLeft,
     child: new IconButton(
       icon: Icon(Icons.account_circle,size: 100.0,color: Colors.amberAccent,),
    ),
  ),
),
  ],
),  
    ],
  ),
    );
  }
}