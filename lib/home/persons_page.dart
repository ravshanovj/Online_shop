import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grow_fast_app/model/newProducts.dart';

import '../repository/get_info.dart';
import '../style/style.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PersonsPage extends StatefulWidget {
  const PersonsPage({super.key});

  @override
  State<PersonsPage> createState() => _PersonsPageState();
}

class _PersonsPageState extends State<PersonsPage> {
  NoteModel? lifOfProduct;
  int pageIndex = 1;
  bool isLoading = true;
  late RefreshController refreshController;

  @override
  void initState() {
    getInformationNew();
    refreshController = RefreshController();
    super.initState();
  }

  getInformationNew() async {
    pageIndex = 1;
    isLoading = true;
    setState(() {});
    lifOfProduct = await GetInfoNew.getProductNew(pageIndex);
    print(lifOfProduct);
    isLoading = false;
    setState(() {});
  }

  getPageProduct(RefreshController controller) async {
    NoteModel? newData = await GetInfoNew.getProductNew(++pageIndex);
    if (newData?.products != null && newData!.products!.isNotEmpty) {
      lifOfProduct!.products!.addAll(newData.products!);
      controller.loadComplete();
    } else {
      controller.loadNoData();
    }

    setState(() {});
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF1F4F3),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              onLoading: () async {
                await getPageProduct(refreshController);
              },
              onRefresh: () async {
                await getInformationNew();
                refreshController.refreshCompleted();
              },
              controller: refreshController,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    25.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "All Products",
                        style: Style.textStyleofTitle(size: 20),
                      ),
                    ),
                    ListView.builder(
                        padding: EdgeInsets.only(top: 23),
                        itemCount: lifOfProduct?.products?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Container(
                                width: 315.w,
                                height: 120.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: Style.bgOfproductsContainer),
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.only(bottom: 17),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 100.h,
                                      width: 100.h,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  '${lifOfProduct?.products?[index]?.image}'),
                                              fit: BoxFit.cover)),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${lifOfProduct?.products?[index]?.name}',
                                          style: Style.textStyleofTitle(),
                                        ),
                                        10.verticalSpace,
                                        Text(
                                            '\$ ${lifOfProduct?.products?[index]?.price}',
                                            style: Style.textStyleofPrice()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )))
                  ],
                ),
              ),
            ),
    );
  }
}
