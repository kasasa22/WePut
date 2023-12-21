class User{
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  User({
    required this.id,
    required this.name,  
    required this.imageUrl,
    required this.isOnline,
  });
}
//curent user
final User currentUser =User(
  id: 0,
  name: 'Kasasa Trevor',
  imageUrl:'assets/images/wallace.jpg',
  isOnline: true,
);

//users
final User wallace =User(
  id: 1,
  name: 'Wallace',
  imageUrl:'assets/images/wallace.jpg',
  isOnline: true,
);

final User conrad =User(
  id: 2,
  name: 'conrad',
  imageUrl:'assets/images/jk.jpg',
  isOnline: true,
);

final User nzaala =User(
  id: 2,
  name: 'nzaala',
  imageUrl:'assets/images/sakwa.jpg',
  isOnline: true,
);

final User john =User(
  id: 3,
  name: 'John',
  imageUrl:'assets/images/g.jpg',
  isOnline: true,
);

final User alvin =User(
  id: 0,
  name: 'Alvin',
  imageUrl:'assets/images/alvin.jpg',
  isOnline: false,
);
