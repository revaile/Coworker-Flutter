import 'package:cowok/config/enum.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

class GetStartedPages extends StatelessWidget {
  const GetStartedPages({super.key});

  @override
  Widget build(BuildContext context) {

    const getStarted1 =[
      'assets/gstarted1.png',
      'assets/gstarted2.png',
      'assets/gstarted3.png',
    ];
    const getStarted2 =[
      'assets/gstarted4.png',
      'assets/gstarted5.png',
      'assets/gstarted6.png',
    ];
    const getStarted3 =[
      'assets/gstarted7.png',
      'assets/gstarted8.png',
      'assets/gstarted9.png',
    ];
    return Scaffold(
      body: SingleChildScrollView(
        // layar gabisa flex
        physics: const NeverScrollableScrollPhysics(),
        // ini widget otomatis menampilkan paling bawah
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageStarted(getStarted1),
            // ignore: deprecated_member_use
            DView.spaceHeight(20),
            imageStarted(getStarted2),
            // ignore: deprecated_member_use
            DView.spaceHeight(20),  
            imageStarted(getStarted3),
            // ignore: deprecated_member_use
            DView.spaceHeight(23),  
        
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Cari pekerja untuk\npertumbuhan bisnis',
                style:TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700 ,
                  color: Color(0xfff13162f),
                  height: 1.5
                ) ,
              ),
            ),
          // ignore: deprecated_member_use
         DView.spaceHeight(20),  
           const  Padding(
              padding: EdgeInsets.only(left: 20),
              child:  Text(
                'Kami menyediakan berbagai jenis\npekerja siap untuk membantu Anda',
                 style:TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700 ,
                  color: Color(0xffA7A8B3),
                  height: 2
                ) ,
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: FilledButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, AppRoute.signIn.name);
                }, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Explore '),
                    ImageIcon(
                      AssetImage('assets/ic_white_arrow_right.png')
                    )
                  ],
                )
                ),
            )
          ],
        ),
      ),
    );
  }

  Widget imageStarted(List images){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 10 ),
        child: Row(
          children: images.map((e){
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset(
                e, 
                fit: BoxFit.cover,
                height: 190,
                ),
            );
          }).toList(),
        ),
      ),
    );
  }
}