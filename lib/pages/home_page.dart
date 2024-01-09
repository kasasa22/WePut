import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maker/components/drawer.dart';

import '../components/home/animation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Color(
            0xff1D9AE7,
          ),
        ),
      ),

      //Drawer
      drawer: const MyDrawer(),
      drawerScrimColor: const Color.fromARGB(255, 164, 180, 168),

      //Body of all a white background

      // ignore: sized_box_for_whitespace
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 50,
            ),
            FadeInUp(
                duration: const Duration(milliseconds: 1500),
                child: Image.asset(
                  "/assets/images/drawer.png",
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInUp(
                    delay: const Duration(milliseconds: 1000),
                    duration: const Duration(milliseconds: 1000),
                    child: const Text(
                      "Your dream job is waiting for you!",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 1200),
                    duration: const Duration(milliseconds: 1000),
                    child: Text(
                      "Discover milions of jobs and get in \ntouch with hiring managers.",
                      style: TextStyle(
                          fontSize: 16,
                          height: 1.8,
                          color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
            ),
            FadeInUp(
              delay: const Duration(milliseconds: 1300),
              duration: const Duration(milliseconds: 1000),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/');
                        },
                        color: Colors.black,
                        height: 45,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 4),
                        child: const Center(
                          child: Text(
                            "Get Started",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        )),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: Text("SKIP", style: GoogleFonts.robotoSlab(
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w600,
                    //     height: 1.8,
                    //     color: Colors.black
                    //   ),)
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
