import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/Item/Item.dart';
import '../../models/Item/ItemProvider.dart';

class BuildFavoriteIcon extends StatefulWidget {
  final Category category;
  final VoidCallback onPressed;

  BuildFavoriteIcon({Key? key, required this.category, required this.onPressed})
      : super(key: key);

  @override
  State<BuildFavoriteIcon> createState() => _BuildFavoriteIconState();
}

class _BuildFavoriteIconState extends State<BuildFavoriteIcon> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = Provider.of<ItemProvider>(context, listen: false)
        .favorites
        .contains(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Material(
        color: Colors.white.withOpacity(0.0),
        borderRadius: BorderRadius.circular(100),
        elevation: 1,
        child: InkWell(
          child: IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });

              if (widget.onPressed != null) {
                widget.onPressed!();
              } else {
                Provider.of<ItemProvider>(context, listen: false)
                    .removeFromFavorites(widget.category);
              }
            },
            icon: Container(
                width: 42,
                height: 42,
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 28,
                )),
          ),
        ),
      ),
    );
  }
}
