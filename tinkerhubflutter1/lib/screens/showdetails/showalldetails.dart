import 'package:flutter/material.dart';

class ShowAllDetail extends StatelessWidget {
  static const routeName = "/showall";
  const ShowAllDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map argu = ModalRoute.of(context).settings.arguments;
    return Scaffold(
          body: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Stack(
            children: [
              Image.asset('assets/img/home1.jpg'),
              Align(
                alignment: Alignment.topLeft,
                child: Column(children: [
                  SizedBox(height: 30),
                  IconButton(icon: Icon(Icons.arrow_left), onPressed: (){Navigator.of(context).pop();})
                ],)
              )
            ],

        ),
        Text(argu['hsname']),
        ],
        
      ),
          ),
    );
  }
}