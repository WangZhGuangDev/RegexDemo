//
//  ViewController.m
//  RegexDemo
//
//  Created by DDing_Work on 2017/9/4.
//  Copyright © 2017年 DDing_Work. All rights reserved.
//

#import "ViewController.h"

#import "ZHGRegexTool.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)verifyAction:(UIButton *)sender {
    
    NSString *text = self.textField.text;
    NSLog(@"这是输入的文本：%@",text);
    
    BOOL isMatch = [ZHGRegexTool regexWithPasswordComplex:text];
    [self alertMessage:isMatch ? @"格式正确" : @"格式错误"];
//    isMatch ? NSLog(@"格式正确") : NSLog(@"格式错误");
}

-(void)alertMessage:(NSString *)message {
    [self.view endEditing:YES];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

@end
