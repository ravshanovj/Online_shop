import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grow_fast_app/style/style.dart';
import 'package:readmore/readmore.dart';

import '../components/image_network.dart';
import '../model/product_model.dart';

class ProductDetail extends StatefulWidget {
  final ProductModel? product;

  ProductDetail({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isLike = true;
  int amount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bgDetailProduct,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.9,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Style.white,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 100.0)),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: (() {
                              Navigator.pop(context);
                            }),
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Color(0xff777777),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: IconButton(
                              onPressed: (() {}),
                              icon: Icon(
                                Icons.shopping_cart_checkout_outlined,
                                color: Color(0xff777777),
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomImageNetwork(
                        width: 260,
                        height: 260,
                        image: widget.product?.image,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () {
                                isLike = !isLike;
                                setState(() {});
                              },
                              child: Container(
                                height: 50.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isLike
                                        ? Color(0x50777777)
                                        : Colors.red),
                                child: Icon(
                                  Icons.favorite,
                                  color: isLike ? Colors.red : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              15.verticalSpace,
              Padding(
                padding: const EdgeInsets.only(left: 29),
                child: Text(
                  widget.product?.title ?? "",
                  style: Style.textStyleofTitle(size: 24),
                ),
              ),
              25.verticalSpace,
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 29),
                    child: Container(
                      width: 70.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          border: Border.all(color: Color(0xffE4E2E2))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                                widget.product?.rating?.rate.toString() ?? '',
                                style: Style.textStyleofPrice(size: 12)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      width: 140.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          border: Border.all(color: Color(0xffE4E2E2))),
                      child: Center(
                        child: Text(widget.product?.category ?? '',
                            style: Style.textStyleofPrice(size: 12)),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$',
                    style: Style.textStyleofPrice(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Text(
                      widget.product?.price.toString() ?? '',
                      style: Style.textStyleofPrice(),
                    ),
                  )
                ],
              ),
              25.verticalSpace,
              Padding(
                padding: const EdgeInsets.only(left: 29),
                child: Text(
                  'Description',
                  style: Style.textStyleofTitle(size: 20),
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: const EdgeInsets.only(left: 29, right: 48),
                child: ReadMoreText(
                  trimCollapsedText: ' show more',
                  trimExpandedText: ' show less',
                  trimMode: TrimMode.Line,
                  trimLines: 4,
                  widget.product?.description ?? '',
                  style: Style.textStyleofTitle(size: 12),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Style.white),
                      child: Center(
                          child: Text(
                        '-',
                        style: Style.textStyleofPrice(size: 22),
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '$amount',
                      style: Style.textStyleofPrice(size: 20),
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Style.white),
                    child: Center(
                        child: Text(
                      '+',
                      style: Style.textStyleofPrice(size: 30),
                    )),
                  ),
                  Spacer(),
                  Container(
                    height: 82.h,
                    width: 196.w,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [Color(0xff26AD71), Color(0xff32CB4B)]),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28),
                        )),
                    child: Center(
                        child: Text(
                      'Add to bag',
                      style: TextStyle(
                          color: Style.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
