import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late User _currentUser;
  late DocumentSnapshot<Map<String, dynamic>> _userProfile;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser!;
    _getUserProfile();
  }

  Future<void> _getUserProfile() async {
    final userProfile = await FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser.uid)
        .get();

    setState(() {
      _userProfile = userProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      // ignore: unnecessary_null_comparison
      body: _userProfile != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Name: ${_userProfile['name']}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Email: ${_userProfile['email']}',
                    style: TextStyle(fontSize: 20),
                  ),
                  // Diğer kullanıcı bilgileri buraya eklenebilir.
                ],
              ),
            )
          : CircularProgressIndicator(),
    );
  }
}
