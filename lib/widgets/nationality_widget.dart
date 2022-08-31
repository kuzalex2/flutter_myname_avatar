
part of 'widgets.dart';




class NationalityWidget extends StatelessWidget {
  final AsyncSnapshot<NationalizeResponse> nationalizeResponse;
  const NationalityWidget({Key? key, required this.nationalizeResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (nationalizeResponse.hasError) {
      return const Icon(Icons.error);
    }

    if (nationalizeResponse.data==null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
      Text(nationalizeResponse.data!.name),
      ...nationalizeResponse.data!.countries.map((e) => Text('${e.country} ${(e.probability*100).round()} %')).toList()
    ]);


  }
}
