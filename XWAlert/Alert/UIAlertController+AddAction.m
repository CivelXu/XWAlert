//
//  UIAlertController+AddAction.m
//  XWAlert
//
//  Created by xuxiwen on 2017/3/31.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

#import "UIAlertController+AddAction.h"
#import <objc/runtime.h>

char* const XWAlertKey = "buttonKey";

@interface UIAlertController ()<UITextFieldDelegate>

@end

@implementation UIAlertController (AddAction)

- (void)addAlertDefaultActionWithTitle:(NSString *_Nullable)title
                               handler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler {
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:title
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        if (handler) {
                                                            handler(action);
                                                        }
                                                    }];
    [self addAction:action];
}

- (void)addAlertActionWithTitle:(NSString *_Nullable)title
                    actionStyle:(AlertActionStyle)actionStyle
                        handler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler {
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:title
                                                     style:(UIAlertActionStyle)actionStyle
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       if (handler) {
                                                           handler(action);
                                                       }
                                                   }];
    [self addAction:action];
}

- (void)addTextFieldWithPlaceholder:(NSString *_Nullable)placeholder
                    secureTextEntry:(BOOL)secureTextEntry
                        textHandler:(TextFiledHanler _Nullable )textHandler   {
    
    __weak typeof(self) weakself = self;
    
    objc_setAssociatedObject(self, XWAlertKey, textHandler, OBJC_ASSOCIATION_COPY);
    
    [self addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.secureTextEntry = secureTextEntry;
        textField.placeholder = placeholder;
        textField.delegate = weakself;
    }];
}

- (void)addTextFieldWithPlaceholder:(NSString *_Nullable)placeholder
                    secureTextEntry:(BOOL)secureTextEntry
                   textFiledhandler:(void(^_Nullable)(UITextField * _Nonnull textField))textFiledhandler {
   
    [self addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.secureTextEntry = secureTextEntry;
        textField.placeholder = placeholder;
        __weak typeof(textField) weakTextFiled = textField;
        if (textFiledhandler) {
            textFiledhandler(weakTextFiled);
        }
    }];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    TextFiledHanler handler = objc_getAssociatedObject(self,XWAlertKey);
    if (handler) {
        handler(textField.text);
    }
}

@end
