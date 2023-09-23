import 'package:get/get.dart';

class GSTDetailsController extends GetxController{

  RxList<GSTCertificatesModel> arrGSTDetailsList = RxList([]);

  Future<RxList<GSTCertificatesModel>> getGSTDetailsData()async{
    arrGSTDetailsList = RxList([]);
    arrGSTDetailsList.add(GSTCertificatesModel(
        isExpiryCertificates: "0",
        isWrongCompanyInfo: "0",

        gstDetailsList: [
          GSTDetailsModel(
            title: "RERA State",
            subTitle: "Maharashtra",
          ),
          GSTDetailsModel(
              title: "GST Number",
              subTitle: "27AALCR0049L1Z2"
          ),
          GSTDetailsModel(
              title: "GSTIN Status",
              subTitle: "Active",
          )
        ]
    ));
    arrGSTDetailsList.add(GSTCertificatesModel(
        isExpiryCertificates: "0",
        isWrongCompanyInfo: "0",
        gstDetailsList: [
          GSTDetailsModel(
            title: "RERA State",
            subTitle: "Karnataka",

          ),
          GSTDetailsModel(
              title: "GST Number",
              subTitle: "K51800035827"
          ),
          GSTDetailsModel(
            title: "GSTIN Status",
            subTitle: "Active",
          )
        ]
    ));
    arrGSTDetailsList.add(GSTCertificatesModel(
        isExpiryCertificates: "0",
        isWrongCompanyInfo: "1",
        gstDetailsList: [
          GSTDetailsModel(
            title: "RERA State",
            subTitle: "Goa",

          ),
          GSTDetailsModel(
              title: "GST Number",
              subTitle: "A51800035827"
          ),
          GSTDetailsModel(
            title: "GSTIN Status",
            subTitle: "Active",
          )
        ]
    ));
    return arrGSTDetailsList;
  }

}

class GSTCertificatesModel{
  String? isExpiryCertificates;
  String? isWrongCompanyInfo;


  List<GSTDetailsModel>? gstDetailsList;
  GSTCertificatesModel({this.isExpiryCertificates,this.gstDetailsList,this.isWrongCompanyInfo});
}

class GSTDetailsModel{
  String? title;
  String? subTitle;
  String? isExpiryDate;
  GSTDetailsModel({this.isExpiryDate,this.title,this.subTitle});
}

