import 'package:flutter/material.dart';
import 'package:flutter_application_1/CRUD/add_product_list_screen.dart';
import 'package:flutter_application_1/CRUD/product.dart';
import 'package:flutter_application_1/CRUD/product_list_screen.dart';
import 'package:flutter_application_1/CRUD/update_product_list_screen.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if (settings.name == "/") {
          widget = const ProductListScreen();
        } else if (settings.name == AddNewProductScreen.name) {
          widget = const AddNewProductScreen();
        } else if (settings.name == UpdateProductScreen.name) {
          final Product product = settings.arguments as Product;
          widget = UpdateProductScreen(
            product: product,
          );
        }
        return MaterialPageRoute(builder: (context) {
          return widget;
        });
      },
    );
  }
}
