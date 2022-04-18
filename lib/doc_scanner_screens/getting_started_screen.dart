import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myscan/doc_scanner_utilities/constants.dart';
import 'package:myscan/doc_scanner_utilities/slide.dart';
import 'package:myscan/doc_scanner_widgets/slide_dots.dart';
import 'package:myscan/doc_scanner_widgets/slide_item.dart';
import 'package:myscan/doc_scanner_screens/home_screen.dart';

class GettingStartedScreen extends StatefulWidget {
  static String route = 'GettingStarted';

  GettingStartedScreen({this.showSkip});

  final bool showSkip;

  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  int _currentPage = 0;
  bool isDone = false;

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
      if (index == slideList.length - 1) {
        setState(() {
          isDone = true;
        });
      } else {
        setState(() {
          isDone = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor ,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: (!widget.showSkip)
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                onPressed: () => Navigator.pop(context),
              )
            : Icon(Icons.arrow_back,color: Colors.white,),
        title: Text(
          'How to use the app?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color:Colors.white
          ),
        ),
        actions: (widget.showSkip)
            ? <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.route);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4, 10, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Center(
                          child: Text(
                            (isDone) ? 'Done' : 'Skip',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 17,
                              fontWeight: (isDone)
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        (isDone)
                            ? Container(
                                width: 15,
                              )
                            : Icon(
                                Icons.arrow_forward_ios,
                                size: 17,
                                color: secondaryColor,
                              )
                      ],
                    ),
                  ),
                )
              ]
            : null,
      ),
      body: Container(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Theme(
                      data: Theme.of(context).copyWith(
                        accentColor: primaryColor,
                      ),
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        onPageChanged: _onPageChanged,
                        itemCount: slideList.length,
                        itemBuilder: (ctx, i) {
                          return SlideItem(i);
                        },
                      ),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              displaySlideDots()
                              // for (int i = 0; i < slideList.length; i++)
                              //   {
                              //     (i == _currentPage)
                              //         ? SlideDots(true)
                              //         : SlideDots(false)
                              //   }
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget displaySlideDots() {
    for (int i = 0; i < slideList.length; i++) {
      return (i == _currentPage) ? SlideDots(true) : SlideDots(false);
    }
  }
}
