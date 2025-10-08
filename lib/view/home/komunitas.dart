import 'package:flutter/material.dart';
import 'package:heartsnap/common/color_extension.dart';

class Komunitas extends StatefulWidget {
  const Komunitas({super.key});

  @override
  State<Komunitas> createState() => _KomunitasState();
}

class _KomunitasState extends State<Komunitas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Hello, User!",
          style: TextStyle(
            color: TColor.primaryColor1,
            fontWeight: FontWeight.w700
          ),
        ),
        actions: [
          Padding(padding: EdgeInsetsGeometry.only(right: 16),
          child: Image.asset('assets/img/lonceng.png',
          height: 30,
          ),
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 393,
                height: 456,
                decoration: BoxDecoration(
                  color: Color(0xFFEDE6F0),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/img/Avatar.png'),
                          ),
                          SizedBox(width: 16,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Header", 
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                              ),
                              SizedBox(height: 4,),
                              Text("Subhead", 
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              ),
                            ],
                          ),
                          SizedBox(width: 150,),
                          Image.asset('assets/img/icon1.png'),
                        ],
                      ),
                      Image.asset('assets/img/postkomunitas.png',
                      width: 393,
                      height: 188,),
                      SizedBox(height: 16,),
                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Title',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4,),
                              Text(
                                'Subtitle',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 32,),
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 16,),
                              Image.asset('assets/img/icon2.png')
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 393,
                height: 456,
                decoration: BoxDecoration(
                  color: Color(0xFFEDE6F0),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/img/Avatar.png'),
                          ),
                          SizedBox(width: 16,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Header", 
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                              ),
                              SizedBox(height: 4,),
                              Text("Subhead", 
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              ),
                            ],
                          ),
                          SizedBox(width: 150,),
                          Image.asset('assets/img/icon1.png'),
                        ],
                      ),
                      Image.asset('assets/img/postkomunitas.png',
                      width: 393,
                      height: 188,),
                      SizedBox(height: 16,),
                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Title',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4,),
                              Text(
                                'Subtitle',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 32,),
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 16,),
                              Image.asset('assets/img/icon2.png')
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}