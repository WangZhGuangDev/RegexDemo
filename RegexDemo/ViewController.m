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
    
    isMatch ? NSLog(@"格式正确") : NSLog(@"格式错误");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
