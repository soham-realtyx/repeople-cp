

class EarningModel{
  String? name;
  String? address;
  String? invoiceText;
  String? receiptText;
  String? isInvoiceText;
  List<EarningDateModel>? earningDateList;
  List<EarningCountModel>? earningCountList;

  EarningModel({this.name,this.isInvoiceText,this.receiptText,this.address,this.earningCountList,this.earningDateList,this.invoiceText});

}

class EarningCountModel{
  String? earningText;
  String? isEarningCount;
  EarningCountModel({this.earningText,this.isEarningCount});
}

class EarningDateModel{
  String? title;
  String? earningValue;
  EarningDateModel({this.title,this.earningValue});
}

class EarningFilterModel{
  String? title;
  String? totalCount;
  EarningFilterModel({this.title,this.totalCount});
}