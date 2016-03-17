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
#import "YUDBManager.h"

@interface YUTopicWebViewController () <UIWebViewDelegate>

@property (nonatomic, weak) UIButton *rightBtn;

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

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
}

- (void)setupNav
{
    self.title = @"帖子详情";
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem=item;
    [btn setBackgroundImage:[UIImage imageNamed:@"new_collectBtn_normal"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"new_collect_selected"] forState:UIControlStateSelected];
    self.rightBtn=btn;
    [btn addTarget:self action:@selector(rightBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    
    YUDBManager *manager = [YUDBManager sharedManager];
    NSArray *tmpArray = [manager searchAllTopic];
    for (YUHotTopicModel *topic in tmpArray) {
        
        if (self.topicModel.bid == topic.bid) {
            self.rightBtn.selected = YES;
            return;
        }
    }
    self.rightBtn.selected = NO;
}

//执行收藏操作
- (void)rightBtnTouch
{
    //选中状态下，即收藏状态下
    if (self.rightBtn.selected)
    {
        //取消收藏
        [[YUDBManager sharedManager]deleteTopicWithID:self.topicModel.bid];
    }
    else
    {
        [[YUDBManager sharedManager]insertTopic:self.topicModel];
    }
    self.rightBtn.selected=!self.rightBtn.selected;
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
    //隐藏加载进度条
    [SVProgressHUD dismiss];
}
//加载结束
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    
}


@end
