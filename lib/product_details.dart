import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final Map<String, Object> product;
  const ProductDetails({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Image.asset(product['imageUrl'] as String),
          ),
          const Spacer(
            flex: 3,
          ),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(210, 223, 230, 1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                Text(
                  '\$${product['price']}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (product['sizes'] as List<int>).length,
                    itemBuilder: (context, index) {
                      final size = (product['sizes'] as List<int>)[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Chip(
                          label: Text(
                            size.toString(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Add to Cart',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
