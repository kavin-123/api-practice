class User {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final Username name;
  User(
      {required this.cell,
      required this.email,
      required this.gender,
      required this.nat,
      required this.phone,
      required this.name});
}

class Username {
  final String title;
  final String first;
  final String last;

  Username({
    required this.title,
    required this.last,
    required this.first,
  });
}
