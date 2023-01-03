import 'package:flutter/material.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:on_the_bon/global_widgets/icon_gif.dart';
import 'package:on_the_bon/global_widgets/main_drawer.dart';
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
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return SafeArea(
      child: Scaffold(
          drawer: MainDrawer(),
          extendBody: true,
          bottomNavigationBar: ButtomNavigationBar(
            routeName: FaivoriteScreen.routeName,
          ),
          body: Stack(
            children: [
              isLoading
                  ? const Center(
                      child: IconGif(
                      width: 90,
                      content: "",
                      iconPath: "assets/images/search.gif",
                    ))
                  : productData.getFavProducts.isNotEmpty &&
                          productData.allProducts.isNotEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Stack(
                            children: [
                              Positioned(
                                  top: 35,
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: const ProductGraid())),
                            ],
                          ),
                        )
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
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  color: Theme.of(context).primaryColor,
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    "❤️ مفضلتي",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
