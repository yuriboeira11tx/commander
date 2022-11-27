import 'package:commander/components/command_card.dart';
import 'package:commander/components/product_card.dart';
import 'package:commander/controllers/products_controller.dart';
import 'package:flutter/material.dart';

class ProductsTab extends StatefulWidget {
  const ProductsTab({
    super.key,
  });

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  List products = [];
  ProductsController productsController = ProductsController();

  @override
  void initState() {
    super.initState();
    productsController.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        productsController.products,
        productsController.isLoading,
      ]),
      builder: ((context, child) {
        if (productsController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: productsController.products.value.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: productsController.products.value[index],
              );
            },
          );
        }
      }),
    );
  }
}
