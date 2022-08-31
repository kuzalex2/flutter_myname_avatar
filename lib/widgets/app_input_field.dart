
part of 'widgets.dart';


class AppInputField extends StatelessWidget {

  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final String? hintText;
  final String? errorText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? prefixText;
  final TextStyle? style;
  final bool autofocus;
  final bool obscureText;
  final VoidCallback? onSuffixIconTap;
  final String? initialValue;
  final bool readOnly;
  final TextAlign? textAlign;
  final TextCapitalization textCapitalization;

  const AppInputField({
    Key? key,
    this.onChanged,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines = 1,
    this.focusNode,
    this.hintText,
    this.errorText,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixText,
    this.style,
    this.textAlign,
    this.autofocus = false,
    this.obscureText = false,
    this.onSuffixIconTap,
    this.onEditingComplete,
    this.initialValue,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return
      Stack(
        alignment: Alignment.center,
        children: [
          TextFormField(
            textAlign: textAlign ?? TextAlign.start,
            style: style,
            maxLines: maxLines,
            minLines: minLines,
            readOnly: readOnly,
            initialValue: initialValue,
            textCapitalization: textCapitalization,
            onEditingComplete: onEditingComplete,
            // keyboardAppearance: Brightness.light,
            onChanged: onChanged,
            keyboardType: keyboardType,
            focusNode: focusNode,
            autofocus: autofocus,
            obscureText: obscureText,
            decoration: InputDecoration(
              suffixIconConstraints: const BoxConstraints(
                  minHeight: 24,
                  minWidth: 24
              ),
              suffixIcon: suffixIcon == null ? null : GestureDetector(
                onTap: onSuffixIconTap,
                child: suffixIcon,
              ),
              prefixIcon: prefixIcon,
              prefixText: prefixText,
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color : Colors.black45,
                ),
              ),
              hintText: hintText,
              errorText: errorText,
            ),
          ),
          // Visibility(
          //   visible: suffixIcon != null,
          //   child: Positioned(
          //     top: 16,
          //     right: 0,
          //     child: GestureDetector(
          //       onTap: onSuffixIconTap,
          //       child: suffixIcon,
          //     ),
          //   ),
          // )
        ],
      );
  }
}


// class AppInputFieldPassword extends StatefulWidget {
//
//   final ValueChanged<String>? onChanged;
//   final VoidCallback? onEditingComplete;
//   final FocusNode? focusNode;
//   final String? hintText;
//   final String? errorText;
//   final bool autofocus;
//   final bool readOnly;
//
//
//   const AppInputFieldPassword({
//     Key? key,
//     this.onChanged,
//     this.focusNode,
//     this.hintText,
//     this.errorText,
//     this.autofocus = false,
//     this.onEditingComplete,
//     this.readOnly = false,
//   }) : super(key: key);
//
//   @override
//   _AppInputFieldPasswordState createState() => _AppInputFieldPasswordState();
// }

// class _AppInputFieldPasswordState extends State<AppInputFieldPassword> {
//   bool _obscureText = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppInputField(
//         onChanged: widget.onChanged,
//         onEditingComplete: widget.onEditingComplete,
//         focusNode: widget.focusNode,
//         hintText: widget.hintText,
//         errorText: widget.errorText,
//         autofocus: widget.autofocus,
//         obscureText: this._obscureText,
//         readOnly: widget.readOnly,
//
//         suffixIcon: this._obscureText ? Icon(UniconsLine.eye, color: Theme.of(context).colors.black,) : Icon(UniconsLine.eye_slash, color: Theme.of(context).colors.black,),
//
//         onSuffixIconTap: () {
//           setState(() {
//             _obscureText = !_obscureText;
//           });
//         },
//     );
//   }
// }

