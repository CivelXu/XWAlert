# XWAlert (快速调用 UIAlertViewcontroller )

[![](https://travis-ci.org/CivelXu/XWAlert.svg?branch=master)](https://github.com/CivelXu/XWAlert)
![](https://img.shields.io/badge/platform-ios-light.svg)
![](https://img.shields.io/badge/license-MIT-000000.svg)
![](https://img.shields.io/badge/language-objc-orange.svg)
[![](https://img.shields.io/badge/weibo-xuxiwen-red.svg)](http://weibo.com/2670925983)

## 前言

> Alert 在iOS开发中，是一个经常用到的控件。iOS原生的API中的写法，我这里就不吐槽了，无论是AlertView 还是AlertViewcontroller 都需要很多代码来调用。

>网上有很多关于AlertView的封装，再加上这是个已经被废弃的控件。我这里就不来叙述。这里提供一个我自己实现的AlertViewController的快速调用。

看下图，我猜还有很多人，还在用着废弃的Alert，忍受着 ⚠️⚠️⚠️
 ![警告视图](http://upload-images.jianshu.io/upload_images/1805099-d858de2787e595be.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/375)

好了下面就直接上代码的使用 >>>>>> 


## 快速创建 

代码示范

```
   [XWAlert showAlertWithTitle:@"提示"
                       message:@"你浏览的是成人内容，是否满足18岁？"
                  confirmTitle:@"满足"
                   cancelTitle:@"自动离开"
                preferredStyle:(UIAlertControllerStyleActionSheet/UIAlertControllerStyleAlert)
                 confirmHandle:^{
                    NSLog(@"满足-----");
   }
                  cancleHandle:^{
                    NSLog(@"不满足-----");

   }];
```

![效果预览](http://upload-images.jianshu.io/upload_images/1805099-5e720f1140afc68c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/500)

> 当然，你还可以省略其中任何一个
 


## 自定义UIAlertAction 数量种类不限 

 示例1


```
   [XWAlert showAlertWithTitle:@"选择题"
                        message:@"菊花一词，为何走红？"
                 preferredStyle:UIAlertControllerStyleAlert
                    actionMaker:^(UIAlertController *maker) {
                        
                        NSString *string1 = @"菊花台这首歌";
                        NSString *string2 = @"陶渊明的诗词";
                        NSString *string3 = @"象征纯洁";
                        NSString *string4 = @"人体器官的形象话";
                        NSString *string5 = @"我选择死亡";

 [maker addAlertDefaultActionWithTitle:string1 handler:^(UIAlertAction * _Nullable action) {
                            NSLog(@"你的选择是--- %@", string1);
                        }];

                        [maker addAlertDefaultActionWithTitle:string2 handler:^(UIAlertAction * _Nullable action) {
                            NSLog(@"你的选择是--- %@", string2);

                        }];
         
                        [maker addAlertDefaultActionWithTitle:string3 handler:^(UIAlertAction * _Nullable action) {
                            NSLog(@"你的选择是--- %@", string3);
                        }];

                        [maker addAlertActionWithTitle:string4 actionStyle:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nullable action) {
                            NSLog(@"你的选择是--- %@", string4);
                            
                        }];

                        [maker addAlertActionWithTitle:string5 actionStyle:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nullable action) {
                            NSLog(@"你的选择是--- %@", string5);

                        }];
    }];
}
```
![示例1](http://upload-images.jianshu.io/upload_images/1805099-15ec010bf4613fa6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/375)

* 示例2

```
   [XWAlert showAlertWithTitle:@"注意"
                        message:@"按照要求填写信息"
                 preferredStyle:self.selectedStyle
                    actionMaker:^(UIAlertController *maker) {
                        
                        NSString *string1 = @"确定";
                        NSString *string2 = @"取消";

                        [maker addAlertDefaultActionWithTitle:string1
                                                      handler:^(UIAlertAction * _Nullable action) {
                            NSLog(@"你的选择是--- %@", string1);
                        }];
                        

                        [maker addAlertActionWithTitle:string2
                                           actionStyle:ActionStyleCancel
                                               handler:^(UIAlertAction * _Nullable action) {
                            NSLog(@"你的选择是--- %@", string2);
                        }];
                        

                        [maker addTextFieldWithPlaceholder:@"输入用户名"
                                           secureTextEntry:NO
                                                   textHandler:^(NSString * _Nullable text) {
                           NSLog(@"你输入的用户是--- %@",text);

                        }];
                        
                        [maker addTextFieldWithPlaceholder:@"输入密码"
                                           secureTextEntry:YES
                                          textFiledhandler:^(UITextField * _Nonnull textField) {
                             textField.textColor = [UIColor greenColor];
                             textField.font = [UIFont boldSystemFontOfSize:16];
                                                     }];
                    }];

```
![示例2](http://upload-images.jianshu.io/upload_images/1805099-f1aec1487a215b1c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/375)


```
 这里需要注意的是 这个方法 callback 一个 UIAlertController ，*maker。 
 我为UIAlertController添加了一个便利添加UIAlertAction的Category。
```

 第一种是添加一个默认的AlertAction,只需要输入标题，然后handle业务逻辑就可以。

```
/**
 to add UIAlertAction with UIAlertActionStyleDefault

 @param title - the title of UIAlertAction
 @param handler - to handle your business
 */
- (void)addAlertDefaultActionWithTitle:(NSString *_Nullable)title
                               handler:(void (^_Nullable)(UIAlertAction * _Nullable  action))handler;
```

  第二种和第一种的区别在于可以选择样式

```
/**
 to add UIAlertAction with Custom Style


 @param title - the title of UIAlertAction
 @param actionStyle - to chose UIAlertActionStyle
 @param handler - to handle your business
 */
- (void)addAlertActionWithTitle:(NSString *_Nullable)title
                    actionStyle:(UIAlertActionStyle)actionStyle
                        handler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler;
```

 第三种是添加TextFiled，可以添加占位，密文输入。会callback 一个输入结束后的text

```
/**
 to add TextField in your alert , callback the  text which  you input
 it only support in Alert Styple

 @param placeholder - set TextField's placeholder
 @param secureTextEntry - set Secure input Mode
 @param textHandler - to get text which  you input
 */
- (void)addTextFieldWithPlaceholder:(NSString *_Nullable)placeholder
                    secureTextEntry:(BOOL)secureTextEntry
                            textHandler:(TextFiledHanler _Nullable )textHandler;
```

 第四种和第三种类似，添加textFiled；callback的是 textFiled对象本身，用于处理业务逻辑。

```
/**
 to add TextField in your alert, callback the  textFiled which  you built
 it only support in Alert Styple

 @param placeholder - set TextField's placeholder
 @param secureTextEntry - set Secure input Mode
 @param textFiledhandler - to handle textField which you can do anything
 */
- (void)addTextFieldWithPlaceholder:(NSString *_Nullable)placeholder
                    secureTextEntry:(BOOL)secureTextEntry
                   textFiledhandler:(void(^_Nullable)(UITextField * _Nonnull textField))textFiledhandler;
```
## 纯message 自动miss

```
    [XWAlert showAlertWithTitle:@"注意"
                        message:@"这是一条不要脸的弹窗"
                 preferredStyle:self.selectedStyle
                autoDismissTime:2];
```

   ![纯文本示例](http://upload-images.jianshu.io/upload_images/1805099-7ba52b232ddd9f9e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


## 新增 快速 创建 且可以自定义 style 

```
    [XWAlert showAlertWithTitle:@"title"
                        message:@"message"
                   confirmTitle:@"default style"
                    cancelTitle:@"cancel style"
               destructiveTitle:@"destructive style"
                 preferredStyle:self.selectedStyle
                  confirmHandle:^{
                      
                    NSLog(@"------- default style");

    }
                   cancleHandle:^{
                    NSLog(@"------- cancel style");

    }
              destructiveHandle:^{
                    NSLog(@"------- destructive style");

    }];
    
```
![示范图](http://upload-images.jianshu.io/upload_images/1805099-06993d4ae22a29ab.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/375)

## CocoaPods 安装 

`    pod 'XWAlert', '~> 1.3' `

` #import <XWAlert.h> `

## 后记 

> 这只是自己设计出来的一种方案，实现了AlertViewController的大部分功能。
> 在使用的过程有任何问题都可以向我提出
> 如果大家有更加好的方案和思路，希望把地址发出来，一起参考学习。

* [GitHub - demo](https://github.com/CivelXu/XWAlert)
* [简书](http://www.jianshu.com/p/60460d3a6be5)
* [个人博客](http://civelxu.com/2016/06/12/AlertViewController%20的快速调用，看我就够了%E3%80%82/)

最后, 如果觉得对你有所帮助，还希望大家对我进行支持。😊😊







