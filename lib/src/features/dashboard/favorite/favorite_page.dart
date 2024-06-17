import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:entrance_test/src/constants/color.dart';
import 'package:entrance_test/src/constants/icon.dart';
import 'package:entrance_test/src/features/dashboard/products/list/component/product_list_controller.dart';
import 'package:entrance_test/src/widgets/empty_list_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritePage extends GetWidget<ProductListController> {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: white,
          body: Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                return Future.delayed(const Duration(seconds: 0), () {
                  controller.getProducts();
                });
              },
              child: Obx(() {
                return (controller.listFavorite.isEmpty)
                    ? Center(
                        child: EmptyListStateWidget(
                          iconSource: ic_empty_data,
                          text: "No item favorite to show",
                        ),
                      )
                    : buildProductList(context);
              }),
            ),
          ),
        ),
      );

  Widget buildProductList(BuildContext context) => DynamicHeightGridView(
      physics: const AlwaysScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      itemCount: controller.listFavorite.length,
      builder: (context, index) {
        final favoriteItem = controller.listFavorite[index];
        return Container(
          margin: EdgeInsets.only(
              left: index % 2 == 0 ? 24 : 0,
              right: index % 2 == 0 ? 0 : 24,
              bottom: index == controller.products.length - 1 ? 16 : 0),
          decoration: ShapeDecoration(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            shadows: const [
              BoxShadow(
                color: shadowColor,
                blurRadius: 20,
                offset: Offset(0, 10),
                spreadRadius: 0,
              )
            ],
          ),
          child: InkWell(
            onTap: () => {
              controller.toProductDetail(favoriteItem.idDetail),
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.asset(
                          ic_error_image,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () =>
                                  {controller.removeFavorite(favoriteItem.id)},
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Image.asset(
                                  ic_favorite_filled,
                                  width: 24,
                                  height: 24,
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          favoriteItem.name,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: gray900,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          favoriteItem.price.toString(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 12,
                            color: gray900,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
