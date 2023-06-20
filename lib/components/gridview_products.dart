import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grow_fast_app/style/style.dart';

import '../model/product_model.dart';
import '../store/local.dart';
import 'image_network.dart';

class GridProduct extends StatefulWidget {
  final ProductModel? product;
  final VoidCallback onLikeInLikePage;

  GridProduct(
      {super.key, required this.product, required this.onLikeInLikePage});

  @override
  State<GridProduct> createState() => _GridProductState();
}

class _GridProductState extends State<GridProduct> {
  bool isLike = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 245.h,
      width: 149.w,
      decoration: BoxDecoration(
          color: Style.bgOfproductsContainer,
          borderRadius: BorderRadius.all(Radius.circular(28))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          17.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(left: 150),
            child: GestureDetector(
              onTap: () {
                if (widget.product?.like ?? false) {
                  widget.product?.like = !(widget.product?.like ?? false);
                  LocalStore.removeLikeList(widget.product?.id ?? 0);
                  widget.onLikeInLikePage();
                  setState(() {});
                } else {
                  widget.product?.like = !(widget.product?.like ?? false);
                  LocalStore.setLikeList(widget.product?.id ?? 0);
                  setState(() {});
                }
              },
              child: Container(
                height: 21.h,
                width: 21.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (widget.product?.like ?? false)
                        ? Colors.red
                        : Colors.white),
                child: Icon(
                  Icons.favorite,
                  color: (widget.product?.like ?? false)
                      ? Colors.white
                      : Colors.red,
                  size: 12,
                ),
              ),
            ),
          ),
          10.verticalSpace,
          CustomImageNetwork(
            width: 160,
            image: widget.product?.image,
          ),
          8.verticalSpace,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 17),
              child: Text(
                widget.product?.title ?? "",
                style: Style.textStyleofTitle(size: 14),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 17),
                child: Text(
                  ('\$ ${widget.product?.price ?? 0}').toString(),
                  style: Style.textStyleofPrice(size: 18),
                ),
              ),
              Spacer(),
              Container(
                width: 53.w,
                height: 41.h,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Color(0xff26AD71), Color(0xff32CB4B)]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
