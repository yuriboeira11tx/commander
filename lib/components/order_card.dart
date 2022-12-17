import 'package:commander/models/order.dart';
import 'package:commander/utils/styles.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({
    super.key,
    required this.order,
  });
  final Order order;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.order.orders!.length,
            itemBuilder: (context, index) {
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
                      child: Chip(
                        backgroundColor: Colors.white,
                        label: Text(
                          "${widget.order.orders![index]['quantity']}x",
                          style: !widget.order.orders![index]['excluded']
                              ? styleTextSnackbar
                              : const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                        ),
                      ),
                    ),
                    title: Text(
                      "${widget.order.orders![index]['product_name']}",
                      style: !widget.order.orders![index]['excluded']
                          ? const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )
                          : const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          "R\$ ${widget.order.orders![index]['unitary_value']}",
                          style: !widget.order.orders![index]['excluded']
                              ? const TextStyle(
                                  color: Colors.white,
                                )
                              : const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                        ),
                      ],
                    ),
                    trailing: Chip(
                      backgroundColor: Colors.white,
                      label: Text(
                        "R\$ ${widget.order.orders![index]['total']}",
                        style: !widget.order.orders![index]['excluded']
                            ? styleTextSnackbar
                            : const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
