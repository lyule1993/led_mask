import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:awesome_layer_mask/extension/font_extension.dart';
import 'package:awesome_layer_mask/theme&color/common_color_flutter_core.dart';

/// 创建时间：2021/11/25
/// 作者：Bob
/// 描述：通用的输入框控件

class CommonTextFeild extends StatefulWidget {
  CommonTextFeild({
    Key? key,
    this.primaryColor,
    this.backgroundColor,
    required this.labelText,
    this.hintText,
    this.isNecessary = true,
    this.necessaryColor,
    this.enabled,
    this.keyboardType,
    this.controller,
    this.focusNode,
    this.prefix,
    this.suffix,
    this.maxLines = 1,
    this.minLines,
    this.obscureText = false,
    this.validator,
    this.inputFormatters,
    this.textInputAction,
  }) : super(key: key);

  final Color? primaryColor;
  final Color? backgroundColor;
  final String labelText;
  final String? hintText;

  /// 是否为必填项
  final bool isNecessary;
  final Color? necessaryColor;
  bool? enabled;

  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLines;
  final int? minLines;

  /// 是否为密码输入框
  bool obscureText = false;

  /// 输入校验
  FormFieldValidator<String>? validator;

  List<TextInputFormatter>? inputFormatters;

  final TextInputAction? textInputAction;

  @override
  State<CommonTextFeild> createState() => _CommonTextFeildState();
}

enum TextFieldStatus { normal, focus, error }

class _CommonTextFeildState extends State<CommonTextFeild> {
  late FocusNode _focusNode;
  bool _shouldDiposeFocus = false;
  var _status = TextFieldStatus.normal;
  String? _errorInfo;

  @override
  void initState() {
    super.initState();

    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    } else {
      _shouldDiposeFocus = true;
      _focusNode = FocusNode();
    }
    _focusNode.addListener(() {
      setState(() {
        _updateStatus();
      });
    });
  }

  void _updateStatus() {
    if (_errorInfo != null) {
      _status = TextFieldStatus.error;
      return;
    }
    if (_focusNode.hasFocus) {
      _status = TextFieldStatus.focus;
    } else {
      _status = TextFieldStatus.normal;
    }
  }

  @override
  void dispose() {
    if (_shouldDiposeFocus) {
      _focusNode.dispose();
    }

    super.dispose();
  }

  Color? _currentLabelColor(BuildContext context) {
    final Color primaryColor =
        widget.primaryColor ?? Theme.of(context).primaryColor;
    final Color? labelColor = Theme.of(context).textTheme.headline2!.color;

    if (_status == TextFieldStatus.focus) {
      return primaryColor;
    } else if (_status == TextFieldStatus.error) {
      return Theme.of(context).errorColor;
    } else {
      return labelColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color color = widget.primaryColor ?? Theme.of(context).primaryColor;
    final backgroundColor =
        widget.backgroundColor ?? Theme.of(context).backgroundColor;
    final necessaryColor =
        widget.necessaryColor ?? Theme.of(context).errorColor;

    return Container(
      height: 56,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),color: backgroundColor,),
      child: Center(
        child: TextFormField(
          enabled: widget.enabled,
          cursorColor: color,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          focusNode: _focusNode,
          textInputAction: widget.textInputAction,
          // validator: widget.validator,
          // autovalidateMode: AutovalidateMode.disabled,
          inputFormatters: widget.inputFormatters,
          onChanged: (value) {
            _textChanged(value);
          },
          onEditingComplete: () {
            setState(() {
              _updateStatus();
            });
          },
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeightExtension.medium,
            color: Theme.of(context).textTheme.headline1!.color,
          ),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: widget.hintText,
              errorText: _errorInfo,
              isDense: true,
              contentPadding: const EdgeInsets.all(10.0),
              prefixIcon: widget.prefix != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: widget.prefix,
                    )
                  : null,
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
              suffixIcon: widget.suffix,
              hintStyle: TextStyle(
                color: Theme.of(context).textTheme.headline4!.color,
                fontSize: 15,
                fontWeight: FontWeightExtension.light,
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              enabledBorder:  const UnderlineInputBorder(
                borderSide: BorderSide.none,
              )),
        ),
      ),
    );
  }

  void _textChanged(String value) {
    if (widget.validator == null) {
      return;
    }

    String? result = widget.validator!(value);
    setState(() {
      _errorInfo = result;
      _updateStatus();
    });
  }
}
