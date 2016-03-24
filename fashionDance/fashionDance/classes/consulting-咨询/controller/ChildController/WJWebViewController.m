//
//  WJWebViewController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJWebViewController.h"
#import "SVProgressHUD.h"
#import "LLDBArticleManager.h"
#import "WJConsultingResult.h"

@interface WJWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) UIWebView *webView;

@property(nonatomic,weak)UIBarButtonItem * itemFavorite;
@property(nonatomic,assign)BOOL isFavorite;
@end

@implementation WJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //从数据库里查找是不是收藏过
#warning 待完善
    self.isFavorite = NO;
    //nav bar上的收藏和分享按钮
    UIBarButtonItem * itemFavorite = [UIBarButtonItem itemWithImage:@"emptyStar" highImage:@"like_selected" target:self action:@selector(favoriteItemTouch)];
    self.itemFavorite = itemFavorite;
    UIBarButtonItem * itemShare = [UIBarButtonItem itemWithImage:@"tab_mySpace_normal" highImage:nil target:self action:@selector(shareItemTouch)];
    self.navigationItem.rightBarButtonItems = @[itemShare,itemFavorite];
    
    [self setupWebView];
}

-(void)favoriteItemTouch
{
    //change favorite state
    self.isFavorite = !self.isFavorite;
    //与数据库沟通
    if (self.isFavorite) {
        [[LLDBArticleManager sharedManager] insertArticle:self.articleModel];
        [self.itemFavorite setImage:[UIImage imageNamed:@"like_selected"]];
    }
    else
    {
        [[LLDBArticleManager sharedManager] deleteArticleWithID:self.articleModel.ID];
        [self.itemFavorite setImage:[UIImage imageNamed:@"emptyStar"]];
    }
}

-(void)shareItemTouch
{
    
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
