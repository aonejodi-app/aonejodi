import 'package:app/Theme/theme-colors.dart';
import 'package:flutter/material.dart';

class MembershipCard extends StatelessWidget {
  final String planName;
  final String price;
  final String contactNum;
  final String validity;
  final bool ifSelected;
  const MembershipCard({super.key, required this.planName, required this.price, required this.contactNum, required this.validity, required this.ifSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      height: 120,
      decoration: BoxDecoration(
        color: pinkColor,
        borderRadius: BorderRadius.circular(15)
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(planName, style: TextStyle(
                fontWeight: FontWeight.w600,
                color: whiteColor,
                fontSize: 21
              ),),
              const Spacer(),
              Text('₹ '+price,
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: whiteColor, fontSize: 21),
              ),
            ],
          ),
          const SizedBox(height: 11,),
          Text('View '+contactNum+' Contact Number', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: whiteColor),
          ),
          const SizedBox(
            height: 6,
          ),
          Text('(Valid for '+validity+ ' months)', style: TextStyle(fontSize: 12, color: whiteColor),
          )
        ],
      ),
    );
  }
}