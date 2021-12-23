import 'dart:convert';

import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final productName;
  final productThumbnail;
  final productCateogry;
  final productDecription;
  final produectPrice;
  const ProductDetails(
      {Key? key,
      this.productName,
      this.productThumbnail,
      this.productCateogry,
      this.productDecription,
      this.produectPrice})
      : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Map<String, dynamic> mapdata = abc['blocks'];
    // mapdata.forEach((key, value) {
    //   print(key);
    // });
  }

  @override
  Widget build(BuildContext context) {
    var decondedString = jsonDecode(widget.productDecription);
    var desc = decondedString['blocks'][0]['data']['text'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black87,
        ),
        title: Text(
          '${widget.productName}',
          style: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Image.network(widget.productThumbnail),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Material(
                elevation: 5,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Container(
                    margin: EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.productName}',
                              style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              '\$${widget.produectPrice}',
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Type',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              '${widget.productCateogry}',
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '$desc',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
