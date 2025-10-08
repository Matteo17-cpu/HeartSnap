import 'package:flutter/material.dart';

class HasilScan extends StatefulWidget {
  const HasilScan({super.key});

  @override
  State<HasilScan> createState() => _HasilScanState();
}

class _HasilScanState extends State<HasilScan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 380,
              decoration: BoxDecoration(
                color: Color(0xFF113047),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentGeometry.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, left: 16),
                      child: Row(
                        children: [
                          Image.asset('assets/img/tombolback.png', width: 20, height: 20,),
                          SizedBox(width: 12,),
                          Text(
                          "Hasil Scan", style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFFBF0D8),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      width: 361,
                      decoration: BoxDecoration(
                        color: Color(0xFF113047),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFFFBF0D8), 
                        width: 2
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 12),
                            child: Text(
                              "Ringkasan", style: TextStyle(
                                color: Color(0xFFFBF0D8),
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 4),
                            child: Row(
                              children: [
                                Text(
                                  "Kerusakan Jantung", style: TextStyle(
                                    color: Color(0xFFFBF0D8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(width: 12,),
                                Text("20%", style: TextStyle(
                                    color: Color(0xFFFBF0D8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                  ),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 4),
                            child: Row(
                              children: [
                                Text(
                                  "Stress", style: TextStyle(
                                    color: Color(0xFFFBF0D8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(width: 89,),
                                Text("20%", style: TextStyle(
                                    color: Color(0xFFFBF0D8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                  ),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 4),
                            child: Row(
                              children: [
                                Text(
                                  "Butuh Istirahat", style: TextStyle(
                                    color: Color(0xFFFBF0D8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(width: 12,),
                                Text("2 - 4 Jam", style: TextStyle(
                                    color: Color(0xFFFBF0D8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                  ),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
                            child: Text(
                              "Lorem ipsum dolor sit amet consectetur. Nullam aliquam risus nam cursus. Adipiscing posuere amet dignissim tristique. Massa eget tempor hac eget adipiscing aliquam. Gravida enim leo felis ante aliquam lacinia sapien. Bibendum tincidunt dapibus at a ultricies sed. Nulla curabitur duis imperdiet libero hac phasellus rhoncus.", style: TextStyle(
                                    color: Color(0xFFFBF0D8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                  ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
                            child: Text(
                              "Fames mollis non ornare id posuere tempus donec. Amet neque bibendum elit condimentum tellus est. Ipsum scelerisque id commodo sed. Donec egestas facilisis ultricies est felis. Consequat eget neque sapien egestas pellentesque arcu. Scelerisque enim amet nibh senectus.", style: TextStyle(
                                    color: Color(0xFFFBF0D8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16),
                      child: Text("2025-06-23 12:35", style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                      ),),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 12,),
            Container(
              width: 361,
              decoration: BoxDecoration(
                color: Color(0xFFFBF0D8),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
              children: [
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 20, bottom: 12),
                    child: Text(
                      "Saran Ekslusif", style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 5,
                                  height: 30,
                                  color: Color(0xFF00AD06),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Lorem Ipsum",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:Color(0xFF00AD06)
                                  ),
                                ),
                              ],
                            ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and  typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", style: TextStyle(
                      fontSize: 12,
                      color: Colors.black
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 5,
                                  height: 30,
                                  color: Color(0xFF00AD06),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Lorem Ipsum",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:Color(0xFF00AD06)
                                  ),
                                ),
                              ],
                            ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and  typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", style: TextStyle(
                      fontSize: 12,
                      color: Colors.black
                    ),
                  ),
                ),
              ],
            ),
            ),
            SizedBox(height: 12,),
            Container(
              width: 361,
              decoration: BoxDecoration(
                color: Color(0xFFFBF0D8),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
              children: [
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 20, bottom: 12),
                    child: Text(
                      "Cara Penanganan", style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 5,
                                  height: 30,
                                  color: Color(0xFF00AD06),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Lorem Ipsum",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:Color(0xFF00AD06)
                                  ),
                                ),
                              ],
                            ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and  typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", style: TextStyle(
                      fontSize: 12,
                      color: Colors.black
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 5,
                                  height: 30,
                                  color: Color(0xFF00AD06),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Lorem Ipsum",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:Color(0xFF00AD06)
                                  ),
                                ),
                              ],
                            ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and  typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", style: TextStyle(
                      fontSize: 12,
                      color: Colors.black
                    ),
                  ),
                ),
              ],
            ),
            ),
          ],
        ),
      ),
      ),
      bottomNavigationBar: 
      Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
        child: Container(
          width: 361,
          height: 52,
          decoration: BoxDecoration(
            color: Color(0xFF113047),
            borderRadius: BorderRadius.circular(8)
          ),
          child: Center(
            child: Text(
              "Simpan", style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}