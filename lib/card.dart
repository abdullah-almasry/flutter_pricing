import 'package:flutter/material.dart';
import 'dart:math';

class CardItem extends StatefulWidget {

  final String text, img,pricing;
  final Color color;
  final IconData icon;

  CardItem(this.text, this.color, this.img, this.icon,this.pricing);

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    String name = widget.pricing;
    var name1 = '0${_textEditingController.text}';
    double Numper = double.parse(name);
    double Numper1 = double.parse(name1);
    var result = Numper * Numper1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.70,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                child: Image.asset(
                  widget.img,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.20,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      widget.icon,
                      color: Colors.white,
                    ),
                    Text(
                      widget.text,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              Center(
                  child: Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
              )),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Colors.white),
                  child: TextField(

                      style: TextStyle(fontWeight: FontWeight.bold),
                    controller: _textEditingController,
                    onChanged: (value) {
                      setState(() {
                        name1 = value;
                      });
                    },
                    textInputAction: TextInputAction.done,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        hintText: "..اكتب العدد هنا",
                        hintStyle: TextStyle(fontSize: 12)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  "${result.toStringAsFixed(2)}EGP",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
