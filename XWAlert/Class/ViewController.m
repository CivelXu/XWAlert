//
//  ViewController.m
//  XWAlert
//
//  Created by xuxiwen on 2017/3/31.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

#import "ViewController.h"
#import "XWAlert.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.userInteractionEnabled = YES;
}


- (IBAction)push:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *destination = [storyBoard instantiateViewControllerWithIdentifier:@"ShowAlertViewController"];
    [self.navigationController pushViewController:destination animated:YES];
}

- (IBAction)present:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *destination = [storyBoard instantiateViewControllerWithIdentifier:@"ShowAlertViewController"];
    [self.navigationController presentViewController:destination animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
