import 'package:get/get.dart';

class BankDetailsController extends GetxController{

  RxList<BankCertificatesModel> arrBankDetailsList = RxList([]);

  Future<RxList<BankCertificatesModel>> getBankDetailsData()async{
    arrBankDetailsList = RxList([]);
    arrBankDetailsList.add(BankCertificatesModel(
        isExpiryCertificates: "0",
        isWrongCompanyInfo: "0",

        bankDetailsList: [
          BankDetailsModel(
            title: "Bank",
            subTitle: "Kotak Mahindra Bank",
          ),
          BankDetailsModel(
              title: "Account Number",
              subTitle: "0645293614"
          ),
          BankDetailsModel(
            title: "IFSC",
            subTitle: "KKBK0001367",
          )
        ]
    ));
    arrBankDetailsList.add(BankCertificatesModel(
        isExpiryCertificates: "0",
        isWrongCompanyInfo: "0",
        bankDetailsList: [
          BankDetailsModel(
            title: "Bank",
            subTitle: "Kotak Mahindra Bank",
          ),
          BankDetailsModel(
              title: "Account Number",
              subTitle: "0645293615"
          ),
          BankDetailsModel(
            title: "IFSC",
            subTitle: "KKBK0001367",
          )
        ]
    ));
    arrBankDetailsList.add(BankCertificatesModel(
        isExpiryCertificates: "0",
        isWrongCompanyInfo: "1",
        bankDetailsList: [
          BankDetailsModel(
            title: "Bank",
            subTitle: "Kotak Mahindra Bank",
          ),
          BankDetailsModel(
              title: "Account Number",
              subTitle: "A51800035827"
          ),
          BankDetailsModel(
            title: "IFSC",
            subTitle: "KKBK0001367",
          )
        ]
    ));
    return arrBankDetailsList;
  }

}

class BankCertificatesModel{
  String? isExpiryCertificates;
  String? isWrongCompanyInfo;


  List<BankDetailsModel>? bankDetailsList;
  BankCertificatesModel({this.isExpiryCertificates,this.bankDetailsList,this.isWrongCompanyInfo});
}

class BankDetailsModel{
  String? title;
  String? subTitle;
  String? isExpiryDate;
  BankDetailsModel({this.isExpiryDate,this.title,this.subTitle});
}

