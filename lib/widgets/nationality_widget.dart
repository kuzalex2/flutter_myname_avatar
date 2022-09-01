
part of 'widgets.dart';


///
/// Display Name and list of nationality predictions or Progress or Error
///
///


extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
}

extension MaxListLength on List {
  truncate(int end) {
    return sublist(0,min(end, length));
  }
}

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
        Text(nationalizeResponse.data!.name.toCapitalized()),
        ...nationalizeResponse.data!.countries.map((e) => Text('${e.country} ${(e.probability*100).round()} %')).toList().truncate(5)
      ]
    );


  }
}
