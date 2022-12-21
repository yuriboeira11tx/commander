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
        ListTile(
          leading: const Icon(
            Icons.notes,
            color: colorPrimarySwatch,
          ),
          title: Row(
            children: [
              const Text(
                "TOTAL: ",
                style: TextStyle(
                  color: colorPrimarySwatch,
                ),
              ),
              Text(
                "R\$ ${widget.order.total}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorPrimarySwatch,
                ),
              ),
              const Text(
                " reais",
                style: TextStyle(
                  color: colorPrimarySwatch,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          subtitle: Text(
            "Criada em ${widget.order.createdAt!.day}/${widget.order.createdAt!.month}/${widget.order.createdAt!.year} às ${widget.order.createdAt!.hour}h:${widget.order.createdAt!.minute}m",
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Expanded(
          child: RawScrollbar(
            thumbVisibility: true,
            thumbColor: colorPrimarySwatch,
            radius: const Radius.circular(20),
            thickness: 3,
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
                      color: const Color(0xE4404B60),
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
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        child: Chip(
                          backgroundColor: Colors.white,
                          label: Text(
                            "${widget.order.orders![index]['quantity']}x",
                            style: !widget.order.orders![index]['excluded']
                                ? const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: colorPrimarySwatch,
                                  )
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
                              ? const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: colorPrimarySwatch,
                                )
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
        ),
      ],
    );
  }
}
