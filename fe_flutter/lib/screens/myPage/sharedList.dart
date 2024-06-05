import 'package:flutter/material.dart';
import 'package:fe_flutter/model/shareRefrigeModel.dart';
import 'package:fe_flutter/service/shareRefrigeServer.dart';

class SharedListPage extends StatefulWidget {
  @override
  _SharedListPageState createState() => _SharedListPageState();
}

class _SharedListPageState extends State<SharedListPage> {
  SharedList? sharedList;
  // 임시 데이터
  // SharedList sharedList = SharedList(
  //   pendingRequests: [
  //     SharedData(
  //       shareId: 2,
  //       createUserNickname: "유저1",
  //       requestUserNickname: "유저3",
  //       refrigeName: "기본냉장고1",
  //       status: false,
  //     ),
  //   ],
  //   receivedRequests: [
  //     SharedData(
  //       shareId: 4,
  //       createUserNickname: "유저2",
  //       requestUserNickname: "유저1",
  //       refrigeName: "기본냉장고2",
  //       status: false,
  //     ),
  //   ],
  //   acceptedRequests: [
  //     SharedData(
  //       shareId: 3,
  //       createUserNickname: "유저1",
  //       requestUserNickname: "유저2",
  //       refrigeName: "기본냉장고1",
  //       status: true,
  //     ),
  //   ],
  // );

  // 공유 목록 get
  @override
  void initState() {
    super.initState();
    getSharedList().then((list) {
      setState(() {
        sharedList = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('냉장고 공유하기'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.chevron_left,
              color: Colors.white,
              size: 30,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
            child: sharedList == null
                ? Text('목록이 없습니다.',  // 목록 없을 경우
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(height: 20,),
                      _widgetForSharedId(sharedList!),
                    ],
                  )
        )
    );
  }

  Widget _widgetForSharedId (SharedList sharedList) {
    List<Widget> widgets = [];
    if (sharedList.pendingRequests.isNotEmpty) {
      widgets.add(_pendingRequests(sharedList.pendingRequests.first));
    }
    if (sharedList.receivedRequests.isNotEmpty) {
      widgets.add(_receivedRequests(sharedList.receivedRequests.first));
    }
    if (sharedList.acceptedRequests.isNotEmpty) {
      widgets.add(_acceptedRequests(sharedList.acceptedRequests.first));
    }
    if (widgets.isNotEmpty) {
      return Column(children: widgets);
    } else {
      return Text(
        '목록이 없습니다.',
        style: TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      );
    }
  }

  Widget _pendingRequests(SharedData data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Container(
        width: 343,
        height: 114,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
            color: const Color(0xffF2F4F7),
            borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  children: [
                    TextSpan(text: '${sharedList!.pendingRequests[0].requestUserNickname}',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )
                    ),
                    TextSpan(text: ' 님에게 냉장고 공유 요청을 했습니다.',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )
                    ),
                  ]
              ),
            ),
            Text('요청한 냉장고 : ${sharedList!.pendingRequests[0].refrigeName}',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16,),
            Row(
              children: [
                SizedBox(width: 240,),
                Container(
                  width: 67,
                  height: 25,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xffF6A90A),
                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('취소',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _receivedRequests(SharedData data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Container(
        width: 343,
        height: 114,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
            color: const Color(0xffF2F4F7),
            borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  children: [
                    TextSpan(text: '${sharedList!.receivedRequests[0].requestUserNickname}',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )
                    ),
                    TextSpan(text: ' 님에게 냉장고 공유 요청이 왔습니다.',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )
                    ),
                  ]
              ),
            ),
            Text('요청받은 냉장고 : ${sharedList!.receivedRequests[0].refrigeName}',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16,),
            Row(
              children: [
                SizedBox(width: 160,),
                Container(
                  width: 67,
                  height: 25,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xffF6A90A),
                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('수락',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 13,),
                Container(
                  width: 67,
                  height: 25,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xffF6A90A),
                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('거절',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _acceptedRequests(SharedData data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Container(
        width: 343,
        height: 114,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
            color: const Color(0xffF2F4F7),
            borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  children: [
                    TextSpan(text: '${sharedList!.acceptedRequests[0].requestUserNickname}',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )
                    ),
                    TextSpan(text: ' 님과 냉장고가 공유되었습니다.',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )
                    ),
                  ]
              ),
            ),
            Text('공유된 냉장고 : ${sharedList!.acceptedRequests[0].refrigeName}',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16,),
            Row(
              children: [
                SizedBox(width: 240,),
                Container(
                  width: 67,
                  height: 25,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xffD86715),
                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('공유중',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
