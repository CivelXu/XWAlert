//
//  XWAlert.h
//  XWAlert
//
//  Created by xuxiwen on 2017/3/31.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIAlertController+AddAction.h"

typedef NS_ENUM (NSInteger, AlertStyle) {
    ActionSheet = 0,
    Alert
};

@interface XWAlert : NSObject

typedef void (^AlertConfirmHandle)();
typedef void (^AlertCancelHandle)();
typedef void (^AlertMarker)(UIAlertController *maker);


/**
 quick to show Alert only with confirm and cancel
 when confirmTitle or cancelTitle equel nil, only show one action

 @param title - Alert's title
 @param message - any message you want to show
 @param confirmTitle - the title of confirm button
 @param cancelTitle - the title of cancel button
 @param preferredStyle - show style (ActionSheet / Alert)
 @param confirmHandle - confirm opeartion
 @param cancleHandle - cancel opeartion
 */
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              confirmTitle:(NSString *)confirmTitle
               cancelTitle:(NSString *)cancelTitle
            preferredStyle:(AlertStyle)preferredStyle
             confirmHandle:(AlertConfirmHandle)confirmHandle
              cancleHandle:(AlertCancelHandle)cancleHandle;



/**
 Custom Alert built

 @param title - Alert's title
 @param message - any message you want to show
 @param preferredStyle - show style (ActionSheet / Alert)
 @param actionMaker - to add UIAlertAction by actionMaker
 */
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
            preferredStyle:(AlertStyle)preferredStyle
               actionMaker:(AlertMarker)actionMaker;
/**
 Only show Alert Message and auto dismiss

 @param title - Alert's title
 @param message - any message you want to show
 @param preferredStyle - show style (ActionSheet / Alert)
 @param autoDismissTime alert will auto dismiss after autoDismissTime
 */
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
            preferredStyle:(AlertStyle)preferredStyle
           autoDismissTime:(int)autoDismissTime;

@end
