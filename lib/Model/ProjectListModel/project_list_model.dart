class ProjectListModel {
  String? projectLogo;
  String? projectTitle;
  String? address;
  List<String>? projectImageList;
  List<ConfigureModel>? configureList;
  List<OverViewModel>? overViewList;
  LayoutModal? layout;

  ProjectListModel(
      {this.projectTitle,
      this.configureList,
      this.address,
      this.projectLogo,
        this.overViewList,
        this.layout,
      this.projectImageList});
}

class ConfigureModel {
  String? totalBHK;
  String? totalRS;
  String? onWords;
  ConfigureModel({this.totalBHK, this.totalRS, this.onWords});
}

class OverViewModel {
  String? title;
  String? constructionStatus;
  String? projectLocation;
  List<String>? reRaList;
  List<String>? homeList;
  List<String>? brochureList;
  OverViewModel(
      {this.title,
      this.brochureList,
      this.constructionStatus,
      this.homeList,
      this.projectLocation,
      this.reRaList});
}

class LayoutModal {
  String? lable;
  List<LayoutDataModal>? layoutdata;

  LayoutModal({
    this.lable,
    this.layoutdata,

  });

  LayoutModal.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];

    if (json['data'] != null && json['data'].length>0 && json['data'].toString().contains("[")) {
      print("${json['data']}our json dataaaa");
      layoutdata = <LayoutDataModal>[];
      json['data'].forEach((v) {
        layoutdata!.add(LayoutDataModal.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lable'] = lable;
    return data;
  }
}

class LayoutDataModal {
  String? layoutname;
  String? icon;
  String? layouttype;



  LayoutDataModal({

    this.layoutname,
    this.icon,
    this.layouttype,

  });

  LayoutDataModal.fromJson(Map<String, dynamic> json) {
    layoutname = json['layoutname'];
    icon = json['icon'].toString();
    layouttype = json['layouttype'].toString();


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['layoutname'] = layoutname;
    data['icon'] = icon;
    data['layouttype'] = layouttype;


    return data;
  }
}
