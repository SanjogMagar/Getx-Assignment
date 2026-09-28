class UserModel {
  final int? page;
  final int? perPage;
  final int? total;
  final int? totalPages;
  final List<UserData>? data;
  final Support? support;
  final Meta? meta;

  UserModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
    this.meta,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((e) => UserData.fromJson(e))
              .toList()
          : null,
      support: json['support'] != null
          ? Support.fromJson(json['support'])
          : null,
      meta: json['_meta'] != null
          ? Meta.fromJson(json['_meta'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'per_page': perPage,
      'total': total,
      'total_pages': totalPages,
      'data': data?.map((e) => e.toJson()).toList(),
      'support': support?.toJson(),
      '_meta': meta?.toJson(),
    };
  }
}

class UserData {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  UserData({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
    };
  }
}

class Support {
  final String? url;
  final String? text;

  Support({
    this.url,
    this.text,
  });

  factory Support.fromJson(Map<String, dynamic> json) {
    return Support(
      url: json['url'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'text': text,
    };
  }
}

class Meta {
  final String? poweredBy;
  final String? docsUrl;
  final String? upgradeUrl;
  final String? exampleUrl;
  final String? variant;
  final String? message;
  final Cta? cta;
  final String? context;

  Meta({
    this.poweredBy,
    this.docsUrl,
    this.upgradeUrl,
    this.exampleUrl,
    this.variant,
    this.message,
    this.cta,
    this.context,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      poweredBy: json['powered_by'],
      docsUrl: json['docs_url'],
      upgradeUrl: json['upgrade_url'],
      exampleUrl: json['example_url'],
      variant: json['variant'],
      message: json['message'],
      cta: json['cta'] != null
          ? Cta.fromJson(json['cta'])
          : null,
      context: json['context'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'powered_by': poweredBy,
      'docs_url': docsUrl,
      'upgrade_url': upgradeUrl,
      'example_url': exampleUrl,
      'variant': variant,
      'message': message,
      'cta': cta?.toJson(),
      'context': context,
    };
  }
}

class Cta {
  final String? label;
  final String? url;

  Cta({
    this.label,
    this.url,
  });

  factory Cta.fromJson(Map<String, dynamic> json) {
    return Cta(
      label: json['label'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'url': url,
    };
  }
}