import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

var maskFormatterNumberPhone = MaskTextInputFormatter(
  mask: '(##) # ####-####', 
  filter: { "#": RegExp(r'[0-9]') },
  type: MaskAutoCompletionType.lazy
);
var maskFormatterCPF = MaskTextInputFormatter(
  mask: '###.###.###-##', 
  filter: { "#": RegExp(r'[0-9]') },
  type: MaskAutoCompletionType.lazy
);
var maskFormatterDate = MaskTextInputFormatter(
  mask: '##/##/####', 
  filter: { "#": RegExp(r'[0-9]') },
  type: MaskAutoCompletionType.lazy
);

var maskFormatterBRL = MaskTextInputFormatter(
  mask: 'R\$#.###.###.###,##',
  filter: { "#": RegExp(r'[0-9]') },
  type: MaskAutoCompletionType.lazy
);
