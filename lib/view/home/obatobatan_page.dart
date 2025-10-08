import 'package:flutter/material.dart';
import 'package:heartsnap/common/color_extension.dart';

class ObatobatanPage extends StatelessWidget {
  const ObatobatanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Obat",
          style: TextStyle(
            color: TColor.primaryColor1,
            fontWeight: FontWeight.w700,
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
              padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
              child: Container(
                width: 360,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 2
                  )
                ),
                child: 
                Row(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: 
                    Image.asset('assets/img/icon_search.png')
                    ),
                    SizedBox(width: 8,),
                    Text('Cari Obat', style: TextStyle(
                      color: Colors.grey
                    ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        width: 171,
                        height: 245,
                        decoration: BoxDecoration(
                          color: Color(0xFFFBF0D8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Column(
                            children: [
                              Align(
                                alignment: AlignmentGeometry.topCenter,
                                child: Image.asset('assets/img/cardioaspirin.png')
                                ),
                                Text("Cardio Aspirin", style: TextStyle(
                                  color: Color(0xFF113047),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),
                                ),
                                Text("Rp. 35.000", style: TextStyle(
                                color: Color(0xFF113047),
                                fontSize: 10
                                ),
                                ),
                                SizedBox(height: 12,),
                                Container(
                                  width: 148,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF113047),
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Center(
                                    child: Text("Beli", style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                    ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        width: 171,
                        height: 245,
                        decoration: BoxDecoration(
                          color: Color(0xFFFBF0D8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Column(
                            children: [
                              Align(
                                alignment: AlignmentGeometry.topCenter,
                                child: Image.asset('assets/img/cardioaspirin.png')
                                ),
                                Text("Cardio Aspirin", style: TextStyle(
                                  color: Color(0xFF113047),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),
                                ),
                                Text("Rp. 35.000", style: TextStyle(
                                color: Color(0xFF113047),
                                fontSize: 10
                                ),
                                ),
                                SizedBox(height: 12,),
                                Container(
                                  width: 148,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF113047),
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Center(
                                    child: Text("Beli", style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                    ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                
              ],
            ),
          ]
        )
      )
    );
  }
}