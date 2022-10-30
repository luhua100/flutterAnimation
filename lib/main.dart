import 'package:flutter/material.dart';

void main() {
  runApp(const AnimationApp());
}
class AnimationApp extends StatefulWidget {
  const AnimationApp({Key? key}) : super(key: key);

  @override
  State<AnimationApp> createState() => _AnimationAppState();
}

class _AnimationAppState extends State<AnimationApp>  with SingleTickerProviderStateMixin {


  AnimationController? animationController;
  Animation<int>? fontAnimation;
  Animation<double>? animation2;

  ///遮照动画
  Animation<double>? transitionAnimation;
  Animation<BorderRadius?>? borderAnimation;

  ///页面的跳转 Hero动画 切换 应用场景 页面的切换动画


  double height = 100;


  @override
  void initState() {
    initFontAnimation();
    initCurveAnimation();
    initBorderAnimation();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    // return MaterialApp(
    //   home: Scaffold(
    //     body: GestureDetector(
    //       onTap: (){
    //         Navigator.push(context, MaterialPageRoute(builder: (_){
    //           return HeroAnimationPage();
    //         }));
    //       },
    //       child: Hero(
    //         tag: '第一张图片',
    //         child: Image.network('https://img1.baidu.com/it/u=1362715596,3738883027&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500'),
    //       ),
    //     ),
    //   ),
    // );

    // return MaterialApp(
    //   home: Scaffold(
    //     appBar: AppBar(title: Text('自带动画组件'),),
    //     body: AnimatedContainer(
    //       duration: Duration(seconds: 2),
    //       curve: Curves.fastOutSlowIn,
    //       child: GestureDetector(
    //         onTap: (){
    //           height = 320;
    //           setState(() {});
    //         },
    //         child: Center(
    //           child: Container(
    //             width: 40,
    //             height: height - 30 ,
    //             decoration: BoxDecoration(color: Colors.red),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );


    return AnimatedBuilder(
        animation: animationController!,
        builder: (context, builder) {
          return Scaffold(
            body: Center(
              child: Stack(
                children: [
                  Center(
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.black12,
                        ),
                      )),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: transitionAnimation!.value,
                      height: transitionAnimation!.value,
                      decoration: BoxDecoration(
                        borderRadius: borderAnimation!.value,
                        color: Colors.brown,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });

    // return MaterialApp(
    //    home: Scaffold(
    //      appBar: AppBar(title: Text('动画导航栏')
    //      ),
    //      body: AnimatedBuilder(
    //        animation: animationController!,
    //        builder: (context,child){
    //          return Transform(transform: Matrix4.translationValues(
    //              animation2!.value * (MediaQuery.of(context).size.width),
    //              0.0,
    //              0.0),
    //            child: Center(
    //              child: Container(
    //                width: 120,
    //                height: 120,
    //                decoration: BoxDecoration(color: Colors.red),
    //              ),
    //            ),
    //          );
    //        },
    //      )
    //      // ListView(
    //      //   children: [
    //      //     FontAnimation()
    //      //   ],
    //      // )
    //    ),
    // );
  }


  ///遮照动画初始化
  void initBorderAnimation() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    transitionAnimation = Tween(begin: 50.0, end: 260.0).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.ease));
    borderAnimation = BorderRadiusTween(
        begin: BorderRadius.circular(10), end: BorderRadius.circular(0))
        .animate(
        CurvedAnimation(parent: animationController!, curve: Curves.ease));
    animationController!.forward();
  }

  ///非线性动画初始化
  void initCurveAnimation() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation2 = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController!, curve: Curves.fastOutSlowIn));
    animation2!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation2!.removeStatusListener((status) {});
        ///移除动画
        animationController!.reset();
        ///动画重置
        animation2 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController!, curve: Curves.fastOutSlowIn));
        animation2!.addStatusListener((status) {});
        animationController!.forward();
      }
    });
    animationController!.forward();
  }

  ///动画类的初始化
  void initFontAnimation() {
    ///设置AnimationController 控制类
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));

    ///设置非线性内容
    CurvedAnimation curvedAnimation =
    CurvedAnimation(parent: animationController!, curve: Curves.easeIn);

    ///设置估值
    fontAnimation = Tween(begin: 0, end: 20).animate(animationController!);
    //IntTween(begin: 0,end: 20).animate(animationController!);
    fontAnimation!.addListener(() {
      print('animationValue  ${fontAnimation!.value}');
      setState(() {});
    });
    fontAnimation!.addStatusListener((status) {
      // if (status == AnimationStatus.completed){ }
      print('addStatusListener  ${status}');
    });

    ///执行操作
    animationController!.forward(from: 0);
  }

  ///字体方法的动画
  Widget FontAnimation() {
    return Container(
      child: Text('字体当大图画',
          style: TextStyle(
              color: Colors.red, fontSize: fontAnimation?.value.toDouble())),
    );
  }
}



