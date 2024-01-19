import 'package:cached_network_image/cached_network_image.dart';
import 'package:driver_panda_app/model/item_model.dart';
import 'package:driver_panda_app/view/item_detail_screen/item_detail_screen.dart';
import 'package:flutter/material.dart';

class ItemsInfoWidget extends StatelessWidget {
  final ItemModel? model;
  final BuildContext? context;
  const ItemsInfoWidget({Key? key, this.model, this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ItemDetailScreen(
                  itemModel: model,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                progressIndicatorBuilder: (context, value, download) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.amber,
                      value: download.progress,
                    ),
                  );
                },
                imageUrl: model!.thumbnailUrl!,
                height: 220.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              model!.itemTitle!,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.cyan,
                    fontFamily: "TrainOne",
                  ),
            ),
            Text(
              model!.itemInfo!,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.cyan, fontFamily: "TrainOne"),
            ),
          ],
        ),
      ),
    );
  }
}
