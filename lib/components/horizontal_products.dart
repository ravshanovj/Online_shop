import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/product_model.dart';
import '../store/local.dart';
import '../style/style.dart';
import 'image_network.dart';

class HorizontalProduct extends StatefulWidget {
  final ProductModel? product;
  final VoidCallback onLikeInLikePage;

  HorizontalProduct(
      {Key? key, required this.product, required this.onLikeInLikePage})
      : super(key: key);

  @override
  State<HorizontalProduct> createState() => _HorizontalProductState();
}

class _HorizontalProductState extends State<HorizontalProduct> {
  bool isLike = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Style.bgOfproductsContainer),
        margin: const EdgeInsets.only(bottom: 17),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 24,
              ),
              child: CustomImageNetwork(
                image: widget.product?.image,
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product?.title ?? "",
                  style: Style.textStyleofTitle(),
                ),
                15.verticalSpace,
                Text(
                  ('\$ ${widget.product?.price ?? 0}').toString(),
                  style: Style.textStyleofPrice(),
                ),
              ],
            )),
            SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
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
                      height: 30.h,
                      width: 30.w,
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
                        size: 15,
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      splashRadius: 5,
                      onPressed: (() {}),
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Style.colorOfPrice,
                        size: 35,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
