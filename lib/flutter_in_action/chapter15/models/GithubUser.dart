class GithubUser {
  GithubUser({
      this.login, 
      this.avatarUrl, 
      this.type, 
      this.name, 
      this.company, 
      this.blog, 
      this.location, 
      this.email, 
      this.hireable, 
      this.bio, 
      this.publicRepos, 
      this.followers, 
      this.following, 
      this.createdAt, 
      this.updatedAt, 
      this.totalPrivateRepos, 
      this.ownedPrivateRepos,});

  GithubUser.fromJson(dynamic json) {
    login = json['login'];
    avatarUrl = json['avatar_url'];
    type = json['type'];
    name = json['name?'];
    company = json['company?'];
    blog = json['blog?'];
    location = json['location?'];
    email = json['email?'];
    hireable = json['hireable?'];
    bio = json['bio?'];
    publicRepos = json['public_repos'];
    followers = json['followers'];
    following = json['following'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalPrivateRepos = json['total_private_repos'];
    ownedPrivateRepos = json['owned_private_repos'];
  }
  String login;
  String avatarUrl;
  String type;
  String name;
  String company;
  String blog;
  String location;
  String email;
  bool hireable;
  String bio;
  int publicRepos;
  int followers;
  int following;
  String createdAt;
  String updatedAt;
  int totalPrivateRepos;
  int ownedPrivateRepos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['login'] = login;
    map['avatar_url'] = avatarUrl;
    map['type'] = type;
    map['name?'] = name;
    map['company?'] = company;
    map['blog?'] = blog;
    map['location?'] = location;
    map['email?'] = email;
    map['hireable?'] = hireable;
    map['bio?'] = bio;
    map['public_repos'] = publicRepos;
    map['followers'] = followers;
    map['following'] = following;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['total_private_repos'] = totalPrivateRepos;
    map['owned_private_repos'] = ownedPrivateRepos;
    return map;
  }

}