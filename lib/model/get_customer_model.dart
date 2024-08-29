// To parse this JSON data, do
//
//     final getCustomerModel = getCustomerModelFromJson(jsonString);

import 'dart:convert';

GetCustomerModel getCustomerModelFromJson(String str) => GetCustomerModel.fromJson(json.decode(str));

String getCustomerModelToJson(GetCustomerModel data) => json.encode(data.toJson());

class GetCustomerModel {
    int? id;
    DateTime? dateCreated;
    DateTime? dateCreatedGmt;
    DateTime? dateModified;
    DateTime? dateModifiedGmt;
    String? email;
    String? firstName;
    String? lastName;
    String? role;
    String? username;
    Ing? billing;
    Ing? shipping;
    bool? isPayingCustomer;
    String? avatarUrl;
    List<MetaDatum>? metaData;
    Links? links;

    GetCustomerModel({
        this.id,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.email,
        this.firstName,
        this.lastName,
        this.role,
        this.username,
        this.billing,
        this.shipping,
        this.isPayingCustomer,
        this.avatarUrl,
        this.metaData,
        this.links,
    });

    factory GetCustomerModel.fromJson(Map<String, dynamic> json) => GetCustomerModel(
        id: json["id"],
        dateCreated: json["date_created"] == null ? null : DateTime.parse(json["date_created"]),
        dateCreatedGmt: json["date_created_gmt"] == null ? null : DateTime.parse(json["date_created_gmt"]),
        dateModified: json["date_modified"] == null ? null : DateTime.parse(json["date_modified"]),
        dateModifiedGmt: json["date_modified_gmt"] == null ? null : DateTime.parse(json["date_modified_gmt"]),
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        role: json["role"],
        username: json["username"],
        billing: json["billing"] == null ? null : Ing.fromJson(json["billing"]),
        shipping: json["shipping"] == null ? null : Ing.fromJson(json["shipping"]),
        isPayingCustomer: json["is_paying_customer"],
        avatarUrl: json["avatar_url"],
        metaData: json["meta_data"] == null ? [] : List<MetaDatum>.from(json["meta_data"]!.map((x) => MetaDatum.fromJson(x))),
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date_created": dateCreated?.toIso8601String(),
        "date_created_gmt": dateCreatedGmt?.toIso8601String(),
        "date_modified": dateModified?.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt?.toIso8601String(),
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "role": role,
        "username": username,
        "billing": billing?.toJson(),
        "shipping": shipping?.toJson(),
        "is_paying_customer": isPayingCustomer,
        "avatar_url": avatarUrl,
        "meta_data": metaData == null ? [] : List<dynamic>.from(metaData!.map((x) => x.toJson())),
        "_links": links?.toJson(),
    };
}

class Ing {
    String? firstName;
    String? lastName;
    String? company;
    String? address1;
    String? address2;
    String? city;
    String? postcode;
    String? country;
    String? state;
    String? email;
    String? phone;

    Ing({
        this.firstName,
        this.lastName,
        this.company,
        this.address1,
        this.address2,
        this.city,
        this.postcode,
        this.country,
        this.state,
        this.email,
        this.phone,
    });

    factory Ing.fromJson(Map<String, dynamic> json) => Ing(
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        postcode: json["postcode"],
        country: json["country"],
        state: json["state"],
        email: json["email"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "company": company,
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "postcode": postcode,
        "country": country,
        "state": state,
        "email": email,
        "phone": phone,
    };
}

class Links {
    List<Collection>? self;
    List<Collection>? collection;

    Links({
        this.self,
        this.collection,
    });

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null ? [] : List<Collection>.from(json["self"]!.map((x) => Collection.fromJson(x))),
        collection: json["collection"] == null ? [] : List<Collection>.from(json["collection"]!.map((x) => Collection.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "self": self == null ? [] : List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": collection == null ? [] : List<dynamic>.from(collection!.map((x) => x.toJson())),
    };
}

class Collection {
    String? href;

    Collection({
        this.href,
    });

    factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "href": href,
    };
}

class MetaDatum {
    int? id;
    String? key;
    dynamic value;

    MetaDatum({
        this.id,
        this.key,
        this.value,
    });

    factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
        id: json["id"],
        key: json["key"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
    };
}

class ValueClass {
    The12Kdl1? the12Kdl1;

    ValueClass({
        this.the12Kdl1,
    });

    factory ValueClass.fromJson(Map<String, dynamic> json) => ValueClass(
        the12Kdl1: json["12KDL1"] == null ? null : The12Kdl1.fromJson(json["12KDL1"]),
    );

    Map<String, dynamic> toJson() => {
        "12KDL1": the12Kdl1?.toJson(),
    };
}

class The12Kdl1 {
    String? type;
    String? name;
    String? time;

    The12Kdl1({
        this.type,
        this.name,
        this.time,
    });

    factory The12Kdl1.fromJson(Map<String, dynamic> json) => The12Kdl1(
        type: json["type"],
        name: json["name"],
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "time": time,
    };
}
