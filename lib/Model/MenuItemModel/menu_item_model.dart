class MenuItemModel {
  String? id;
  String? name;
  String? alias;
  String? icon;
  String? color;
  int? isShowAndroid;
  int? isShowIos;
  bool? isSelected;

  MenuItemModel(
      {this.id,
        this.name,
        this.alias,
        this.icon,
        this.color,
        this.isShowAndroid,
        this.isShowIos,
        this.isSelected,
      });

  MenuItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    icon = json['icon'];
    color = json['color'];
    isShowAndroid = json['isshowandroid'];
    isShowIos = json['isshowios'];
    isSelected = json['isselected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    data['icon'] = icon;
    data['color'] = color;
    data['isshowandroid'] = isShowAndroid;
    data['isshowios'] = isShowIos;
    data['isselected'] = isSelected;
    return data;
  }
}