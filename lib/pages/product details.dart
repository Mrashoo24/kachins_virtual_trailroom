import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// import '../Models/NewClass.dart';
import '../Services/Services.dart';
import '../Models/GetClass.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../widgets/ProductDetailCard.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  var positionindex = 0;
  List tempList = [
    "assets/images/Group 22.png",
    "assets/images/Group 22.png",
    "assets/images/Group 22.png"
  ];
  final CarouselController _controller = CarouselController();

  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {





    return Scaffold(
      body: Center(
        child: GetBuilder<DataController>(
          init:  Get.put(DataController()),
          builder: (dataController) {
            // print("Product Count : ${snapshot.data?.length}");

              var size = MediaQuery.of(context).size;

              List<ProductDetailModel>?    productList = dataController.qrModel?.productDetail!;
              // List<ProductDetailModel>?    prodDetail = dataController.qrModel?.productDetail;



              // print("Product Count : ${snapshot.data!.length}");
              // print("${snapshot.data}");
              // print("Product Count : ${snapshot.data![0][0]}");
              return Scaffold(
                body: Container(
                  width: size.width,
                  height: size.height,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                          top: size.height * .09,
                          left: size.width * .06,
                        ),
                        height: size.height * .43,
                        color: kPrimaryColor,
                        child: Container(
                          alignment: Alignment.center,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 22,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: Container(
                          padding: EdgeInsets.only(
                            top: size.height * .095,
                          ),
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              Text(
                                "Product Details",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.025,
                              ),
                              Container(
                                child: Text(
                                  "Confirm yourselves by finishing \none of either options",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: size.height * .19,
                            left: size.width * .06,
                            right: size.width * .06),
                        child: SingleChildScrollView(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //  Top Button Start
                              productList!.isNotEmpty
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          top: size.height * 0.02),
                                      height: 50,
                                      width:productList.length <= 3
                                          ? productList.length * 60
                                          : 3 * 65,
                                      child:

                                      ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              //
                                              // dataController.selectedProd = productList[index];
                                              // dataController.update();
                                              _controller.animateToPage(index);

                                              setState(() {
                                                positionindex = index;
                                              });
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              margin: EdgeInsets.only(
                                                  right: 5, left: 5),
                                              decoration: BoxDecoration(
                                                  // color: Colors.black,
                                                  border: Border.all(
                                                      color: positionindex ==
                                                              index
                                                          ? Colors.white
                                                          : Colors.transparent,
                                                      width: 3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                child: Image.network(
                                                  //Change the image here
                                                imgurl +  productList[index].image!,
                                                  // snapshot.data![index][3][0],
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                  loadingBuilder: (BuildContext context, Widget child,
                                                      ImageChunkEvent? loadingProgress) {
                                                    if (loadingProgress == null) return child;
                                                    return Center(
                                                      child: CircularProgressIndicator(
                                                        value: loadingProgress.expectedTotalBytes != null
                                                            ? loadingProgress.cumulativeBytesLoaded /
                                                            loadingProgress.expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: productList.length,
                                      ),
                                    )
                                  : SizedBox.shrink(),

                              SizedBox(
                                height: size.height * 0.025,
                              ),
                              //  Top botton End

                               // Card Start
                              ProductDetailCard(
                                controller: _controller,
                                ProductName: productList[positionindex].title!,
                                ProductNumber:  productList[positionindex].title.toString(),
                                ProductDescription: '',
                                ProductImages: dataController.qrModel?.productDetail,
                                ProductCount: productList.length, dataController: dataController,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );

          },
        ),
      ),
    );
  }
}
