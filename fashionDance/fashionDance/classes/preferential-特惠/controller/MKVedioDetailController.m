//
//  MKVedioDetailController.m
//  fashionDance
//
//  Created by Monky on 16/3/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//


#import "MKVedioDetailController.h"
#import "SVProgressHUD.h"

@interface MKVedioDetailController ()<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView *webView;
@end

@implementation MKVedioDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView
{//@"http://autoapp.auto.sohu.com/auto-app/news2/438124428.html?src=11640001"
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0.0, 0, WJScreenW, WJScreenH)];
    self.webView = webView;
    self.webView.delegate=self;
    [self.view addSubview:webView];
   
    }
- (void)viewDidAppear:(BOOL)animated
{
    NSURL* url = [NSURL URLWithString:_path];//创建URL
  //  NSLog(@"%@",_path);
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [self.webView loadRequest:request];//加载

    [super viewDidAppear:animated];
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
