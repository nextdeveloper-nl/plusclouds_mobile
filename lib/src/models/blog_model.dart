class BlogData {
  String? id;
  String? slug;
  String? title;
  String? body;
  String? headerImage;
  String? metaTitle;
  String? metaDescription;
  String? metaKeywords;
  int? replyCount;
  int? readCount;
  int? bonusPoints;
  bool? isActive;
  bool? isLocked;
  bool? isPinned;
  bool? isDraft;
  bool? isMarkdown;
  List<String>? tags;
  String? iamAccountId;
  String? iamUserId;
  String? commonCategoryId;
  String? commonDomainId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  User? user;
  List<Media>? media;

  BlogData({
    this.id,
    this.slug,
    this.title,
    this.body,
    this.headerImage,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.replyCount,
    this.readCount,
    this.bonusPoints,
    this.isActive,
    this.isLocked,
    this.isPinned,
    this.isDraft,
    this.isMarkdown,
    this.tags,
    this.iamAccountId,
    this.iamUserId,
    this.commonCategoryId,
    this.commonDomainId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.user,
    this.media,
  });

  factory BlogData.fromJson(Map<String, dynamic> json) {
    return BlogData(
      id: json['id'],
      slug: json['slug'],
      title: json['title'],
      body: json['body'],
      headerImage: json['header_image'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      metaKeywords: json['meta_keywords'],
      replyCount: json['reply_count'],
      readCount: json['read_count'],
      bonusPoints: json['bonus_points'],
      isActive: json['is_active'],
      isLocked: json['is_locked'],
      isPinned: json['is_pinned'],
      isDraft: json['is_draft'],
      isMarkdown: json['is_markdown'],
      tags: json['tags'] != null ? List<String>.from(json['tags'].map((x) => x)) : null,
      iamAccountId: json['iam_account_id'],
      iamUserId: json['iam_user_id'],
      commonCategoryId: json['common_category_id'],
      commonDomainId: json['common_domain_id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
      user: json['user'] != null ? User.fromJson(json['user']['data']) : null,
      media: json['media'] != null ? List<Media>.from(json['media']['data'].map((x) => Media.fromJson(x))) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'title': title,
      'body': body,
      'header_image': headerImage,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
      'meta_keywords': metaKeywords,
      'reply_count': replyCount,
      'read_count': readCount,
      'bonus_points': bonusPoints,
      'is_active': isActive,
      'is_locked': isLocked,
      'is_pinned': isPinned,
      'is_draft': isDraft,
      'is_markdown': isMarkdown,
      'tags': tags != null ? List<dynamic>.from(tags!.map((x) => x)) : null,
      'iam_account_id': iamAccountId,
      'iam_user_id': iamUserId,
      'common_category_id': commonCategoryId,
      'common_domain_id': commonDomainId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'user': user?.toJson(),
      'media': media != null ? List<dynamic>.from(media!.map((x) => x.toJson())) : null,
    };
  }

  static List<BlogData> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => BlogData.fromJson(json)).toList();
  }
}

class User {
  String? name;
  String? surname;
  String? fullname;
  String? username;
  String? about;
  String? pronoun;
  List<String>? tags;
  String? photoUrl;

  User({
    this.name,
    this.surname,
    this.fullname,
    this.username,
    this.about,
    this.pronoun,
    this.tags,
    this.photoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      surname: json['surname'],
      fullname: json['fullname'],
      username: json['username'],
      about: json['about'],
      pronoun: json['pronoun'],
      tags: json['tags'] != null ? List<String>.from(json['tags'].map((x) => x)) : null,
      photoUrl: json['photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'fullname': fullname,
      'username': username,
      'about': about,
      'pronoun': pronoun,
      'tags': tags != null ? List<dynamic>.from(tags!.map((x) => x)) : null,
      'photo_url': photoUrl,
    };
  }
}

class Media {
  // Define Media fields and methods here
  // Placeholder for Media class based on the data structure of media
  // You can expand this class as per your media object structure

  Media();

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
        // Initialize fields from JSON
        );
  }

  Map<String, dynamic> toJson() {
    return {
      // Convert fields to JSON
    };
  }
}
