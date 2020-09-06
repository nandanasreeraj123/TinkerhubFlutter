import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import '../config/globalvar.dart' as config;
import 'package:tinkerhubflutter1/model/models.dart';
import 'package:tinkerhubflutter1/screens/form/forms.dart';
import 'package:tinkerhubflutter1/screens/showdetails/showalldetails.dart';

import 'widg/CustomAppBar.dart';

class Homepage extends StatelessWidget {
  // void OnPress(BuildContext context) {
  //   Navigator.of(context).pushNamed(ShowAllDetail.routeName, arguments: arguments);
  // }
  Future<void> sending() async {
    
    // final _encodes=json.encode(formData);
    final _fetchData = await http.get('${config.baseUrl}house');
    final _decodes=json.decode(_fetchData.body);
    print(_decodes);
    for (var item in _decodes) {
      houses.add(
        HouseData(
          hsname: item['houseName'],
          img:item['imageUrl'],
          bedroom: item['numbOfBedRoom'],
          description: item['description'],
        )
      );
    }


  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<HouseData> houses = [
    
    // (HouseData(
    //     hsname: "House1",
    //     bathroom: 2,
    //     bedroom: 2,
    //     price: 200,
    //     desc: "Good house")),
    //     (HouseData(
    //     hsname: "House2",
    //     bathroom: 3,
    //     bedroom: 1,
    //     price:550,
    //     desc: "Nice house"))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children:[
            ListTile(
              title: Text('form'),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(FormPage.routeName);
              }
            ),
          ],
        ),
      ),
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                
                // onTap: (){
                //   _scaffoldKey.currentState.openDrawer();
                // };
              ),
              Text(
                "City",
                style: TextStyle(fontSize: 13, color: Colors.black12),
              ),
              Specs(),
              SideScrolls(),
              FutureBuilder(
                future: sending(),
                
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: houses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Map arguments = {"hsname": houses[index].hsname};
                        Navigator.of(context).pushNamed(ShowAllDetail.routeName, arguments: arguments);

                      },

                      child: Product(
                          house: houses[index].hsname.toString(),
                          place: "XYZ",
                          spec: houses[index].description,
                          imghere: houses[index].img),
                    );
                  });
              
                },
              ),
              
            ],
          ),
        ),
      )),
    );
  }
}

class SideScrolls extends StatelessWidget {
  const SideScrolls({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 45,
        margin: EdgeInsets.all(8),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            GrayBox(cont: "\$8000"),
            GrayBox(cont: "\$8000"),
            GrayBox(cont: "\$8000"),
            GrayBox(cont: "\$8000"),
            GrayBox(cont: "\$8000"),
            GrayBox(cont: "\$8000"),
            GrayBox(cont: "\$8000"),
            GrayBox(cont: "\$8000"),
          ],
        ));
  }
}

class Specs extends StatelessWidget {
  const Specs({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        "Sanfransisco",
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.normal),
      ),
      Icon(Icons.more_vert)
    ]);
  }
}

class Product extends StatelessWidget {
  const Product({
    Key key,
    this.house,
    this.place,
    this.imghere,
    this.spec,
  }) : super(key: key);
  final String house, place, spec, imghere;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            child: Image.network("${imghere}", fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(30),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text("hi",
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
              ),
              Text("$place",
                  style: TextStyle(fontSize: 13, color: Colors.black26)),
            ]),
          ),
          Text("${spec}", style: TextStyle(fontSize: 13)),
        ]),
        Positioned(
          right: 20,
          top: 20,
          child: Heart(),
        )
      ]),
    );
  }
}

class Heart extends StatefulWidget {
  const Heart({
    Key key,
  }) : super(key: key);

  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  bool _fav=false;
  @override
  Widget build(BuildContext context) {
    
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onTap: (){
              setState((){
                _fav = !_fav;
              });
            },
            child: Icon(_fav?Icons.favorite:Icons.favorite_border,
            color: _fav?Colors.red:Colors.black)),
        ));
  }
}

class GrayBox extends StatelessWidget {
  const GrayBox({
    Key key,
    this.cont,
  }) : super(key: key);
  final String cont;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text("$cont", style: TextStyle(fontSize: 13)),
        ));
  }
}
