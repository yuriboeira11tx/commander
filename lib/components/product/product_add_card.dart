import 'package:commander/models/product.dart';
import 'package:flutter/material.dart';

class ProductAddCard extends StatefulWidget {
  const ProductAddCard({
    super.key,
    required this.product,
    required this.updateProductCallback,
  });
  final Product product;
  final Function(int id, int quantity, String obs) updateProductCallback;

  @override
  State<ProductAddCard> createState() => _ProductAddCardState();
}

class _ProductAddCardState extends State<ProductAddCard> {
  TextEditingController obsController = TextEditingController();
  int quantity = 0;

  // métodos de controle
  void incrementQuantity() {
    if (!mounted) return;
    setState(() {
      quantity++;
    });

    widget.updateProductCallback(
      widget.product.id!,
      quantity,
      obsController.text,
    );
  }

  void decrementQuantity() {
    if (!mounted) return;
    setState(() {
      quantity--;
    });

    widget.updateProductCallback(
      widget.product.id!,
      quantity,
      obsController.text,
    );
  }

  @override
  void dispose() {
    obsController.dispose();
    super.dispose();
  }

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
          subtitle: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextField(
                  controller: obsController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Observação",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              /*Chip(
                backgroundColor: Colors.white,
                label: Text(
                  "R\$ ${widget.product.price}",
                  style: const TextStyle(
                    color: colorTitle,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),*/
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                splashRadius: 30,
                onPressed: quantity > 0 ? decrementQuantity : null,
                icon: Icon(
                  Icons.remove,
                  color: quantity > 0 ? Colors.white : Colors.grey,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "$quantity",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                splashRadius: 30,
                onPressed: incrementQuantity,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
