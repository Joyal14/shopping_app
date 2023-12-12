import 'package:flutter/material.dart';
import 'package:shopping_app/gobal_variable.dart';
import 'package:shopping_app/product_card.dart';
import 'package:shopping_app/product_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<String> filters;
  late String selectedFilter;
  List<Map<String, dynamic>> filteredProducts = [];
  late List<Map<String, dynamic>> originalProducts;

  @override
  void initState() {
    super.initState();
    List<String> uniqueCompanies = products
        .map((product) => product['company'] as String)
        .toSet()
        .toList();
    filters = ['All', ...uniqueCompanies];
    selectedFilter = filters[0];
    filteredProducts = List.from(products);
    originalProducts = List.from(products);
  }
  // This logic for the filter listView
  // void filterProducts(String query) {
  //   setState(() {
  //     filteredProducts = originalProducts.where((product) {
  //       final companyMatches = selectedFilter == 'All' ||
  //           product['company'].toLowerCase() == selectedFilter.toLowerCase();
  //       final titleMatches = (product['title'] as String)
  //           .toLowerCase()
  //           .contains(query.toLowerCase());
  //       return companyMatches && titleMatches;
  //     }).toList();
  //   });
  // }

  void filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        // No search query, apply only the selected filter
        if (selectedFilter == 'All') {
          filteredProducts = List.from(originalProducts);
        } else {
          filteredProducts = originalProducts
              .where((product) => product['company'] == selectedFilter)
              .toList();
        }
      } else {
        // Apply both filter and search query
        filteredProducts = originalProducts
            .where((product) =>
                (product['title'] as String)
                    .toLowerCase()
                    .contains(query.toLowerCase()) &&
                (selectedFilter == 'All' ||
                    product['company'].toLowerCase() ==
                        selectedFilter.toLowerCase()))
            .toList();
      }
    });
  }

  List<Map<String, Object>> convertDynamicList(
      List<Map<String, dynamic>> dynamicList) {
    return dynamicList.map((dynamicMap) {
      Map<String, Object> objectMap = {};
      dynamicMap.forEach((key, value) {
        objectMap[key] = value;
      });
      return objectMap;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );

    List<Map<String, Object>> filteredObjectProducts =
        convertDynamicList(filteredProducts);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Shoes\nCollection',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Expanded(
                  child: TextField(
                    onChanged: (String query) {
                      filterProducts(query);
                    },
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter;
                          filterProducts('');
                        });
                      },
                      child: Chip(
                        backgroundColor: selectedFilter == filter
                            ? Theme.of(context).colorScheme.primary
                            : const Color.fromARGB(255, 238, 242, 245),
                        side: const BorderSide(
                          color: Color.fromRGBO(245, 247, 249, 1),
                        ),
                        label: Text(filter),
                        labelStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredObjectProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredObjectProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return ProductDetails(product: product);
                        }),
                      );
                    },
                    child: ProductCard(
                      title: product['title'] as String,
                      price: product['price'] as double,
                      images: product['imageUrl'] as String,
                      backgroundcolor: index.isEven
                          ? const Color.fromRGBO(188, 237, 241, 1)
                          : const Color.fromARGB(255, 221, 224, 224),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
