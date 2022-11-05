import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/Product_card/product_card.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:provider/provider.dart';

class ProductGraid extends StatelessWidget {
  const ProductGraid({Key? key}) : super(key: key);




  // @override
  // void initState() {
  //   // gridController.addListener(() {
  //   //   double value = gridController.offset / 310;

  //   //   setState(() {
  //   //     topContainer = value;
  //   //   });
  //   // });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
  final ScrollController gridController = ScrollController();
    return Consumer<Products>(
      builder: (context, value, c) {
        final productList = value.getFavProducts;

        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                controller: gridController,
                // shrinkWrap: true,
                // primary: false,
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  print("rebuiilid");
                  // double scale = 1;
                  // double opacity = 1;

                  // if (topContainer > .5) {
                  //   scale = index + 1.35 - topContainer;
                  //   opacity = index + 1.35 - topContainer;

                  //   if (scale < 0) {
                  //     scale = 0;
                  //     opacity = 0;
                  //   } else if (scale > 1) {
                  //     scale = 1;
                  //     opacity = 1;
                  //   }
                  // }
                  return AnimatedBuilder(
                      animation: gridController,
                      builder: (BuildContext context, Widget? child) {
                        final RenderBox? renderObj =
                            context.findRenderObject() as RenderBox?;
                        final offsetY =
                            renderObj?.localToGlobal(Offset.zero).dy ?? 0;
                        final deviceHight = MediaQuery.of(context).size.height;
                        if (offsetY <= 0) {
                          return child as Widget;
                        }

                        final hightVisible = deviceHight - offsetY;
                        final wedgitHeight =
                            renderObj!.hasSize ? renderObj.size.height : 302;
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
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: index == productList.length - 1 ? 150 : 0),
                        child: ChangeNotifierProvider.value(
                          value: productList[index],
                          child: ProductCard(
                            productList[index],
                          ),
                        ),
                      ));
                  // return Container();
                },

                itemCount: productList.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
