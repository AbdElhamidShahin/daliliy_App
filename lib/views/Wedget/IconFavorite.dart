import 'package:Tourism_app/models/cubit/Bloc.dart';
import 'package:Tourism_app/models/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../models/Item.dart';

class Iconfavorite extends StatelessWidget {
  final Category? category;

  Iconfavorite({
    Key? key,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DalilyCubit, DalilyState>(
      builder: (BuildContext context, state) {
        var cubit = DalilyCubit.get(context);
        bool isFavorite = cubit.isFavorite;
        return InkWell(
          onTap: () {
            if (category != null) {
              Provider.of<ItemProvider>(context, listen: false)
                  .addToFavorites(category!);
              cubit.updateFavoriteState(!isFavorite);
              print(isFavorite);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 32,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}

class IconfavoriteDelate extends StatelessWidget {
  final Category? category;

  IconfavoriteDelate({
    Key? key,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DalilyCubit, DalilyState>(
      builder: (BuildContext context, state) {
        var cubit = DalilyCubit.get(context);
        bool isFavorite = cubit.isFavorite;
        return InkWell(
          onTap: () {
            if (category != null) {
              Provider.of<ItemProvider>(context, listen: false)
                  .removeFromFavorites(category!);
              cubit.updateFavoriteState(!isFavorite);
              print(isFavorite);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.delete,
              size: 32,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
