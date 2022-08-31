
part of 'widgets.dart';


///
/// Display Dog image or Progress or Error
///
///

class DogImageWidget extends StatelessWidget {

  final AsyncSnapshot<String> url;
  final double size;

  const DogImageWidget({Key? key, required this.url, this.size = 100}) : super(key: key);


  Widget _child() {
    if (url.hasError){
      return const Icon(Icons.error);
    }
    if (url.hasData){
      return CachedNetworkImage(
        imageUrl: url.data!,
        // imageUrl:     'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Macaca_nigra_self-portrait_large.jpg/1024px-Macaca_nigra_self-portrait_large.jpg?v=1',

        imageBuilder: (context, imageProvider) =>  CircleAvatar(backgroundImage: imageProvider, backgroundColor: Colors.transparent,),
        placeholder: (context, url) => const Loader(radius: Loader.largeRadius,),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );

    }

    return const Loader(radius: Loader.largeRadius,);
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
        width: size,
        height: size,
        child: _child(),
    );

  }
}


