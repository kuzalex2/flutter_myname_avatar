
part of 'widgets.dart';


///
/// Display Single Search Result
///
///


class SearchResultWidget extends StatelessWidget {
  ///
  final AsyncSnapshot<String> dogUrl;

  ///
  final AsyncSnapshot<NationalizeResponse> nationalizeResponse;


  const SearchResultWidget({Key? key, required this.dogUrl, required this.nationalizeResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16),),

        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      child:Row(
        children: [
          const SizedBox(width: 10,),

          DogImageWidget(url: dogUrl, size: 150,),

          const SizedBox(width: 10,),

          Expanded(child: NationalityWidget(nationalizeResponse: nationalizeResponse)),

          const SizedBox(width: 10,),

        ],
      ),
    );
  }
}
