import 'package:e_commerce_app/phonecard.dart';
import 'package:e_commerce_app/stateprovider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/cartscreen.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<phoneData> phoneRecord = [
    const phoneData(
      image: 'assets/images/phone1.png',
      phoneName: 'Samsung S7 Pro',
      price: 'Rs 46000',
    ),
    const phoneData(
      image: 'assets/images/phone2.png',
      phoneName: 'Xiaomi 12 Pro',
      price: 'Rs 20000',
    ),
    const phoneData(
      image: 'assets/images/phone3.png',
      phoneName: 'OnePlus Nord 3',
      price: 'Rs 27000',
    ),
    const phoneData(
      image: 'assets/images/phone4.png',
      phoneName: 'Apple Iphone 15',
      price: 'Rs 150000',
    ),
    const phoneData(
      image: 'assets/images/phone5.png',
      phoneName: 'Galaxy S22 Ultra',
      price: 'Rs 72000',
    ),
    const phoneData(
      image: 'assets/images/phone6.png',
      phoneName: 'Galaxy S23',
      price: 'Rs 18000',
    ),
    const phoneData(
      image: 'assets/images/phone7.png',
      phoneName: 'IQOO 12 5G',
      price: 'Rs 26000',
    ),
    const phoneData(
      image: 'assets/images/phone8.png',
      phoneName: 'Nothing Phone 3',
      price: 'Rs 48000',
    ),
    const phoneData(
      image: 'assets/images/phone9.png',
      phoneName: 'Flair X41',
      price: 'Rs 1500',
    ),
    const phoneData(
      image: 'assets/images/phone10.png',
      phoneName: 'IQOO 9 5G',
      price: 'Rs 21000',
    ),
    const phoneData(
      image: 'assets/images/phone11.png',
      phoneName: 'Oppo Z9 Ultra',
      price: 'Rs 33000',
    ),
    const phoneData(
      image: 'assets/images/phone12.png',
      phoneName: 'Narzo 60 Pro 5G',
      price: 'Rs 28000',
    ),
    const phoneData(
      image: 'assets/images/phone13.png',
      phoneName: 'Tecno Camon 20',
      price: 'Rs 29000',
    ),
    const phoneData(
      image: 'assets/images/phone14.png',
      phoneName: 'Tecno Phantom V',
      price: 'Rs 78000',
    ),
    const phoneData(
      image: 'assets/images/phone15.png',
      phoneName: 'Nokia G42 5G',
      price: 'Rs 17000',
    ),
    const phoneData(
      image: 'assets/images/phone16.png',
      phoneName: 'Samsung M14 5G',
      price: 'Rs 16000',
    ),
    const phoneData(
      image: 'assets/images/phone17.png',
      phoneName: 'Lava Agni R',
      price: 'Rs 17000',
    ),
    const phoneData(
      image: 'assets/images/phone18.png',
      phoneName: 'Oppo A79 5G',
      price: 'Rs 23000',
    ),
    const phoneData(
      image: 'assets/images/phone19.png',
      phoneName: 'Vivo Y100 5G',
      price: 'Rs 31000',
    ),
    const phoneData(
      image: 'assets/images/phone20.png',
      phoneName: 'Vivo Y27',
      price: 'Rs 41000',
    ),
  ];

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
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                              create: (_) => stateProvider(),
                              child: const CartScreen(title: 'TecnoBiz'))));
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Color(0xffffffff),
                )),
          ],
        ),
        body: GridView.builder(
            itemCount: phoneRecord.length,
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return PhoneCard(
                data: phoneRecord[index],
                ind: index,
              );
            }));
  }
}
