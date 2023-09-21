import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Model/EarngingModel/EarningModel.dart';

class EarningsController extends GetxController {
  RxList<EarningFilterModel> arrEarningFilterList = RxList([]);
  RxList<EarningModel> arrEarningList = RxList([]);

  RxInt filterIndex = 0.obs;

  Future<RxList<EarningFilterModel>> getEarningFilterListData() async {
    arrEarningFilterList = RxList([]);
    arrEarningFilterList
        .add(EarningFilterModel(title: "Data", totalCount: "All"));
    arrEarningFilterList
        .add(EarningFilterModel(title: "Paid", totalCount: "6"));
    arrEarningFilterList
        .add(EarningFilterModel(title: "Invoiced", totalCount: "7"));
    arrEarningFilterList
        .add(EarningFilterModel(title: "Registration", totalCount: "8"));
    return arrEarningFilterList;
  }

  Future<RxList<EarningModel>> getEarningData() async {
    arrEarningList = RxList([]);
    arrEarningList.add(EarningModel(
        name: "Yash Goswami",
        address: "101, Tower-A, WorldHome Superstar",
        invoiceText: "Share Invoice",
        isInvoiceText: "1",
        earningCountList: [
          EarningCountModel(earningText: "Site Visit",isEarningCount: "1"),
          EarningCountModel(earningText: "EOI",isEarningCount: "1"),
          EarningCountModel(earningText: "Registration",isEarningCount: "0"),
          EarningCountModel(earningText: "Invoiced",isEarningCount: "0"),
          EarningCountModel(earningText: "Paid",isEarningCount: "0"),
        ],
        earningDateList: [
          EarningDateModel(title: "Site Visit",earningValue: "18 Jun, 2023"),
          EarningDateModel(title: "EOI",earningValue: "20 Jun, 2023"),
          EarningDateModel(title: "Registration",earningValue: "-"),
          EarningDateModel(title: "Agreement Value",earningValue: "-"),
          EarningDateModel(title: "Brokerage Slab",earningValue: "-"),
          EarningDateModel(title: "Brokerage Amount",earningValue: "-"),
          EarningDateModel(title: "Brokerage Paid",earningValue: "-"),
        ]));
    arrEarningList.add(EarningModel(
        name: "Harshil Chauhan",
        address: "809, Tower-C, WorldHome Superstar",
        invoiceText: "Share Invoice",
        isInvoiceText: "1",
        earningCountList: [
          EarningCountModel(earningText: "Site Visit",isEarningCount: "1"),
          EarningCountModel(earningText: "EOI",isEarningCount: "1"),
          EarningCountModel(earningText: "Registration",isEarningCount: "1"),
          EarningCountModel(earningText: "Invoiced",isEarningCount: "0"),
          EarningCountModel(earningText: "Paid",isEarningCount: "0"),
        ],
        earningDateList: [
          EarningDateModel(title: "Site Visit",earningValue: "18 Jun, 2023"),
          EarningDateModel(title: "EOI",earningValue: "19 Jun, 2023"),
          EarningDateModel(title: "Registration",earningValue: "28 Sep, 2023"),
          EarningDateModel(title: "Agreement Value",earningValue: "₹ 50,00,000"),
          EarningDateModel(title: "Brokerage Slab",earningValue: "2%"),
          EarningDateModel(title: "Brokerage Amount",earningValue: "₹ 1,00,000"),
          EarningDateModel(title: "Brokerage Paid",earningValue: "0"),
        ]));
    arrEarningList.add(EarningModel(
        name: "Vimal Patel",
        address: "702, Tower-B, WorldHome Superstar",
        invoiceText: "Share Invoice",
        isInvoiceText: "0",
        earningCountList: [
          EarningCountModel(earningText: "Site Visit",isEarningCount: "1"),
          EarningCountModel(earningText: "EOI",isEarningCount: "1"),
          EarningCountModel(earningText: "Registration",isEarningCount: "1"),
          EarningCountModel(earningText: "Invoiced",isEarningCount: "1"),
          EarningCountModel(earningText: "Paid",isEarningCount: "0"),
        ],
        earningDateList: [
          EarningDateModel(title: "Site Visit",earningValue: "21 May, 2023"),
          EarningDateModel(title: "EOI",earningValue: "23 May, 2023"),
          EarningDateModel(title: "Registration",earningValue: "23 Jun, 2023"),
          EarningDateModel(title: "Agreement Value",earningValue: "₹ 60,00,000"),
          EarningDateModel(title: "Brokerage Slab",earningValue: "2%"),
          EarningDateModel(title: "Brokerage Amount",earningValue: "₹ 1,20,000"),
          EarningDateModel(title: "Brokerage Paid",earningValue: "0"),
        ]));
    arrEarningList.add(EarningModel(
        name: "Vimal Patel",
        address: "702, Tower-B, WorldHome Superstar",
        invoiceText: "Share Invoice",
        isInvoiceText: "0",
        receiptText: "Receipt",
        earningCountList: [
          EarningCountModel(earningText: "Site Visit",isEarningCount: "1"),
          EarningCountModel(earningText: "EOI",isEarningCount: "1"),
          EarningCountModel(earningText: "Registration",isEarningCount: "1"),
          EarningCountModel(earningText: "Invoiced",isEarningCount: "1"),
          EarningCountModel(earningText: "Paid",isEarningCount: "1"),
        ],
        earningDateList: [
          EarningDateModel(title: "Site Visit",earningValue: "3 Feb, 2023"),
          EarningDateModel(title: "EOI",earningValue: "10 Mar, 2023"),
          EarningDateModel(title: "Registration",earningValue: "22 May, 2023"),
          EarningDateModel(title: "Agreement Value",earningValue: "₹ 45,50,000"),
          EarningDateModel(title: "Brokerage Slab",earningValue: "2%"),
          EarningDateModel(title: "Brokerage Amount",earningValue: "₹ 91,000"),
          EarningDateModel(title: "Brokerage Paid",earningValue: "₹ 91,000"),
        ]));
    arrEarningList.add(EarningModel(
        name: "Vimal Patel",
        address: "702, Tower-B, WorldHome Superstar",
        invoiceText: "Share Invoice",
        isInvoiceText: "0",
        receiptText: "Receipt",
        earningCountList: [
          EarningCountModel(earningText: "Site Visit",isEarningCount: "1"),
          EarningCountModel(earningText: "EOI",isEarningCount: "1"),
          EarningCountModel(earningText: "Registration",isEarningCount: "1"),
          EarningCountModel(earningText: "Invoiced",isEarningCount: "0"),
          EarningCountModel(earningText: "Paid",isEarningCount: "0"),
        ],
        earningDateList: [
          EarningDateModel(title: "Site Visit",earningValue: "19 Jun, 2023"),
          EarningDateModel(title: "EOI",earningValue: "19 Jun, 2023"),
          EarningDateModel(title: "Cancelled",earningValue: "28 Jul, 2023"),
        ]));
    return arrEarningList;
  }
}
