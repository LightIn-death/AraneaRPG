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

  factory User.setUser(
    int id,
    String token,
    String pseudo,
    String email,
    int age,
    bool sex,
    String image,
    int coins,
    int crystals,
    String description,
    String metadescr,
  ) {
    return User(
      id: id,
      pseudo: pseudo,
      email: email,
      age: age,
      sex: sex,
      description: description,
      image: image,
      password: null,
      coins: coins,
      crystals: crystals,
      metadescr: metadescr,
      token: token,
    );
  }
}

class Skills {}

class Message {}

class Object {}
