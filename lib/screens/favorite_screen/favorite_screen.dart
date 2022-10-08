import 'package:flutter/material.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:on_the_bon/global_widgets/icon_gif.dart';
import 'package:on_the_bon/global_widgets/navigation_bar.dart';
import 'package:on_the_bon/screens/favorite_screen/fav_graid.dart';
import 'package:provider/provider.dart';

class FaivoriteScreen extends StatefulWidget {
  const FaivoriteScreen({super.key});
  static String routeName = '/fav';

  @override
  State<FaivoriteScreen> createState() => _FaivoriteScreenState();
}

class _FaivoriteScreenState extends State<FaivoriteScreen> {
  bool isLoading = true;

  @override
  void initState() {
    Provider.of<Products>(context, listen: false)
        .getUserFavoriteAsync()
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "منتجاتي المفضلة",
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        bottomNavigationBar: ButtomNavigationBar(
          routeName: FaivoriteScreen.routeName,
        ),
        body: isLoading
            ? const Center(
                child: IconGif(
                width: 90,
                content: "",
                iconPath: "assets/images/search.gif",
              ))
            : productData.getFavProducts.isNotEmpty &&
                    productData.allProducts.isNotEmpty
                ? const SingleChildScrollView(child: ProductGraid())
                : RefreshIndicator(
                    onRefresh: () async {},
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .5,
                        child: const Center(
                          child: Text(
                            " 😉 المفضله فارغه ضيف منتج وتعالا  ",
                            style: TextStyle(fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
