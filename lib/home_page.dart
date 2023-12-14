import 'package:flutter/material.dart';
import 'package:shopping_app/card_page.dart';
import 'package:shopping_app/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  List<Widget> pages = const [ProductList(), CardListPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        //this is used when the user is scoll and then click on cardpage the
        //listView element is showed on same list were the user left
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (value) {
            setState(() {
              currentPage = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: ''),
          ]),
    );
  }
}
