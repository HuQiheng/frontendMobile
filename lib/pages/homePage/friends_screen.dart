import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:wealth_wars/methods/friend_manager.dart';
import 'package:wealth_wars/pages/homePage/account_screen.dart';

class FriendsScreen extends StatefulWidget {
  final String email;
  final List<dynamic> myFriends;
  final List<dynamic> myRequests;
  List<dynamic> sendedRequests;

  FriendsScreen(
      {super.key,
      required this.email,
      required this.myFriends,
      required this.myRequests,
      required this.sendedRequests});

  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController friendEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Logger logger = Logger();
    logger.d("Lista de mis amigos: ${widget.myFriends}");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF083344),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Mis amigos', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF083344),
      ),
      body: Container(
        color: const Color(0xFF083344),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: friendEmailController,
                        decoration: InputDecoration(
                          hintText: 'Añadir amigo (Introducir email):',
                          hintStyle: const TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: const Color(0xFF005A88),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.white),
                      onPressed: () async {
                        String friendEmail = friendEmailController.text;
                        if (!await checkFriendship(widget.email, friendEmail)) {
                          if (await makeFriendRequest(
                              widget.email, friendEmail)) {
                            List<dynamic> updatedRequests =
                                await getUserSendedRequests(widget.email);
                            setState(() {
                              widget.sendedRequests = updatedRequests;
                            });

                            Fluttertoast.showToast(
                              msg: "Solicitud de amistad enviada",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: const Color(0xFFEA970A),
                              textColor: Colors.black,
                              fontSize: 16.0,
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: "La solicitud ya fue enviada",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: const Color(0xFFEA970A),
                              textColor: Colors.black,
                              fontSize: 16.0,
                            );
                          }
                        } else {
                          Fluttertoast.showToast(
                            msg: "Ya eres amigo de este usuario",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: const Color(0xFFEA970A),
                            textColor: Colors.black,
                            fontSize: 16.0,
                          );
                        }
                      },
                    ),
                  ],
                ),
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: 'Amigos'),
                    Tab(text: 'Solicitudes Enviadas'),
                    Tab(text: 'Peticiones Recibidas'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildFriendsList(),
                      _buildSentRequests(),
                      _buildReceivedRequests(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFriendsList() {
    return ListView.separated(
      separatorBuilder: (context, index) =>
          const Divider(color: Colors.white24),
      itemCount: widget.myFriends.length,
      itemBuilder: (BuildContext context, int index) {
        var friend = widget.myFriends[index];
        return Card(
          color: const Color(0xffd68a0a),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5.0,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(friend['picture']),
            ),
            title: Text(
              friend['name'],
              style: const TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    username: friend['name'],
                    email: friend['email'],
                    picture: friend['picture'],
                  ),
                ),
              );
            },
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.black),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Eliminar Amistad'),
                      content: Text(
                          '¿Estás seguro de que quieres eliminar a ${friend['username']} de tus amigos?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Eliminar'),
                          onPressed: () {
                            deleteFriend(widget.email, friend['email']);
                            setState(() {
                              widget.myFriends.removeAt(index);
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildSentRequests() {
    return ListView.separated(
      separatorBuilder: (context, index) =>
          const Divider(color: Colors.white24),
      itemCount: widget.sendedRequests.length,
      itemBuilder: (BuildContext context, int index) {
        var friend = widget.sendedRequests[index];
        return Card(
          color: const Color(0xffd68a0a),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5.0,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(friend['picture']),
            ),
            title: Text(
              friend['username'],
              style: const TextStyle(color: Colors.black),
            ),
            onTap: () {
              Fluttertoast.showToast(
                msg: "No puedes ver el perfil de alguien\nque no sea tu amigo",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: const Color(0xFFEA970A),
                textColor: Colors.black,
                fontSize: 16.0,
              );
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    username: friend['username'],
                    email: friend['email'],
                    picture: friend['picture'],
                  ),
                ),
              );*/
            },
            trailing: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle, // Hace que el contenedor sea circular
                color: Color(0xFF0066CC), // Color de fondo del contenedor
              ),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  deleteFriendRequest(widget.email, friend['email']);
                  setState(() {
                    widget.sendedRequests.removeAt(index);
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildReceivedRequests() {
    return ListView.separated(
      separatorBuilder: (context, index) =>
          const Divider(color: Colors.white24),
      itemCount: widget.myRequests.length,
      itemBuilder: (BuildContext context, int index) {
        var friend = widget.myRequests[index];
        return Card(
          color: const Color(0xffd68a0a),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5.0,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(friend['picture']),
            ),
            title: Text(
              friend['name'],
              style: const TextStyle(color: Colors.black),
            ),
            onTap: () {
              Fluttertoast.showToast(
                msg: "No puedes ver el perfil de alguien\nque no sea tu amigo",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: const Color(0xFFEA970A),
                textColor: Colors.black,
                fontSize: 16.0,
              );
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    username: friend['username'],
                    email: friend['email'],
                    picture: friend['picture'],
                  ),
                ),
              );*/
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape:
                        BoxShape.circle, // Hace que el contenedor sea circular
                    color: Color(0xFF0066CC), // Color de fondo del contenedor
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      acceptFriendRequest(widget.email, friend['email']);
                      setState(() {
                        Map<String, dynamic> newUser = {
                          'name': widget.myRequests[index]['name'],
                          'email': widget.myRequests[index]['email'],
                          'picture': widget.myRequests[index]['picture']
                        };
                        widget.myFriends.add(newUser);
                        widget.myRequests.removeAt(index);
                      });
                    },
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape:
                        BoxShape.circle, // Hace que el contenedor sea circular
                    color: Color(0xFF0066CC), // Color de fondo del contenedor
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      deleteFriendRequest(widget.email, friend['email']);
                      setState(() {
                        widget.myRequests.removeAt(index);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
