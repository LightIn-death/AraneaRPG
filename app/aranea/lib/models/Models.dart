class Conv {
  final String id;
  final int winner;
  final int looser;
  final int notreadby;
  final String lastmessage;
  final DateTime lastmessagedate;
  final int score;

  Conv({
    this.id,
    this.winner,
    this.looser,
    this.notreadby,
    this.lastmessage,
    this.lastmessagedate,
    this.score,
  });

  factory Conv.fromJson(Map<String, dynamic> json) {
    return Conv(
      id: json["id"],
      winner: json["winner"],
      looser: json["looser"],
      notreadby: json["notreadby"],
      lastmessage: json["lastmessage"],
      lastmessagedate: json["lastmessagedate"],
      score: json["score"],
    );
  }
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

class Skills {
  final int owner;
  final int strength;
  final int intelligence;
  final int magie;
  final int speed;
  final int charisme;
  final int free;

  Skills(
      {this.owner,
      this.strength,
      this.intelligence,
      this.magie,
      this.speed,
      this.charisme,
      this.free});

  factory Skills.fromJson(Map<String, dynamic> json) {
    return Skills(
      owner: json["owner"],
      strength: json["strenght"],
      intelligence: json["intelligence"],
      magie: json["magie"],
      speed: json["speed"],
      charisme: json["charisme"],
      free: json["free"],
    );
  }
}

class Message {
  final String id;
  final String convId;
  final String content;
  final int owner;
  final String date;
  final String image;

  Message({
    this.id,
    this.convId,
    this.content,
    this.owner,
    this.date,
    this.image,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json["id"],
      convId: json["conv_id"],
      content: json["content"],
      owner: json["owner"],
      date: json["date"],
      image: json["image"],
    );
  }
}

class Object {}
