class UserModel {
  String? name;
  String? email;
  String? password;
  String? $id;
  String? $createdAt;
  String? $updatedAt;

  UserModel({
    this.name,
    this.email,
    this.password,
    this.$id,
    this.$createdAt,
    this.$updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        $id: json["\$id"],
        $createdAt: json["\$createdAt"],
        $updatedAt: json["\$updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "\$id": $id,
        "\$createdAt": $createdAt,
        "\$updatedAt": $updatedAt,
      };
}
