import 'package:commander/components/product/product_add_card.dart';
import 'package:commander/controllers/products_add_controller.dart';
import 'package:commander/models/command.dart';
import 'package:commander/utils/styles.dart';
import 'package:flutter/material.dart';

class ProductsAddTab extends StatefulWidget {
  const ProductsAddTab({
    super.key,
    required this.command,
  });
  final Command command;

  @override
  State<ProductsAddTab> createState() => _ProductsAddTabState();
}

class _ProductsAddTabState extends State<ProductsAddTab> {
  List products = [];
  ProductsAddController productsAddController = ProductsAddController();

  @override
  void initState() {
    super.initState();
    productsAddController.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: Listenable.merge([
            productsAddController.products,
            productsAddController.isLoading,
          ]),
          builder: ((context, child) {
            if (productsAddController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: productsAddController.products.value.length,
                itemBuilder: (context, index) {
                  return ProductAddCard(
                    product: productsAddController.products.value[index],
                    updateProductCallback: ((id, quantity, obs) {
                      productsAddController.updateProductsSelected(
                        id,
                        quantity,
                        obs,
                      );
                    }),
                  );
                },
              );
            }
          }),
        ),
        AnimatedBuilder(
          animation: Listenable.merge([
            productsAddController.productsToSend,
            productsAddController.isAdd,
          ]),
          builder: (context, child) {
            return Visibility(
              visible: productsAddController.productsToSend.value.isNotEmpty,
              child: Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: productsAddController.isAdd.value
                          ? null
                          : () async => await productsAddController
                              .sendOrders(widget.command),
                      child: productsAddController.isAdd.value
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [CircularProgressIndicator()],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.add,
                                  color: colorTitle,
                                ),
                                Text(
                                  "Adicionar na Comanda",
                                  style: TextStyle(
                                    color: colorTitle,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
