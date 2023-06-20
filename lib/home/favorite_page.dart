import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grow_fast_app/home/product_detail_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../components/gridview_products.dart';
import '../components/horizontal_products.dart';

import '../model/product_model.dart';
import '../repository/get_info.dart';
import '../store/local.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool isLoading = true;
  List<ProductModel?>? lifOfProduct = [];
  bool isHorizontal = true;

  @override
  void initState() {
    getInformation();
    super.initState();
  }

  getInformation() async {
    isLoading = true;
    setState(() {});
    List<String> localList = await LocalStore.getLikeList();
    for (var element in localList) {
      ProductModel? newDate = await GetInfo.getSingleProduct(element);
      newDate?.like = true;
      lifOfProduct?.add(newDate);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 50,
        backgroundColor: const Color(0xffF1F4F3),
        title: Text(
          "Favorites",
          style: GoogleFonts.raleway(color: Colors.black),
        ),
      ),
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: const Color.fromARGB(255, 113, 111, 111), size: 35))
          : isHorizontal
              ? ListView.builder(
                  padding: const EdgeInsets.only(top: 23),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: lifOfProduct?.length ?? 0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ProductDetail(
                                  product: lifOfProduct?[index],
                                )));
                      },
                      child: HorizontalProduct(
                        product: lifOfProduct?[index],
                        onLikeInLikePage: () {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            lifOfProduct?.removeAt(index);
                            setState(() {});
                          });
                        },
                      ),
                    );
                  },
                )
              : GridView.builder(
                  padding: const EdgeInsets.only(top: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: lifOfProduct?.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 17,
                    maxCrossAxisExtent: 300,
                    mainAxisExtent: 280,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ProductDetail(
                                    product: lifOfProduct?[index],
                                  )));
                        },
                        child: GridProduct(
                          product: lifOfProduct?[index],
                          onLikeInLikePage: () {
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              lifOfProduct?.removeAt(index);
                              setState(() {});
                            });
                          },
                        ),
                      )),
    );
  }
}
