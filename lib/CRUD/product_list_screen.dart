import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/CRUD/add_product_list_screen.dart';
import 'package:flutter_application_1/CRUD/product.dart';
import 'package:flutter_application_1/CRUD/product_item.dart';
import 'package:http/http.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList = [];
  bool _getProductListInProgress = false;

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        backgroundColor: const Color.fromARGB(255, 1, 35, 66),
        title: const Center(
          child: Text(
            "Product List",
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _getProductList();
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 141, 163, 171),
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 1, 35, 66),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/sakib.jpg'),
                    ),
                    Text(
                      'Md Sakib Al Hasan',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      'mdsakib124202@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text(
                "Home",
                style: TextStyle(
                  color: Color.fromARGB(255, 7, 1, 56),
                ),
              ),
              leading: const Icon(
                Icons.home,
                color: Color.fromARGB(255, 43, 25, 0),
              ),
              onTap: () {
                Navigator.push(
                  (context),
                  MaterialPageRoute(
                    builder: (context) => const ProductListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                "Add New Product",
                style: TextStyle(
                  color: Color.fromARGB(255, 7, 1, 56),
                ),
              ),
              leading: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 43, 25, 0),
              ),
              onTap: () {
                Navigator.push(
                  (context),
                  MaterialPageRoute(
                    builder: (context) => const AddNewProductScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                "Settings",
                style: TextStyle(
                  color: Color.fromARGB(255, 7, 1, 56),
                ),
              ),
              leading: const Icon(
                Icons.settings,
                color: Color.fromARGB(255, 43, 25, 0),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 193, 191, 178),
              Color.fromARGB(255, 113, 116, 152), // Dark blue at the top
              Color.fromARGB(255, 23, 42, 59), // Lighter blue at the bottom
            ],
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            _getProductList();
          },
          child: Visibility(
            visible: _getProductListInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return listItem(
                    product: productList[index],
                    onRefresh: () {},
                  );
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewProductScreen.name);
        },
        backgroundColor: const Color.fromARGB(255, 1, 35, 66),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<void> _getProductList() async {
    productList.clear();
    _getProductListInProgress = true;
    setState(() {});
    Uri uri = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
    Response response = await get(uri);

    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);

      for (Map<String, dynamic> p in decodeData["data"]) {
        Product product = Product(
          id: p["_id"],
          productName: p["ProductName"],
          productCode: p["ProductCode"],
          image: p["Img"],
          quantity: p["Qty"],
          unitPrice: p["UnitPrice"],
          totalPrice: p["TotalPrice"],
          createdDate: p["CreatedDate"],
        );
        productList.add(product);
      }

      setState(() {});
    }
    _getProductListInProgress = false;
    setState(() {});
  }
}
