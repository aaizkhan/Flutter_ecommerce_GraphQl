import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final productName;
  final productThumbnail;
  final productCateogry;
  final productDecription;
  const ProductDetails(
      {Key? key,
      this.productName,
      this.productThumbnail,
      this.productCateogry,
      this.productDecription})
      : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
