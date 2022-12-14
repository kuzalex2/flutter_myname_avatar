
part of 'widgets.dart';

class Loader extends StatelessWidget {

  final double radius;
  final Brightness brightness;

  const Loader({Key? key, this.radius = mediumRadius, this.brightness = Brightness.light}) : super(key: key);

  static const double smallRadius = 10.0;
  static const double mediumRadius = 14.0;
  static const double largeRadius = 18.0;

  @override
  Widget build(BuildContext context) {
    return Center(child: CupertinoActivityIndicator(radius: radius,),);
  }
}


