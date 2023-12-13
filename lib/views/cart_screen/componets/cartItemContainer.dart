import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/views/cart_screen/componets/cartColor.dart';

class CartItemContainer extends StatelessWidget {

  String image;
  String itemName;
  String itemPrice;
  String itemQuantity;
  String displayName;
  Function()? decreaseQuantity;
  Function()? increaseQuantity;

  static String limitStringLength(String input, int maxLength) {
    if (input.length <= maxLength) {
      return input;
    } else {
      return input.substring(0, maxLength) + "...";
    }
  }

  CartItemContainer({
    Key? key,
    required this.image,
    required this.itemName,
    required this.itemPrice,
    required this.itemQuantity,
    this.decreaseQuantity,
    this.increaseQuantity
  }) : displayName = limitStringLength(itemName.toString(), 30), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //a  row of image and text
          Row(
            children: [
              Image(
                  fit: BoxFit.cover,
                  height: 50,
                  width: 50,
                  image: NetworkImage(image)
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                children: [
                  Text(
                    displayName,
                    style: TextStyle(
                        color: CartColor.lightBlue,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    itemPrice,
                    style: TextStyle(
                      color: CartColor.darkText,
                      fontSize: 15,
                      //fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ],
          ),
          // button
          Container(
            padding: EdgeInsets.all(8),
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: CartColor.lightBlue)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.remove,
                  size: 15,
                  color: CartColor.lightBlue,
                ).onTap(() {
                  decreaseQuantity!();
                }),
                Text(
                  itemQuantity,
                  style: TextStyle(
                    fontSize: 20,
                    color: CartColor.lightBlue,
                  ),
                ),
                Icon(
                  Icons.add,
                  size: 15,
                  color: CartColor.lightBlue,
                ).onTap(() {
                  increaseQuantity!();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}