//
//  YUTopicWebViewController.m
//  fashionDance
//
//  Created by qianfeng on 16/3/12.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUTopicWebViewController.h"
#import "YUHotTopicModel.h"
#import <SVProgressHUD.h>

@interface YUTopicWebViewController () <UIWebViewDelegate>

@end

@implementation YUTopicWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    // 创建webView
    [self setupWebView];
    
    //显示加载进度条
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
}
- (void)setupNav
{
    self.title = @"帖子详情";
}
/**
 *  创建webView
 */
- (void)setupWebView
{
    //UIWebView是用来显示网页数据
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WJScreenW, WJScreenH)];
    [self.view addSubview:webView];
    
    NSString *urlString = [NSString stringWithFormat:@"http://saa.auto.sohu.com/v5/mobileapp/topic/folnote.do?bid=%ld&topicId=%@&pageSize=15&pic_type=0&page=1",_topicModel.bid,_topicModel.topicId];
    //加载网页数据
    NSURL *url = [NSURL URLWithString:urlString];
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
}
//加载结束
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //隐藏加载进度条
    [SVProgressHUD dismiss];
    
}


@end
