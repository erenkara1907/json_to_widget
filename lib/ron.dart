import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ron{
  void call(var func_, args)
  {
    switch(func_)
    {
      case 'deneme1':
        return deneme1();
      case 'deneme2':
        return deneme2();
      case 'check':
        return check(args);
    }
  }

  void deneme1()
  {
    print('Selamlar');
  }

  void deneme2()
  {
    print('Selamlar 2');
  }

  void check(args)
  {
    if(args['args']['email'] == 'mehmet@ron.digital' && args['args']['password'] == 123456){
      print(args['result']['scene']);
    }else{
      print('Giriş Hatalı');
    }

  }
}