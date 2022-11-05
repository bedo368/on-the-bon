import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/Product_card/product_card.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:provider/provider.dart';

class ProductGraid extends StatelessWidget {
  const ProductGraid({Key? key, required this.onScroll}) : super(key: key);
  final Function(double) onScroll;

  @override
  Widget build(BuildContext context) {
    final gridController = ScrollController();

    gridController.addListener(() {
      onScroll(gridController.offset);
    });
    return Consumer<Products>(
      builder: (context, value, c) {
        final productList = value.getProductWithType;

        return AnimatedSwitcher(
            transitionBuilder: (child, animation) => SlideTransition(
                position: animation.drive(Tween<Offset>(
                    begin: const Offset(-1, 0), end: const Offset(0, 0))),
                child: child),
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeIn,
            child: Container(
              // constraints: BoxConstraints(
              //     minHeight: 500,
              //     maxHeight: mediaQuery.size.height),
              key: Key(productList.isNotEmpty ? productList.first.id : ""),
              child: productList.isEmpty
                  ? const Center(
                      child: Text("عذرا المنتجات غير متاحه الان"),
                    )
                  : ListView.builder(
                      controller: gridController,
                      itemBuilder: (context, index) {
                        return AnimatedBuilder(
                          animation: gridController,
                          builder: (BuildContext context, Widget? child) {
                            final RenderBox? renderObj =
                                context.findRenderObject() as RenderBox?;
                            final offsetY =
                                renderObj?.localToGlobal(Offset.zero).dy ?? 0;
                            final deviceHight =
                                MediaQuery.of(context).size.height;
                            if (offsetY <= 0) {
                              return child as Widget;
                            }

                            final hightVisible = deviceHight - offsetY;
                            final wedgitHeight = renderObj!.hasSize
                                ? renderObj.size.height
                                : 302;
                            final howMuchToShow =
                                (hightVisible / wedgitHeight).clamp(0, 1);
                            final scale = .75 + howMuchToShow * .25;
                            final opacity = .25 + howMuchToShow * .75;
                            return Transform.scale(
                              scale: scale,
                              child: Opacity(
                                opacity: opacity,
                                child: child,
                              ),
                            );
                          },
                          child: ChangeNotifierProvider.value(
                            value: productList[index],
                            child: ProductCard(
                              productList[index],
                              key: ValueKey(productList.first.id),
                            ),
                          ),
                        );
                        // return Container();
                      },
                      itemCount: productList.length,
                    ),
            ));
      },
    );
  }
}
