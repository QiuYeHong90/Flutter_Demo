

class VipUrlItem {
    int canvip;
    String icon;
    String name;
    String url;

    VipUrlItem({this.canvip, this.icon, this.name, this.url});

    factory VipUrlItem.fromJson(Map<String, dynamic> json) {
        return VipUrlItem(
            canvip: json['canvip'], 
            icon: json['icon'], 
            name: json['name'], 
            url: json['url'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['canvip'] = this.canvip;
        data['icon'] = this.icon;
        data['name'] = this.name;
        data['url'] = this.url;
        return data;
    }
}