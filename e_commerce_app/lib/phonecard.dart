import 'package:e_commerce_app/stateprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:e_commerce_app/homescreen.dart';

class phoneData {
  final String phoneName;
  final String price;
  final String image;

  const phoneData(
      {required this.phoneName, required this.price, required this.image});
}

class PhoneCard extends StatefulWidget {
  final phoneData data;
  final int ind;

  const PhoneCard({Key? key, required this.data, required this.ind})
      : super(key: key);

  @override
  State<PhoneCard> createState() => _PhoneCardState();
}

class _PhoneCardState extends State<PhoneCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 310,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 100,
            child: SizedBox(
              height: 160,
              width: 200,
              child: Card(
                color: const Color(0xffdd5563),
                elevation: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      widget.data.phoneName,
                      style: const TextStyle(
                        fontFamily: 'Expressway',
                        fontSize: 20,
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.data.price,
                      style: const TextStyle(
                        fontFamily: 'Expressway',
                        fontSize: 18,
                        color: Color(0xffffffff),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 30,
                      width: 150,
                      child: Consumer<stateProvider>(
                        builder: (context, value, child) {
                          return AddToCartButton(
                              data: widget.data, ind: widget.ind);
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 150,
            child: SizedBox(
              height: 150,
              width: 200,
              child: Image(
                image: AssetImage(widget.data.image),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  final phoneData data;
  final int ind;

  const AddToCartButton({Key? key, required this.data, required this.ind})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<stateProvider>(context, listen: false);

    if (!value.phonelist.any((item) =>
        item.phoneName == data.phoneName && item.price == data.price)) {
      return FloatingActionButton.extended(
        backgroundColor: const Color(0xff202624),
        label: const Text(
          'Add to cart',
          style: TextStyle(
            fontFamily: 'Expressway',
            fontSize: 18,
            color: Color(0xffffffff),
          ),
        ),
        icon: const Icon(
          Icons.shopping_cart_outlined,
          color: Color(0xffffffff),
        ),
        onPressed: () {
          value.addItem(data);
        },
        heroTag: 'btn1$ind',
      );
    } else {
      return RemoveFromCartButton(value: value, data: data, ind: ind);
    }
  }
}

class RemoveFromCartButton extends StatelessWidget {
  final stateProvider value;
  final phoneData data;
  final int ind;

  const RemoveFromCartButton(
      {Key? key, required this.value, required this.data, required this.ind})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Icon(
            Icons.check,
            color: Color(0xffffffff),
          ),
        ),
        Expanded(
          child: FloatingActionButton(
            backgroundColor: const Color(0xff202624),
            onPressed: () {
              value.removeItem(data);
            },
            heroTag: 'btn2$ind',
            child: const Icon(
              Icons.remove,
              color: Color(0xffffffff),
            ),
          ),
        )
      ],
    );
  }
}
