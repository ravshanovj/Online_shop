import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grow_fast_app/home/product_detail_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../components/gridview_products.dart';
import '../components/horizontal_products.dart';

import '../model/product_model.dart';
import '../repository/get_info.dart';
import '../style/style.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductModel?>? lifOfProduct = [];
  List<dynamic>? lifOfCategory = [];
  bool isLoading = true;
  bool isHorizontal = true;
  bool isLoadingCateg = false;

  int selected = -1;

  @override
  void initState() {
    getInformation();
    super.initState();
  }

  getInformation() async {
    isLoading = true;
    setState(() {});

    lifOfCategory = await GetInfo.getCategory();
    await getAllProducts();
    await getLikes();
    isLoading = false;
    setState(() {});
  }

  getAllProducts() async {
    isLoading = true;
    setState(() {});
    lifOfProduct = await GetInfo.getProduct();
    isLoading = false;
    setState(() {});
  }

  getCategory(String categ) async {
    isLoadingCateg = true;
    setState(() {});
    lifOfProduct = await GetInfo.getCategoryONlyOne(oneItem: categ);

    isLoadingCateg = false;
    setState(() {});
  }

  getLikes() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 50,
        backgroundColor: const Color(0xffF1F4F3),
        title: Text(
          "Products",
          style: GoogleFonts.raleway(color: Colors.black),
        ),
      ),
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: const Color.fromARGB(255, 113, 111, 111), size: 35))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 24),
                        shrinkWrap: true,
                        itemCount: lifOfCategory?.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              if (selected == index) {
                                selected = -1;
                                await getAllProducts();

                                setState(() {});
                              } else {
                                selected = index;
                                getCategory(lifOfCategory?[index]);
                                setState(() {});
                              }
                            },
                            child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: selected == index
                                            ? const Color(0xff2AAF7F)
                                            : Colors.transparent),
                                    borderRadius: BorderRadius.circular(16),
                                    color: Style.bgCategory),
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                    child: Text(lifOfCategory?[index] ?? ''))),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selected != -1
                              ? lifOfCategory![selected] ?? ''
                              : "All Products",
                          style: Style.textStyleofTitle(size: 20),
                        ),
                        IconButton(
                            onPressed: () {
                              isHorizontal = !isHorizontal;
                              setState(() {});
                            },
                            icon: Icon(
                              isHorizontal
                                  ? Icons.grid_view_outlined
                                  : Icons.list,
                              color: const Color(0xff194B38),
                            ))
                      ],
                    ),
                  ),
                  isLoadingCateg
                      ? Shimmer(
                          interval: const Duration(seconds: 3),
                          color: const Color.fromARGB(255, 113, 111, 111),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: lifOfProduct?.length ?? 0,
                              itemBuilder: ((context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Container(
                                    width: 320.w,
                                    height: 120.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: Style.bgOfproductsContainer),
                                    padding: const EdgeInsets.all(16),
                                    margin: const EdgeInsets.only(bottom: 17),
                                  )))))
                      : isHorizontal
                          ? ListView.builder(
                              padding: const EdgeInsets.only(top: 23),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: lifOfProduct?.length ?? 0,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (!isLoadingCateg) {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (_) => ProductDetail(
                                                    product:
                                                        lifOfProduct?[index],
                                                  )));
                                    }
                                  },
                                  child: HorizontalProduct(
                                    product: lifOfProduct?[index], onLikeInLikePage: () {  },
                                  ),
                                );
                              },
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.only(top: 20),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: lifOfProduct?.length ?? 0,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                mainAxisSpacing: 18,
                                crossAxisSpacing: 17,
                                maxCrossAxisExtent: 300,
                                mainAxisExtent: 280,
                              ),
                              itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (_) => ProductDetail(
                                                      product:
                                                          lifOfProduct?[index],
                                                    )));
                                      
                                    },
                                    child: GridProduct(
                                      product: lifOfProduct?[index], onLikeInLikePage: () {  },
                                    ),
                                  )),
                ],
              ),
            ),
    );
  }
}
