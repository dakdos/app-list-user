import 'package:flutter/material.dart';
import '/config/export.dart';

class AppbarWhite extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 70.0;
  final String? title;
  AppbarWhite({
    Key? key, this.title,
  }) : super(key: key);

  @override
  get preferredSize => Size.fromHeight(appBarHeight);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: const Offset(0, 2),
            blurRadius: 6.0,
            spreadRadius: 1,
          )
        ],
        color: Colors.white
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppBar(
            centerTitle: false,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false, 
            elevation: 0,
            title: Text(title!, 
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: HexColor('#EA261D'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}