import 'package:get/get.dart';

class ReRaDetailsController extends GetxController{

  RxList<ReRaCertificatesModel> arrReRaDetailsList = RxList([]);

  Future<RxList<ReRaCertificatesModel>> getReRaDetailsData()async{
    arrReRaDetailsList = RxList([]);
    arrReRaDetailsList.add(ReRaCertificatesModel(
      isExpiryCertificates: "1",
      isWrongCompanyInfo: "0",

      reRaDetailsList: [
        ReRaDetailsModel(
          title: "RERA State",
          subTitle: "Maharashtra",

        ),
        ReRaDetailsModel(
            title: "RERA Number",
            subTitle: "A51800035827"
        ),
        ReRaDetailsModel(
            title: "RERA Expiry",
            subTitle: "19 Jun, 2023",
            isExpiryDate: "1"
        )
      ]
    ));
    arrReRaDetailsList.add(ReRaCertificatesModel(
        isExpiryCertificates: "0",
        isWrongCompanyInfo: "0",
        reRaDetailsList: [
          ReRaDetailsModel(
              title: "RERA State",
              subTitle: "Karnataka"
          ),
          ReRaDetailsModel(
              title: "RERA Number",
              subTitle: "K51800035827"
          ),
          ReRaDetailsModel(
              title: "RERA Expiry",
              subTitle: "12 Aug 2024"
          )
        ]
    ));
    arrReRaDetailsList.add(ReRaCertificatesModel(
        isExpiryCertificates: "0",
        isWrongCompanyInfo: "1",
        reRaDetailsList: [
          ReRaDetailsModel(
              title: "RERA State",
              subTitle: "Goa"
          ),
          ReRaDetailsModel(
              title: "RERA Number",
              subTitle: "G51800035827"
          ),
          ReRaDetailsModel(
              title: "RERA Expiry",
              subTitle: "12 Aug 2024"
          )
        ]
    ));
    return arrReRaDetailsList;

  }
  
}

class ReRaCertificatesModel{
  String? isExpiryCertificates;
  String? isWrongCompanyInfo;


  List<ReRaDetailsModel>? reRaDetailsList;
  ReRaCertificatesModel({this.isExpiryCertificates,this.reRaDetailsList,this.isWrongCompanyInfo});
}

class ReRaDetailsModel{
  String? title;
  String? subTitle;
  String? isExpiryDate;
  ReRaDetailsModel({this.isExpiryDate,this.title,this.subTitle});
}

