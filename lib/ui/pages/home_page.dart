import 'package:bloc_example/bloc/product_bloc/product_event.dart';
import 'package:bloc_example/data/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product_bloc/product_bloc.dart';
import '../../bloc/product_bloc/product_state.dart';
import '../../data/repository/product_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final ProductBloc _productBLoc = ProductBloc();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _productBLoc.add(FetchProductEvent());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => _productBLoc,
        child: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child:
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            if (state is ProductInitialState) {
              return buildLoading();
            } else if (state is ProductLoadingState) {
              return buildLoading();
            } else if (state is ProductLoadedState) {
              return buildProductList(state.products);
            } else if (state is ProductErrorState) {
              return buildErrorUi(state.message);
            } else {
              return Container();
            }
          }),
        ),
      ),
    );
  }
}

Widget buildLoading() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildErrorUi(String message) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        message,
        style: const TextStyle(color: Colors.red),
      ),
    ),
  );
}

Widget buildProductList(List<Product> products) {
  return ListView.builder(
    itemCount: products.length,
    itemBuilder: (ctx, pos) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: ListTile(
            leading: Image.network(
              products[pos].image.toString(),
              fit: BoxFit.cover,
              height: 70.0,
              width: 70.0,
            ),
            title: Text(products[pos].title.toString()),
            subtitle: Text(products[pos].description.toString()),
          ),
          onTap: () {},
        ),
      );
    },
  );
}
