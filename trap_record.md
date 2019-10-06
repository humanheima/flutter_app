# 踩坑经历

1. AndroidX的问题
```
14:21:37.754 1344 info flutter.tools [ +320 ms] AndroidX incompatibilities may have caused this build to fail. See https://goo.gl/CP92wY.
```

自己的解决方法：将android app 的 compileSdkVersion 和 targetSdkVersion 指定为 28。

参考链接：[AndroidX compatibility](https://flutter.dev/docs/development/packages-and-plugins/androidx-compatibility)

2. MaterialApp如果使用注册路由表的方式，使用命名路由，并且指定了`initialRoute`属性，那么就不能使用`home`属性

```
return new MaterialApp(
      title: 'Flutter Demo',
      //指定了初始路由
      initialRoute: '/',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      //注册路由表
      routes: {
        "new_page": (context) => NewRoute(),
        '/': (context) => MyHomePage(
              title: 'Flutter Demo Home Page',
            )
      },
      //这里不能再指定home属性
      //home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
```
