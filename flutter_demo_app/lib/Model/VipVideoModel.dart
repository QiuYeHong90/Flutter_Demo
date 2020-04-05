

import 'VipUrlItem.dart';

class VipVideoModel {
    List<VipUrlItem> list;
    List<VipUrlItem> platformlist;

    VipVideoModel({this.list, this.platformlist});

    factory VipVideoModel.fromJson(Map<String, dynamic> json) {
        return VipVideoModel(
            list: json['list'] != null ? (json['list'] as List).map((i) => VipUrlItem.fromJson(i)).toList() : null, 
            platformlist: json['platformlist'] != null ? (json['platformlist'] as List).map((i) => VipUrlItem.fromJson(i)).toList() : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.list != null) {
            data['list'] = this.list.map((v) => v.toJson()).toList();
        }
        if (this.platformlist != null) {
            data['platformlist'] = this.platformlist.map((v) => v.toJson()).toList();
        }
        return data;
    }
}