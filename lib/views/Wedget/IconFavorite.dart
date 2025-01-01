import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/Item.dart';

class Iconfavorite extends StatefulWidget {
  final Category? category;
  final bool isFavorite;

  Iconfavorite({
    Key? key,
    this.category,
    required this.isFavorite,
  }) : super(key: key);

  @override
  State<Iconfavorite> createState() => _IconfavoriteState();
}

class _IconfavoriteState extends State<Iconfavorite> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.category != null) {
          Provider.of<ItemProvider>(context, listen: false).addToFavorites(widget.category!);
          setState(() {
            isFavorite = !isFavorite;
          });

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
  }
}

