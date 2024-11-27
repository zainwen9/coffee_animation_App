import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/drink.dart';
import '../colors.dart';
import '../drinkCard.dart'; // Ensure this file exists and contains required color definitions.

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late final PageController pageController;
  double pageOffset = 0; // Lowercase 'pageOffset' for consistency.
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutBack,
    );

    pageController = PageController(viewportFraction: .8)
      ..addListener(() {
        setState(() {
          pageOffset = pageController.page ?? 0; // Safely handle null case.
        });
      });
  }

  @override
  void dispose() {
    controller.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            buildAppBar(),
            buildLogo(size),
            buildPager(size),
            buildPagerIndicator(),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          AnimatedBuilder(
            animation: animation,
            builder: (context, snapshot) {
              return Transform.translate(
                offset: Offset(-200 * (1 - animation.value), 0),
                child: Image.asset(
                  'images/location.png',
                  width: 30,
                  height: 30,
                ),
              );
            },
          ),
          const Spacer(),
          AnimatedBuilder(
            animation: animation,
            builder: (context, snapshot) {
              return Transform.translate(
                offset: Offset(200 * (1 - animation.value), 0),
                child: Image.asset(
                  'images/drawer.png',
                  width: 30,
                  height: 30,
                ),
              );
            },
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget buildLogo(Size size) {
    return Positioned(
      top: 10,
      right: size.width / 2 - 25,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, snapshot) {
          return Transform(
            transform: Matrix4.identity()
              ..translate(0.0, size.height / 2 * (1 - animation.value))
              ..scale(1 + (1 - animation.value)),
            origin: const Offset(25, 25),
            child: InkWell(
              onTap: () => controller.isCompleted
                  ? controller.reverse()
                  : controller.forward(),
              child: Image.asset(
                'images/logo.png',
                width: 50,
                height: 50,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildPager(Size size) {
    return Container(
      margin: const EdgeInsets.only(top: 70),
      height: size.height - 50,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, snapshot) {
          return Transform.translate(
            offset: Offset(400 * (1 - animation.value), 0),
            child: PageView.builder(
              itemCount: getDrinks().length,
              controller: pageController,
              itemBuilder: (context, index) =>
                  DrinkCard(getDrinks()[index], pageOffset, index),
            ),
          );
        },
      ),
    );
  }

  List<Drink> getDrinks() {
    return [
      Drink(
        'Tirami',
        'Su',
        'images/TiramisuBg.png',
        'images/beanTop.png',
        'images/beanSmall.png',
        'images/beanBlur.png',
        'images/TriamsuiCup.png',
        'then top with whipped cream and mocha drizzle to bring you endless java joy',
        brownLight,
        brownDark,
      ),
      Drink(
        'Green',
        'Tea',
        'images/GreenTeaBG.png',
        'images/green.png',
        'images/greenSmall.png',
        'images/greenBlur.png',
        'images/greenteaCup.png',
        'milk and ice and top it with sweetened whipped cream to give you a delicious boost of energy.',
        greenLight,
        greenDark,
      ),
      Drink(
        'Triple',
        'Mocha',
        'images/GreenMochabBG.png',
        'images/chocolateTop.png',
        'images/chocolateSmall.png',
        'images/chocolateBlur.png',
        'images/mochaCup.png',
        'layers of whipped cream that’s infused with cold brew, white chocolate mocha and dark caramel',
        brownLight,
        brownDark,
      ),
    ];
  }

  Widget buildPagerIndicator() {
    return Positioned(
      bottom: 10,
      left: 10,
      child: Row(
        children: List.generate(
          getDrinks().length,
              (index) => buildContainer(index),
        ),
      ),
    );
  }

  Widget buildContainer(int index) {
    double animate = (pageOffset - index).abs();
    double size = 10;
    Color color = Colors.grey;

    if (animate < 1) {
      size = 10 + 10 * (1 - animate);
      color = ColorTween(begin: Colors.grey, end: appGreen)
          .transform(1 - animate)!;
    }

    return Container(
      margin: const EdgeInsets.all(4),
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}