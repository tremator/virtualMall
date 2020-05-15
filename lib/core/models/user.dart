class User {
  final String id;
  final String name;
  final String email;
  final bool isLogged;

  const User({this.id, this.name, this.email, this.isLogged});

  const User.initial()
      : id = null,
        name = '',
        email = '',
        isLogged = false;
}