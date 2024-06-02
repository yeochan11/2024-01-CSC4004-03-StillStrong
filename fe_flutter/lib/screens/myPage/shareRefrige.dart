import 'package:flutter/material.dart';
import 'package:fe_flutter/service/shareRefrigeServer.dart';

class ShareRefrigePage extends StatefulWidget {
  @override
  _ShareRefrigePageState createState() => _ShareRefrigePageState();
}

class _ShareRefrigePageState extends State<ShareRefrigePage> {
  final _formKey = GlobalKey<FormState>();
  final _serchUserController = TextEditingController();
  String? _searchUserImage;
  List<String>? _refrigeNames;
  List<int>? _refrigeIds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('냉장고 공유하기')
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: _serchUserController,
              decoration: InputDecoration(
                labelText: '닉네임 검색',
              ),
            ),
            SizedBox(height: 10,),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  searchUser(_serchUserController.text);
                  setState(() {
                  });
                }
              },
              child: Text('사용자 검색'),
            )
          ],
        ),
      ),
    );
  }
}
