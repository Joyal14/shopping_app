import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetails({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedSize = 0;

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
            widget.product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Image.asset(
              widget.product['imageUrl'] as String,
              fit: BoxFit.fill,
            ),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$${widget.product['price']}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product['sizes'] as List<int>).length,
                    itemBuilder: (context, index) {
                      final size =
                          (widget.product['sizes'] as List<int>)[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          child: Chip(
                            label: Text(
                              size.toString(),
                            ),
                            backgroundColor: selectedSize == size
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  // child: ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //       backgroundColor: Theme.of(context).colorScheme.primary,
                  //       minimumSize: const Size(double.infinity, 50)),
                  //   onPressed: () {},
                  //   child: const Text(
                  //     'Add to Cart',
                  //     style: TextStyle(
                  //         color: Color.fromRGBO(0, 0, 0, 1), fontSize: 18),
                  //   ),
                  // ),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                    label: Title(
                      color: Colors.black,
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1), fontSize: 18),
                      ),
                    ),
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
