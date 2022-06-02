class Dados {
  late int page;
  late int perPage;
  late int total;
  late int totalPages;
  late List<UserModel> data;
  late Support support;

  Dados(
      {required this.page,
        required this.perPage,
        required this.total,
        required this.totalPages,
         this.data = const <UserModel>[],
        required this.support});

  Dados.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      data =  <UserModel>[];
      json['data'].forEach((v) {
        data.add( UserModel.fromJson(v));
      });
    }
    support =
    (json['support'] != null ?  Support.fromJson(json['support']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['page'] = page;
    data['per_page'] = perPage;
    data['total'] = total;
    data['total_pages'] = totalPages;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    data['support'] = support.toJson();

    return data;
  }
}

class UserModel {
  late int id;
  late String email;
  late String firstName;
  late String lastName;
  late String avatar;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar'] = avatar;
    return data;
  }
}

class Support {
  late String url;
  late String text;

  Support({
    required this.url,
    required this.text
  });

  Support.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['text'] = text;
    return data;
  }
}