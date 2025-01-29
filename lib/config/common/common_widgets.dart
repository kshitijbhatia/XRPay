import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension EmptyPadding on num{
  SizedBox get ph => SizedBox(height: toDouble().h,);

  SizedBox pw() => SizedBox(width: toDouble().w,);
}