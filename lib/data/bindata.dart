final List<Bin> binData= [
           new Bin(
             latitude: 12.9710,
             longitude: 79.1637,
             title: "Bin 1",
             description: "Empty",
             level:0
           ),
            new Bin(
             latitude: 12.9721,
             longitude: 79.1596,
             title: "Bin 2",
             description: "Filled",
             level:10
           ),
            new Bin(
             latitude: 12.9692 ,
             longitude: 79.1559,
             title: "Bin 3",
             description: "Normal",
             level:6
           )
        ];
        

        class Bin{
 
  double latitude;
  double longitude;
  String title;
  String description;
  int level;

  Bin({
    this.description,
    this.latitude,
    this.longitude,
    this.title,
    this.level
  });
        }