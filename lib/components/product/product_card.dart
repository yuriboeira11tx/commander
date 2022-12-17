import 'package:commander/models/product.dart';
import 'package:commander/utils/styles.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 6,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(
            64,
            75,
            96,
            0.9,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          leading: Container(
            padding: const EdgeInsets.only(
              right: 12.0,
            ),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 1.0,
                  color: Colors.white24,
                ),
              ),
            ),
            child: const Icon(
              Icons.wine_bar,
              color: Colors.white,
            ),
          ),
          title: Text(
            "${widget.product.name}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Chip(
            backgroundColor: Colors.white,
            label: Text(
              "R\$${widget.product.price.toString().replaceFirst(".", ",")}",
              style: const TextStyle(
                color: colorTitle,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
