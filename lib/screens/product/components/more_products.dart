import 'package:ecommerce_int2/screens/product/components/product_card.dart';
import 'package:ecommerce_int2/screens/product/components/product_display.dart';
import 'package:flutter/material.dart';

class MoreProducts extends StatelessWidget {

  // final List<Product> products = [
  //   Product(
  //       image:'assets/product_thumb_1.png',
  //       name: 'Dog Shampoo (Perfumed) - 250ml',
  //       description: 'description',
  //       price: "45.3")
  // ];

  List<dynamic> product_ids;
  MoreProducts({required this.product_ids});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 24.0, bottom: 8.0),
          child: Text(
            'Related products',
            style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20.0),
          height: 250,
          child: ListView.builder(
            itemCount: product_ids.length,
            itemBuilder: (_, index) {
              return Padding(
                ///calculates the left and right margins
                ///to be even with the screen margin
                  padding: index == 0
                      ? EdgeInsets.only(left: 24.0, right: 8.0)
                      : index == 4
                      ? EdgeInsets.only(right: 24.0, left: 8.0)
                      : EdgeInsets.symmetric(horizontal: 8.0),
                  child: ProductCardSelfLoad(id : product_ids[index].toString()));
            },
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }
}
