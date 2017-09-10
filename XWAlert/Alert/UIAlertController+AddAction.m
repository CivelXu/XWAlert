//
//  UIAlertController+AddAction.m
//  XWAlert
//
//  Created by xuxiwen on 2017/3/31.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

#import "UIAlertController+AddAction.h"
#import <objc/runtime.h>

char * const XWAlertKey = "buttonKey";

@interface UIAlertController ()

@end

@implementation UIAlertController (AddAction)

- (void)addAlertDefaultActionWithTitle:(NSString *_Nullable)title
                               handler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler {
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:title
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        if (handler)  handler(action);
                                                    }];
    [self addAction:action];
}

- (void)addAlertActionWithTitle:(NSString *_Nullable)title
                    actionStyle:(UIAlertActionStyle)actionStyle
                        handler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler {
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:title
                                                     style:actionStyle
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       if (handler)  handler(action);
                                                    }];
    [self addAction:action];
}

- (void)addTextFieldWithPlaceholder:(NSString *_Nullable)placeholder
                    secureTextEntry:(BOOL)secureTextEntry
                        textHandler:(TextFiledHanler _Nullable )textHandler   {
    
    objc_setAssociatedObject(self, XWAlertKey, textHandler, OBJC_ASSOCIATION_COPY);
    
    __weak typeof(self) weakself = self;
    [self addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.secureTextEntry = secureTextEntry;
        textField.placeholder = placeholder;
        [textField addTarget:weakself action:@selector(textFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
    }];
}

- (void)addTextFieldWithPlaceholder:(NSString *_Nullable)placeholder
                    secureTextEntry:(BOOL)secureTextEntry
                   textFiledhandler:(void(^_Nullable)(UITextField * _Nonnull textField))textFiledhandler {
   
    [self addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.secureTextEntry = secureTextEntry;
        textField.placeholder = placeholder;
        __weak typeof(textField) weakTextFiled = textField;
        if (textFiledhandler)  textFiledhandler(weakTextFiled);
     }];
}

#pragma mark - TextFieldDidChange Action

- (void)textFieldDidChange:(UITextField *)textField {
    TextFiledHanler handler = objc_getAssociatedObject(self,XWAlertKey);
    if (handler)  handler(textField.text);
}


@end
