//
//  WJWebViewController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJWebViewController.h"
#import <SVProgressHUD.h>

@interface WJWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) UIWebView *webView;
@end

@implementation WJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWebView];
}

- (void)setupWebView {
    self.view.backgroundColor = [UIColor whiteColor];
    // 创建并约束webview
    UIWebView *webView = [[UIWebView alloc]init];
    webView.backgroundColor = [UIColor whiteColor];
    self.webView = webView;
    [self.view addSubview:webView];
    [self constraintWebView];
    
    // 设置webview约束及其他
    webView.delegate = self;
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.urlString]];
    [webView loadRequest:request];
}


- (void)constraintWebView {
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - webViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    [SVProgressHUD dismiss];
}


@end
