// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, unused_local_variable

import 'dart:async';


import 'package:flutter/material.dart';

//onboarding  model _ data

class Onboard{

  final String image,title,description;
  Onboard({required this.title,required this.description,required this.image});

}


final List<Onboard> datalist=[

Onboard(title:"title1", description: 'description', image: 'android/images/ima1.png'),
Onboard(title:"title2", description: 'description', image: 'android/images/ima1.png'),
Onboard(title:"title3", description: 'description', image: 'android/images/ima3.png'),

];

//onboardingcontent


class Onboardingcontent extends StatelessWidget {
   final  String? image,title,description;

  const Onboardingcontent({super.key,required this.image,
  required this.title,required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Padding(
            padding: const EdgeInsets.all(60.0),
            child: Image.asset(image!,width:200,height: 200,),
          ),
          SizedBox(height: 40,),
        Text(title!,style: TextStyle(color:Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
       ),),
          Text(description!,style: TextStyle(color:Colors.black,
          fontSize: 15,fontWeight: FontWeight.bold),),
        
      ],
    );
  }
}


//dotsindicatorclass 
class Dotsindicators extends StatelessWidget {
  final bool isActive;
  const Dotsindicators({super.key,this.isActive=false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration:Duration(milliseconds: 300),

    height: 8,
    width: isActive?24:8,
    decoration: BoxDecoration(
      border: isActive?null:Border.all(color: Colors.grey),
      borderRadius: BorderRadius.all(Radius.circular(12)),
      color: isActive?Color.fromARGB(255, 12, 26, 150):Colors.grey

    ),
    );
  }
}


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _pageIndex = 0;
  late PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_pageIndex < 3) {
        _pageIndex++;
      } else {
        _pageIndex = 0;
      }
      _pageController.animateToPage(
        _pageIndex,
        duration: Duration(seconds: 1),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    Color customColor1 = Color(0xFFCFBABA);
   Color customColor2 = Color.fromARGB(255, 37, 16, 176);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: datalist.length,
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                controller: _pageController,
                itemBuilder: (context, index) {
                  return Onboardingcontent(
                    image: datalist[index].image,
                    title: datalist[index].title,
                    description: datalist[index].description,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 180),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    datalist.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Dotsindicators(
                        isActive: index == _pageIndex,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _pageIndex == datalist.length - 1
                  ? ElevatedButton(
                       onPressed: () {
    // Navigate to ConfirmationPage when Sign Up button is pressed
   // Navigator.push(
     // context,
      //MaterialPageRoute(builder: (context) =>SignUpPage()),
   // );
  },
                      style: ElevatedButton.styleFrom(
                        primary: customColor2,
                        onPrimary: Colors.white,
                      ),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Action to perform when "Skip" is clicked
                            print('Skip clicked');
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: customColor1,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              if (_pageIndex < datalist.length) {
                                _pageIndex++;
                                _pageController.animateToPage(
                                  _pageIndex,
                                  duration: Duration(milliseconds: 350),
                                  curve: Curves.easeIn,
                                );
                              } else {
                                print('Last page reached');
                              }
                            });
                          },
                          color: customColor2,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0), // Adjust the value according to your preference
  ),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
