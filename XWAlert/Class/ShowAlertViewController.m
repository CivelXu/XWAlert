//
//  ShowAlertViewController.m
//  XWAlert
//
//  Created by xuxiwen on 2017/3/31.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//


#import "ShowAlertViewController.h"
#import "XWAlert.h"


@interface ShowAlertViewController ()
@property (weak, nonatomic) IBOutlet UIButton *dismissBtn;
@property (nonatomic, assign) AlertStyle selectedStyle;
@end

@implementation ShowAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.parentViewController != nil) {
        self.dismissBtn.hidden = YES;
    } else {
        self.dismissBtn.hidden = NO;
    }
    
    self.selectedStyle = Alert;
}


- (IBAction)quickToShow:(id)sender {
    
   [XWAlert showAlertWithTitle:@"提示"
                       message:@"你浏览的是成人内容，是否满足18岁？"
                  confirmTitle:@"满足"
                   cancelTitle:@"自动离开"
                preferredStyle:self.selectedStyle
                 confirmHandle:^{
                    NSLog(@"满足-----");
   }
                  cancleHandle:^{
                    NSLog(@"不满足-----");

   }];
    
}

- (IBAction)customAlert1:(id)sender {
    
    [XWAlert showAlertWithTitle:@"选择题"
                        message:@"菊花一词，为何走红？"
                 preferredStyle:self.selectedStyle
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

                        [maker addAlertDefaultActionWithTitle:string4 handler:^(UIAlertAction * _Nullable action) {
                            NSLog(@"你的选择是--- %@", string4);

                        }];

                        [maker addAlertActionWithTitle:string5 actionStyle:ActionStyleCancel handler:^(UIAlertAction * _Nullable action) {
                            NSLog(@"你的选择是--- %@", string5);

                        }];
    }];
}


- (IBAction)customAlert2:(id)sender {
    
    
    
    if (self.selectedStyle == ActionSheet) {
        
        [XWAlert showAlertWithTitle:@"注意"
                            message:@"包含了UITextField，只能选择Alert"
                     preferredStyle:Alert
                    autoDismissTime:2];
        return;
    }
    
    
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
                            textField.placeholder = @"哈哈，请输入密码";
                        }];
                    }];
}


- (IBAction)onlyMessage:(id)sender {
    
    [XWAlert showAlertWithTitle:@"注意"
                        message:@"这是一条不要脸的弹窗"
                 preferredStyle:self.selectedStyle
                autoDismissTime:2];
}

- (IBAction)onlyOneAction:(id)sender {
    
    [XWAlert showAlertWithTitle:@"注意"
                        message:@"我只有一个按钮哦"
                   confirmTitle:nil
                    cancelTitle:@"知道了"
                 preferredStyle:self.selectedStyle
                  confirmHandle:nil
                   cancleHandle:^{
                       NSLog(@"------- 知道了");
    }];

}

- (IBAction)seg:(id)sender {
    UISegmentedControl *seg = sender;
    if (seg.selectedSegmentIndex == 0) {
        self.selectedStyle = Alert;
    } else {
        self.selectedStyle = ActionSheet;
    }
}

- (IBAction)dissMiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
