

class User {
    String name;

    User({this.name});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            name: json['name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['name'] = this.name;
        return data;
    }
}