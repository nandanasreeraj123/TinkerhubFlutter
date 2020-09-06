import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../config/globalvar.dart' as config;

class FormPage extends StatefulWidget {
    static const routeName = "/forms";

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  
  bool _isLoading = false;
    Map formData = {
      'houseName':null,
      'description':null,
      'numbOfBedRoom':null,
  
      'imageUrl':null,

    };

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Future<void> sending() async {
    setState(() {
      _isLoading = true;
    });
    final _encodes=json.encode(formData);
    final _fetchData = await http.post('${config.baseUrl}house',
    body:_encodes,headers:{"Content-type":"application/json"});
    setState(() {
      _isLoading = false;
    });

  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
          body: SafeArea(
                      child: SingleChildScrollView(
                        child: Container(
        child: Column(
              children:[
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(keyboardType: TextInputType.text,decoration: InputDecoration(
                          hintText:"name",
                        ),
                        onSaved: (val){
                          formData['houseName']=val;
                        },
                        validator: (val){
                          if(val.length>20){
                            return 'Give short name';
                          }
                          return null;
                        },
                        onChanged: (val){},
                        
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(keyboardType: TextInputType.number,decoration: InputDecoration(
                          hintText:"img url",
                        ),
                        onSaved: (val){
                          formData['imageUrl']=val;
                        },
                        
                        onChanged: (val){},
                        
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(keyboardType: TextInputType.number,decoration: InputDecoration(
                          hintText:"number Of BedRoom",
                        ),
                        onSaved: (val){
                          formData['numbOfBedRoom']=val;
                        },
                        
                       
                        
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(keyboardType: TextInputType.text,decoration: InputDecoration(
                          hintText:"Specs",
                        ),
                        onSaved: (val){
                          formData['description']=val;
                        },
                        
                        
                        ),
                      ),
                      _isLoading? Center(child: CircularProgressIndicator()):
                      RaisedButton(
                        color: Colors.blueAccent,
                        textColor: Colors.white24,
                        onPressed: (){
                        

                        if(! _formKey.currentState.validate()){
                          return;
                        }
                        _formKey.currentState.save();
                        print(formData);
                        sending();
                      },
                      child: Text("Submit"))
                    ],
                  ),




                ),
              ],
        ) ,
      ),
            ),
          ),
    );
  }
}