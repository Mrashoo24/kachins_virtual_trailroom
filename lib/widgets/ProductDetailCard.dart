import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kachins/Services/Services.dart';
import 'package:kachins/pages/placement_guide_video.dart';

import '../Models/GetClass.dart';
import '../constants/constants.dart';

class ProductDetailCard extends StatefulWidget {
 final DataController dataController;
 final CarouselController controller;
  final List<ProductDetailModel>? ProductImages;
  final String ProductName, ProductNumber, ProductDescription;
  final int ProductCount;
  const ProductDetailCard(
      {Key? key,
      required this.ProductImages,
      required this.ProductName,
      required this.ProductNumber,
      required this.ProductDescription,
      required this.ProductCount, required this.dataController, required this.controller})
      : super(key: key);

  @override
  State<ProductDetailCard> createState() => _ProductDetailCardState();
}

class _ProductDetailCardState extends State<ProductDetailCard> {
  @override
  Widget build(BuildContext context) {


    var size = MediaQuery.of(context).size;


    final List<Widget> imageSliders = widget.ProductImages!
        .map((item) => Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: size.height * 0.31,
                width: size.width,
                child: Container(
                  width: size.width - size.width * .12,
                  padding: EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(21),
                    child: Image.network(
                      imgurl + item.image!,
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
                )
            ),
            // Text(
            //   widget.ProductImages![index1].title!,
            //   textAlign: TextAlign.center,
            //   style: GoogleFonts.dmSans(
            //     textStyle: TextStyle(
            //         color: descriptionColor,
            //         fontSize: 15,
            //         fontWeight: FontWeight.w400),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            Text(
              item.title!,
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    color: headingColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: widget.ProductCount == 1
                  ? size.height * .2
                  : size.height * .12,
              width: size.width - 100,
              child: SingleChildScrollView(
                child: Text(
                  item.description!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: descriptionColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: size.height * .025),
              padding: EdgeInsets.only(left: 25, right: 25),
              decoration: BoxDecoration(
                color: ButtonColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                onPressed: () {

                  // var selectedPod =  widget.dataController.map.firstWhere((element) => element['prodid'] == widget.ProductName );

                  widget.dataController.selectedProd == null ?
                  widget.dataController.selectedProd = widget.dataController.qrModel!.processData![0]
                      : print('')
                  ;
                  widget.dataController.update();
                  widget.dataController.currentpose = widget.dataController.selectedProd!.poses![0];
                  widget.dataController.update();

                  Navigator.pushReplacement(
                      (context),
                      MaterialPageRoute(
                          builder: (context) => PlacementGuideVideoScreen()));
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    ))
        .toList();

    return ClipRRect(
      borderRadius: BorderRadius.circular(21),
      child: Container(
        height:
            widget.ProductCount == 1 ? size.height * .74 : size.height * .67,
        width: size.width,
        color: cardColor,
        child:
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(enlargeCenterPage: true, height: MediaQuery.of(context).size.height * 0.8),
          carouselController: widget.controller,
        ),
        // ListView.builder(
        //   itemCount: widget.ProductImages!.length,
        //     scrollDirection: Axis.horizontal,
        //
        //     itemBuilder: (context,index1) {
        //
        //       print('imageCheck = ${widget.ProductImages![index1].image!}');
        //     return Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Container(
        //           height: size.height * 0.31,
        //           width: size.width,
        //           child: Container(
        //             width: size.width - size.width * .12,
        //             padding: EdgeInsets.all(20),
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(21),
        //               child: Image.network(
        //                imgurl + widget.ProductImages![index1].image!,
        //                 fit: BoxFit.cover,
        //               ),
        //             ),
        //           )
        //         ),
        //         // Text(
        //         //   widget.ProductImages![index1].title!,
        //         //   textAlign: TextAlign.center,
        //         //   style: GoogleFonts.dmSans(
        //         //     textStyle: TextStyle(
        //         //         color: descriptionColor,
        //         //         fontSize: 15,
        //         //         fontWeight: FontWeight.w400),
        //         //   ),
        //         // ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         Text(
        //           widget.ProductImages![index1].title!,
        //           textAlign: TextAlign.center,
        //           style: GoogleFonts.dmSans(
        //             textStyle: TextStyle(
        //                 color: headingColor,
        //                 fontSize: 25,
        //                 fontWeight: FontWeight.w500),
        //           ),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         Container(
        //           height: widget.ProductCount == 1
        //               ? size.height * .2
        //               : size.height * .12,
        //           width: size.width - 100,
        //           child: SingleChildScrollView(
        //             child: Text(
        //               widget.ProductImages![index1].description!,
        //               textAlign: TextAlign.center,
        //               style: GoogleFonts.dmSans(
        //                 textStyle: TextStyle(
        //                     color: descriptionColor,
        //                     fontSize: 16,
        //                     fontWeight: FontWeight.w400),
        //               ),
        //             ),
        //           ),
        //         ),
        //         Spacer(),
        //         Container(
        //           margin: EdgeInsets.only(bottom: size.height * .025),
        //           padding: EdgeInsets.only(left: 25, right: 25),
        //           decoration: BoxDecoration(
        //             color: ButtonColor,
        //             borderRadius: BorderRadius.circular(30),
        //           ),
        //           child: TextButton(
        //             onPressed: () {
        //
        //             // var selectedPod =  widget.dataController.map.firstWhere((element) => element['prodid'] == widget.ProductName );
        //
        //               widget.dataController.selectedProd == null ?
        //               widget.dataController.selectedProd = widget.dataController.qrModel!.processData![0]
        //               : print('')
        //               ;
        //               widget.dataController.update();
        //             widget.dataController.currentpose = widget.dataController.selectedProd!.poses![0];
        //             widget.dataController.update();
        //
        //               Navigator.pushReplacement(
        //                   (context),
        //                   MaterialPageRoute(
        //                       builder: (context) => PlacementGuideVideoScreen()));
        //             },
        //             child: Text(
        //               "Next",
        //               style: TextStyle(
        //                   fontWeight: FontWeight.bold, color: Colors.white),
        //             ),
        //           ),
        //         )
        //       ],
        //     );
        //   }
        // ),
      ),
    );
  }
}
