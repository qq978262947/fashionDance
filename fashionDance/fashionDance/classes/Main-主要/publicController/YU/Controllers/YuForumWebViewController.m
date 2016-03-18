//
//  YuForumWebViewController.m
//  fashionDance
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YuForumWebViewController.h"
#import "YUHotTopicModel.h"
#import "SVProgressHUD.h"

@interface YuForumWebViewController () <UIWebViewDelegate>

@end

@implementation YuForumWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"详情";
    
    // 创建webView
    [self setupWebView];
    
    //显示加载进度条
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
}

/**
 *  创建webView
 */
- (void)setupWebView
{
    //UIWebView是用来显示网页数据
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WJScreenW, WJScreenH)];
    [self.view addSubview:webView];
    
    //加载网页数据
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    //设置代理
    webView.delegate = self;
}

#pragma mark - UIWebView代理
//开始加载网页
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //    //显示加载进度条
    //    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    //隐藏加载进度条
    [SVProgressHUD dismiss];
}
//加载结束
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
