class ProjectListModel {
  String? projectLogo;
  String? projectTitle;
  String? address;
  List<String>? projectImageList;
  List<ConfigureModel>? configureList;

  ProjectListModel({this.projectTitle,this.configureList,this.address,this.projectLogo,this.projectImageList});
}

class ConfigureModel{
  String? totalBHK;
  String? totalRS;
  String? onWords;
  ConfigureModel({this.totalBHK,this.totalRS,this.onWords});
}