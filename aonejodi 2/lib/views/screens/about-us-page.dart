import 'package:app/Theme/theme-colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  List<ImageWedding> weddingServiceList = [
    ImageWedding(
        imagePath: 'images/about-us-page-images/wed1.png',
        imageDesc: 'Theme Decoration'),
    ImageWedding(
        imagePath: 'images/about-us-page-images/wed2.png',
        imageDesc: 'Catering Services'),
    ImageWedding(
        imagePath: 'images/about-us-page-images/wed3.png',
        imageDesc: 'Wedding Planning')
  ];

  final String _services =
      'Wedding Concept & Design(ThemeDecoration) \n Venue Selection \nCatering and Menu Selection \nMusic and Entertainment \nOfficiate \nStaging and Audio/Visual \nLighting Design\nInvitations & Guest Management \nComprehensive, detailed ‘Wedding Day Itinerary’ \n Wedding Invitation & Stationary \nReception Management \nTrousseau & Personal Shopping \nAccommodations Search & Selection \nTransportation \nContract Review & Negotiation \nRehearsal Coordination \nEvent Timeline \nBudgeting \nPhotography/Videography \nWedding Cinematography * \nDelivery and set-up of all wedding day items \nFollow up with Vendors \nPersonalized Attention to your wedding shopping (wedding trousseau)';

  final String _description =
      'appJodi Matrimony is emerging as the fastest Growing Matrimony App For Indians Worldwide.It is an online matrimony.It has advanced features that enables you to find your match faster. With the help of large advertisements 10 lakh profiles are expected to be uploaded in the next 6 months. Be assured that your data is 100% secure with appJodi matrimony. No need to buy Expensive Packages. Our Packages are Pocket friendly.\n \n Unlike other Matrimonys you will not Receive unwanted calls from our customer care.Our Customer Care service is always there to help you. And for any kind of information and assistance we are always there. appJodi Matrimony is for Indian based community settled in India And Abroad. This is the fastest growing matrimonial App in India. Because of the advanced features, Affordable Price Friendly Customer Care Service And Large Advertisement Makes appJodi Standout Among other matrimonial Apps. This App has lots of profiles for people who are single and for those who are seeking remarriage. You will find Profiles with fully updated Details.FOUNDER OF appJodi MATRIMONY IS HARMEET KHANNA';

  AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'About us',
          style: TextStyle(
            color: pinkColor,
            fontSize: 22,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Container(
                width: double.infinity,
                color: pinkColor,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'About appJodi Matrimony',
                          style: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 22.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      _description,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15.0),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Wedding Planner Services',
                  style: TextStyle(
                    color: pinkColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'As your partner in planning, we will recruit the ideal team of vendors, provide you with expert advice, imaginative ideas and orchestrate all the logistical details.',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 150.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: weddingServiceList.length, // Number of images
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Container(
                            width: 150.0,
                            height: 85.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              image: DecorationImage(
                                image: AssetImage(
                                    weddingServiceList[index].imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              weddingServiceList[index].imageDesc,
                              style: const TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Text(
                      'This package is for couples who would like professional guidance and a stress-free experience throughout the entire wedding planning process. The Bride and Groom retain all creative freedom and make all the final decisions. Our wedding consultants simply assist with the co-ordination and planning of the wedding you desire. With full planning, we will be there from your first vendor selection to when the last guest departs, to make sure it’s the day you have dreamed about. \n\nAs your partner in planning, we will recruit the ideal team of vendors, provide you with expert advice, imaginative ideas and orchestrate all the logistical details. \n\nYou get to enjoy all the fun aspects of planning your wedding, while avoiding the stress and anxiety of the behind-the-scenes work.',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      _services,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              // Here we instantiate CallWidget properly
              CallWidget(), // Now CallWidget is instantiated correctly.
              const SizedBox(
                height: 2,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Copyright © 2024. All rights reserved.',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageWedding {
  final String imagePath;
  final String imageDesc;

  ImageWedding({required this.imagePath, required this.imageDesc});
}

class CallWidget extends StatelessWidget {
  final String phoneNumber = '+919876543210'; // Replace with the actual number

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
        if (await canLaunchUrl(callUri)) {
          await launchUrl(callUri);
        } else {
          // Handle error if unable to launch the call
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Cannot make the call")),
          );
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Call '+phoneNumber,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 109, 77, 77),
            ),
          ),
        ],
      ),
    );
  }
}
