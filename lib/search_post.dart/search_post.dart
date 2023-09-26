import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/cubit/homenav_cubit.dart';
import 'package:vildi1/search_post.dart/enter_product.dart';

class SearchRow extends StatelessWidget {
  const SearchRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchRow();
  }
}

Widget searchRow(BuildContext context) {
  return Row(
    mainAxisAlignment:
        MainAxisAlignment.spaceEvenly, // Centers the TextField and Button
    children: <Widget>[
      const Expanded(
        child: TextField(
          cursorColor: Colors.white,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 4,
              ),
            ),
            hintText: 'Search for Farm Equipment!',
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
      BlocBuilder<HomeNavCubit, HomeNavState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              context.read<HomeNavCubit>().changeTab(tab: 1);
              // Put your logic here
            },
            child: const Text('Button'),
          );
        },
      ),
    ],
  );
}
