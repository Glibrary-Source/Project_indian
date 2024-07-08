import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_indian/pages/my_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: ElevatedButton(onPressed: (){

              }, child: Text("방만들기")),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: ElevatedButton(onPressed: (){

              }, child: Text("참가하기")),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: ElevatedButton(onPressed: (){
                Get.to(()=> const MyPage());
              }, child: Text("마이 페이지")),
            )
          ],
        ),
      ),
    );
  }
}
