//
//  CQFeedbackController.m
//  Perfect_food
//
//  Created by Hancerqin on 16/2/5.
//  Copyright © 2016年 叶无道. All rights reserved.
//

#import "CQFeedbackController.h"

@interface CQFeedbackController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)sendMsg:(UIButton *)sender;

@end

@implementation CQFeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.layer.borderWidth = 1.0;
    self.textView.layer.cornerRadius = 6.0;
    self.textView.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)showMsg:(NSString *)msg {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:sure];
    [self presentViewController:alert animated:NO completion:nil];
}

- (IBAction)sendMsg:(UIButton *)sender {
    
    if (self.textField.text == nil || [self.textField.text isEqualToString:@""]) {
        [self showMsg:@"标题不能为空"];
        return;
    }
    if (self.textView.text == nil || [self.textView.text isEqualToString:@""]) {
        [self showMsg:@"内容不能为空"];
        return;
    }
    
    [self showMsg:@"感谢您的反馈~"];
    self.textView.text = @"";
    self.textField.text = @"";
}
@end
