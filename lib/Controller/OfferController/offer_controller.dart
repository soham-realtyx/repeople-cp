import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/images.dart';

class OfferController extends GetxController{

  RxInt current=0.obs;
  CarouselController controllerOffers = CarouselController();
  RxList<String> offerList = RxList([
    offerPngImage,
    offerPngImage,
    offerPngImage,
    offerPngImage,
  ]);

}