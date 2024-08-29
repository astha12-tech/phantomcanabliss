// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  int? id;
  String? name;
  String? slug;
  int? parent;
  String? description;
  String? display;
  Image? image;
  int? menuOrder;
  int? count;
  String? yoastHead;
  YoastHeadJson? yoastHeadJson;
  Links? links;

  CategoryModel({
    this.id,
    this.name,
    this.slug,
    this.parent,
    this.description,
    this.display,
    this.image,
    this.menuOrder,
    this.count,
    this.yoastHead,
    this.yoastHeadJson,
    this.links,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        parent: json["parent"],
        description: json["description"],
        display: json["display"],
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        menuOrder: json["menu_order"],
        count: json["count"],
        yoastHead: json["yoast_head"],
        yoastHeadJson: json["yoast_head_json"] == null
            ? null
            : YoastHeadJson.fromJson(json["yoast_head_json"]),
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "parent": parent,
        "description": description,
        "display": display,
        "image": image?.toJson(),
        "menu_order": menuOrder,
        "count": count,
        "yoast_head": yoastHead,
        "yoast_head_json": yoastHeadJson?.toJson(),
        "_links": links?.toJson(),
      };
}

class Image {
  int? id;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? src;
  String? name;
  String? alt;

  Image({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.src,
    this.name,
    this.alt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        dateCreatedGmt: json["date_created_gmt"] == null
            ? null
            : DateTime.parse(json["date_created_gmt"]),
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
        dateModifiedGmt: json["date_modified_gmt"] == null
            ? null
            : DateTime.parse(json["date_modified_gmt"]),
        src: json["src"],
        name: json["name"],
        alt: json["alt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_created": dateCreated?.toIso8601String(),
        "date_created_gmt": dateCreatedGmt?.toIso8601String(),
        "date_modified": dateModified?.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt?.toIso8601String(),
        "src": src,
        "name": name,
        "alt": alt,
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
        self: json["self"] == null
            ? []
            : List<Collection>.from(
                json["self"]!.map((x) => Collection.fromJson(x))),
        collection: json["collection"] == null
            ? []
            : List<Collection>.from(
                json["collection"]!.map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": self == null
            ? []
            : List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": collection == null
            ? []
            : List<dynamic>.from(collection!.map((x) => x.toJson())),
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

class YoastHeadJson {
  String? title;
  String? description;
  Robots? robots;
  String? canonical;
  String? ogLocale;
  String? ogType;
  String? ogTitle;
  String? ogDescription;
  String? ogUrl;
  String? ogSiteName;
  String? twitterCard;
  Schema? schema;

  YoastHeadJson({
    this.title,
    this.description,
    this.robots,
    this.canonical,
    this.ogLocale,
    this.ogType,
    this.ogTitle,
    this.ogDescription,
    this.ogUrl,
    this.ogSiteName,
    this.twitterCard,
    this.schema,
  });

  factory YoastHeadJson.fromJson(Map<String, dynamic> json) => YoastHeadJson(
        title: json["title"],
        description: json["description"],
        robots: json["robots"] == null ? null : Robots.fromJson(json["robots"]),
        canonical: json["canonical"],
        ogLocale: json["og_locale"],
        ogType: json["og_type"],
        ogTitle: json["og_title"],
        ogDescription: json["og_description"],
        ogUrl: json["og_url"],
        ogSiteName: json["og_site_name"],
        twitterCard: json["twitter_card"],
        schema: json["schema"] == null ? null : Schema.fromJson(json["schema"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "robots": robots?.toJson(),
        "canonical": canonical,
        "og_locale": ogLocale,
        "og_type": ogType,
        "og_title": ogTitle,
        "og_description": ogDescription,
        "og_url": ogUrl,
        "og_site_name": ogSiteName,
        "twitter_card": twitterCard,
        "schema": schema?.toJson(),
      };
}

class Robots {
  String? index;
  String? follow;
  String? maxSnippet;
  String? maxImagePreview;
  String? maxVideoPreview;

  Robots({
    this.index,
    this.follow,
    this.maxSnippet,
    this.maxImagePreview,
    this.maxVideoPreview,
  });

  factory Robots.fromJson(Map<String, dynamic> json) => Robots(
        index: json["index"],
        follow: json["follow"],
        maxSnippet: json["max-snippet"],
        maxImagePreview: json["max-image-preview"],
        maxVideoPreview: json["max-video-preview"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "follow": follow,
        "max-snippet": maxSnippet,
        "max-image-preview": maxImagePreview,
        "max-video-preview": maxVideoPreview,
      };
}

class Schema {
  String? context;
  List<Graph>? graph;

  Schema({
    this.context,
    this.graph,
  });

  factory Schema.fromJson(Map<String, dynamic> json) => Schema(
        context: json["@context"],
        graph: json["@graph"] == null
            ? []
            : List<Graph>.from(json["@graph"]!.map((x) => Graph.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "@context": context,
        "@graph": graph == null
            ? []
            : List<dynamic>.from(graph!.map((x) => x.toJson())),
      };
}

class Graph {
  String? type;
  String? id;
  String? url;
  String? name;
  Breadcrumb? isPartOf;
  String? description;
  Breadcrumb? breadcrumb;
  String? inLanguage;
  List<ItemListElement>? itemListElement;
  Breadcrumb? publisher;
  List<PotentialAction>? potentialAction;
  Logo? logo;
  Breadcrumb? image;

  Graph({
    this.type,
    this.id,
    this.url,
    this.name,
    this.isPartOf,
    this.description,
    this.breadcrumb,
    this.inLanguage,
    this.itemListElement,
    this.publisher,
    this.potentialAction,
    this.logo,
    this.image,
  });

  factory Graph.fromJson(Map<String, dynamic> json) => Graph(
        type: json["@type"],
        id: json["@id"],
        url: json["url"],
        name: json["name"],
        isPartOf: json["isPartOf"] == null
            ? null
            : Breadcrumb.fromJson(json["isPartOf"]),
        description: json["description"],
        breadcrumb: json["breadcrumb"] == null
            ? null
            : Breadcrumb.fromJson(json["breadcrumb"]),
        inLanguage: json["inLanguage"],
        itemListElement: json["itemListElement"] == null
            ? []
            : List<ItemListElement>.from(json["itemListElement"]!
                .map((x) => ItemListElement.fromJson(x))),
        publisher: json["publisher"] == null
            ? null
            : Breadcrumb.fromJson(json["publisher"]),
        potentialAction: json["potentialAction"] == null
            ? []
            : List<PotentialAction>.from(json["potentialAction"]!
                .map((x) => PotentialAction.fromJson(x))),
        logo: json["logo"] == null ? null : Logo.fromJson(json["logo"]),
        image:
            json["image"] == null ? null : Breadcrumb.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "@type": type,
        "@id": id,
        "url": url,
        "name": name,
        "isPartOf": isPartOf?.toJson(),
        "description": description,
        "breadcrumb": breadcrumb?.toJson(),
        "inLanguage": inLanguage,
        "itemListElement": itemListElement == null
            ? []
            : List<dynamic>.from(itemListElement!.map((x) => x.toJson())),
        "publisher": publisher?.toJson(),
        "potentialAction": potentialAction == null
            ? []
            : List<dynamic>.from(potentialAction!.map((x) => x.toJson())),
        "logo": logo?.toJson(),
        "image": image?.toJson(),
      };
}

class Breadcrumb {
  String? id;

  Breadcrumb({
    this.id,
  });

  factory Breadcrumb.fromJson(Map<String, dynamic> json) => Breadcrumb(
        id: json["@id"],
      );

  Map<String, dynamic> toJson() => {
        "@id": id,
      };
}

class ItemListElement {
  String? type;
  int? position;
  String? name;
  String? item;

  ItemListElement({
    this.type,
    this.position,
    this.name,
    this.item,
  });

  factory ItemListElement.fromJson(Map<String, dynamic> json) =>
      ItemListElement(
        type: json["@type"],
        position: json["position"],
        name: json["name"],
        item: json["item"],
      );

  Map<String, dynamic> toJson() => {
        "@type": type,
        "position": position,
        "name": name,
        "item": item,
      };
}

class Logo {
  String? type;
  String? inLanguage;
  String? id;
  String? url;
  String? contentUrl;
  int? width;
  int? height;
  String? caption;

  Logo({
    this.type,
    this.inLanguage,
    this.id,
    this.url,
    this.contentUrl,
    this.width,
    this.height,
    this.caption,
  });

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
        type: json["@type"],
        inLanguage: json["inLanguage"],
        id: json["@id"],
        url: json["url"],
        contentUrl: json["contentUrl"],
        width: json["width"],
        height: json["height"],
        caption: json["caption"],
      );

  Map<String, dynamic> toJson() => {
        "@type": type,
        "inLanguage": inLanguage,
        "@id": id,
        "url": url,
        "contentUrl": contentUrl,
        "width": width,
        "height": height,
        "caption": caption,
      };
}

class PotentialAction {
  String? type;
  Target? target;
  String? queryInput;

  PotentialAction({
    this.type,
    this.target,
    this.queryInput,
  });

  factory PotentialAction.fromJson(Map<String, dynamic> json) =>
      PotentialAction(
        type: json["@type"],
        target: json["target"] == null ? null : Target.fromJson(json["target"]),
        queryInput: json["query-input"],
      );

  Map<String, dynamic> toJson() => {
        "@type": type,
        "target": target?.toJson(),
        "query-input": queryInput,
      };
}

class Target {
  String? type;
  String? urlTemplate;

  Target({
    this.type,
    this.urlTemplate,
  });

  factory Target.fromJson(Map<String, dynamic> json) => Target(
        type: json["@type"],
        urlTemplate: json["urlTemplate"],
      );

  Map<String, dynamic> toJson() => {
        "@type": type,
        "urlTemplate": urlTemplate,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
