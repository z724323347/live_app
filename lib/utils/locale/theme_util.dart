import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:liveapp/configs/public.dart';

// class T with Store {
//  ThemeData systemTheme = ThemeUtil.themeData;
// }

class ThemeUtil {
  static BuildContext context =
      GlobalNavigator.navigatorKey.currentState.overlay.context;

  /// accentColor  -- 当前主题色 (包括 appbar底色，选中背景色，公告背景)
  ///
  /// primaryColor -- 次级高亮色 (包括 app默认字体色，底部bott选中色，客服图标，二级分类字色，视频图标色，收藏选中)
  ///
  /// focusColor   -- 特殊  (包括大分类字体色)
  static ThemeData themeData = Theme.of(context);

  /// 初始化 theme
  initTheme() {
    int index = StorageManager.pref.getInt('kThemeColorIndex');
    bool isDark = StorageManager.pref.getBool('kThemeUserDarkMode') ?? false;
    // int index = await themeStorage.get();
    if (isDark == null) {
      isDark = false;
    }
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;
    if (index != null) {
      themeData = ThemeData(
        // /// 当前主题色 (包括 appbar底色，选中背景色，公告背景)
        // accentColor: themeColors[index].themeColor,

        // /// 次级高亮色 (包括 app默认字体色，底部bott选中色，客服图标，二级分类字色，视频图标色，收藏选中)
        // primaryColor: themeColors[index].primaryColor,

        // /// 特殊  (包括大分类字体色)
        // focusColor: themeColors[index].focusColor,

        // /// 其他颜色——1 (彩票开奖号码球背景色)
        // hoverColor: themeColors[index].hoverColor,

        // /// 设置对应主要的appbar样式
        // appBarTheme: AppBarTheme(
        //     color: themeColors[index].themeColor, brightness: brightness),

        // /// 当前主题背景颜色
        // // backgroundColor: themeColors[index].backgroundColor,
      );
    } else {
      themeData = ThemeData(
        // accentColor: themeColors[0].themeColor,
        // primaryColor: themeColors[0].primaryColor,
        // focusColor: themeColors[0].focusColor,
        // hoverColor: themeColors[0].hoverColor,
        // backgroundColor: themeColors[0].backgroundColor,
      );
    }
  }

  /// [dark]系统的Dark Mode
  // setTheme({CustomColor color, bool platformDarkMode: false}) {
  //   print('color ---${color.tag}');
  //   var isDark = platformDarkMode; //|| _userDarkMode  （再判断用户是否启用暗黑模式）;
  //   Brightness brightness = isDark ? Brightness.dark : Brightness.light;
  //   // var themeColor = color;
  //   // var accentColor =  themeColor;
  //   // var accentColor = isDark ? themeColor[700] : themeColor;
  //   themeData = ThemeData(
  //     brightness: brightness,
  //     // 主题颜色属于亮色系还是属于暗色系(eg:dark时,AppBarTitle文字及状态栏文字的颜色为白色,反之为黑色)
  //     // 这里设置为dark目的是,不管App是明or暗,都将appBar的字体颜色的默认值设为白色.
  //     // 再AnnotatedRegion<SystemUiOverlayStyle>的方式,调整响应的状态栏颜色
  //     primaryColorBrightness: Brightness.dark,
  //     accentColorBrightness: Brightness.dark,

  //     /// 设置对应主要的appbar样式
  //     appBarTheme: AppBarTheme(color: color.themeColor, brightness: brightness),

  //     /// 当前主题色 (包括 appbar底色，选中背景色，公告背景)
  //     accentColor: color.themeColor,

  //     /// 次级高亮色 (包括 app默认字体色，底部bott选中色，客服图标，二级分类字色，视频图标色，收藏选中)
  //     primaryColor: color.primaryColor,

  //     /// 特殊  (包括大分类字体色)
  //     focusColor: color.focusColor,

  //     /// 其他颜色——1 (彩票开奖号码球背景色)
  //     hoverColor: color.hoverColor,

  //     /// 当前主题背景颜色
  //     // backgroundColor: color.backgroundColor,
  //     /// 选择自定义字体 添加选中的字体
  //     // fontFamily: 'system',
  //   );
  // }

  /// 保存选定的主题色
  // saveTheme2Storage(bool userDarkMode, int index) async {
  //   await Future.wait([
  //     StorageManager.pref.setBool(StorageKey.kThemeUserDarkMode, userDarkMode),
  //     StorageManager.pref.setInt(StorageKey.kThemeColorIndex, index)
  //     // themeStorage.set(index)
  //   ]);
  // }

  // static List<CustomColor> themeColors = ResTheme.resThemeList;

  // static const<MaterialColor> themeColors = <MaterialColor>[
  //   Colors.red,
  //   Colors.pink,
  //   Colors.purple,
  //   Colors.deepPurple,
  //   Colors.indigo,
  //   Colors.blue,
  //   Colors.lightBlue,
  //   Colors.cyan,
  //   Colors.teal,
  //   Colors.green,
  //   Colors.lightGreen,
  //   Colors.lime,
  //   Colors.yellow,
  //   Colors.amber,
  //   Colors.orange,
  //   Colors.deepOrange,
  //   Colors.brown,
  //   Colors.blueGrey
  // ];

  /// 输入框的 theme 配置
  // InputDecorationTheme inputDecorationTheme(ThemeData theme) {
  //   var primaryColor = theme.primaryColor;
  //   var dividerColor = theme.dividerColor;
  //   var errorColor = theme.errorColor;
  //   var disabledColor = theme.disabledColor;

  //   var width = 0.5;

  //   return InputDecorationTheme(
  //     helperStyle: TextStyle(fontSize: 14),
  //     errorBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(width: width, color: errorColor)),
  //     focusedErrorBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(width: 0.7, color: errorColor)),
  //     focusedBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(width: width, color: primaryColor)),
  //     enabledBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(width: width, color: dividerColor)),
  //     border: UnderlineInputBorder(
  //         borderSide: BorderSide(width: width, color: dividerColor)),
  //     disabledBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(width: width, color: disabledColor)),
  //   );
  // }
}
