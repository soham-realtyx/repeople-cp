import 'package:get/get.dart';

class PanDetailsController extends GetxController{

  RxList<PanCertificatesModel> arrPanDetailsList = RxList([]);

  Future<RxList<PanCertificatesModel>> getPanDetailsData()async{
    arrPanDetailsList = RxList([]);
    arrPanDetailsList.add(PanCertificatesModel(
        isExpiryCertificates: "1",
        isWrongCompanyInfo: "0",

        panDetailsList: [
          PanDetailsModel(
            title: "PAN No",
            subTitle: "ABCDE1234F",

          ),
          PanDetailsModel(
              title: "Company Name",
              subTitle: "Brikkin Martech Private Limited"
          ),
          PanDetailsModel(
              title: "PAN Status",
              subTitle: "DeActive",
              isExpiryDate: "1"
          )
        ]
    ));
    arrPanDetailsList.add(PanCertificatesModel(
        isExpiryCertificates: "0",
        isWrongCompanyInfo: "0",
        panDetailsList: [
          PanDetailsModel(
            title: "PAN No",
            subTitle: "ABCDE1234F",
          ),
          PanDetailsModel(
              title: "Company Name",
              subTitle: "Brikkin Martech Private Limited"
          ),
          PanDetailsModel(
              title: "PAN Status",
              subTitle: "Active",
              isExpiryDate: "0"
          )
        ]
    ));
    arrPanDetailsList.add(PanCertificatesModel(
        isExpiryCertificates: "0",
        isWrongCompanyInfo: "0",
        panDetailsList: [
          PanDetailsModel(
            title: "PAN No",
            subTitle: "ABCDE1234F",
          ),
          PanDetailsModel(
              title: "Company Name",
              subTitle: "Brikkin Martech Private Limited"
          ),
          PanDetailsModel(
              title: "PAN Status",
              subTitle: "Active",
              isExpiryDate: "0"
          )
        ]
    ));
    return arrPanDetailsList;
  }

}

class PanCertificatesModel{
  String? isExpiryCertificates;
  String? isWrongCompanyInfo;


  List<PanDetailsModel>? panDetailsList;
  PanCertificatesModel({this.isExpiryCertificates,this.panDetailsList,this.isWrongCompanyInfo});
}

class PanDetailsModel{
  String? title;
  String? subTitle;
  String? isExpiryDate;
  PanDetailsModel({this.isExpiryDate,this.title,this.subTitle});
}

