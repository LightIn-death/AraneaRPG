class Conv {
  final int index;
  final String about;
  final String name;
  final String email;
  final String picture;

  Conv(this.index, this.about, this.name, this.email, this.picture);
}

class User {
  final int id;
  final String pseudo;
  final String email;
  final int age;
  final bool sex;
  final String description;
  final String image;
  final String password;
  final int coins;
  final int crystals;
  final String metadescr;
  final String token;

  User(
      {this.id,
      this.pseudo,
      this.email,
      this.age,
      this.sex,
      this.description,
      this.image,
      this.password,
      this.coins,
      this.crystals,
      this.metadescr,
      this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      pseudo: json["pseudo"],
      email: json["email"],
      age: json["age"],
      sex: json["sex"],
      description: json["description"],
      image: json["image"],
      password: json["password"],
      coins: json["coins"],
      crystals: json["crystals"],
      metadescr: json["metadescr"],
      token: json["token"],
    );
  }
}
