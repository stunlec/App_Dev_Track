//import 'package:e_commerce_app/phonecard.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/stateprovider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.title});

  final String title;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xff202624),
            centerTitle: true,
            title: Text(
              widget.title,
              style: const TextStyle(
                  color: Color(0xfffeffff),
                  fontFamily: 'SofaChrome',
                  fontSize: 26),
            )),
        body: Consumer<stateProvider>(builder: (context, value, child) {
          if (value.phonelist.isEmpty) {
            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Add products to your cart!',
                      style: TextStyle(
                          fontFamily: 'Expressway',
                          fontSize: 22,
                          color: Color(0xffdd5563)),
                    ),
                    SizedBox(
                      height: 28,
                      //width: 80,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Go Back')),
                    )
                  ]),
            );
          } else {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView.separated(
                    itemCount: value.phonelist.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(value.phonelist[index].phoneName),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  )
                ]);
          }
        }));
  }
}
