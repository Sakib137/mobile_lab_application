// Widget extraction

// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_application_1/CRUD/delete_function.dart';
import 'package:flutter_application_1/CRUD/product.dart';
import 'package:flutter_application_1/CRUD/update_product_list_screen.dart';

class listItem extends StatelessWidget {
  const listItem({super.key, required this.product, required this.onRefresh});

  final Product product;
  final Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        product.image ?? "",
        height: 50,
        width: 50,
      ),
      title: Text(
        "Item name: ${product.productName ?? ""}",
        style: const TextStyle(
          color: Color.fromARGB(255, 52, 2, 2),
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Product Code: ${product.productCode ?? ""}",
            style: const TextStyle(
              color: Color.fromARGB(255, 52, 2, 2),
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "Product Quantity: ${product.quantity ?? ""}",
            style: const TextStyle(
              color: Color.fromARGB(255, 52, 2, 2),
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "Price: ${product.unitPrice ?? ""}",
            style: const TextStyle(
              color: Color.fromARGB(255, 52, 2, 2),
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "Total price: ${product.totalPrice}",
            style: const TextStyle(
              color: Color.fromARGB(255, 52, 2, 2),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () {
              DeleteFunction.showDeleteConfirmation(
                context: context,
                id: product.id ?? '',
                productName: product.productName ?? 'Unknown',
                productCode: product.productCode ?? 'Unknown',
                quantity: product.quantity?.toString() ?? 'Unknown',
                price: product.unitPrice?.toString() ?? 'Unknown',
                totalPrice: product.totalPrice?.toString() ?? 'Unknown',
                imageUrl: product.image,
                onDeleteSuccess: onRefresh, // Use the passed refresh function
              );
            },
            icon: const Icon(
              Icons.delete,
              color: Color.fromARGB(255, 77, 18, 14),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                UpdateProductScreen.name,
                arguments: product,
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Color.fromARGB(255, 30, 82, 31),
            ),
          ),
        ],
      ),
    );
  }
}
