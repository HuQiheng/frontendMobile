import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wealth_wars/methods/friend_manager.dart';
import 'package:wealth_wars/pages/homePage/account_screen.dart';

class FriendsScreen extends StatefulWidget {
  final String email;
  final List<dynamic> myFriends;
  final List<dynamic> myRequests;
  final List<dynamic> sendedRequests;

  const FriendsScreen(
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
        title: const Text('Mis amigos:', style: TextStyle(color: Colors.white)),
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
                      onPressed: () {
                        String friendEmail = friendEmailController.text;
                        makeFriendRequest(widget.email, friendEmail);
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
              friend['username'],
              style: const TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    username: friend['username'],
                    email: friend['friend_email'],
                    picture: friend['picture'],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSentRequests() {
    // Implementación específica para la lista de solicitudes enviadas
    return const Center(child: Text("Solicitudes Enviadas"));
  }

  Widget _buildReceivedRequests() {
    // Implementación específica para la lista de peticiones recibidas
    return const Center(child: Text("Peticiones Recibidas"));
  }
}
