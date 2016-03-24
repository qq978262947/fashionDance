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
    
    //nav bar上的收藏和分享按钮
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    UIBarButtonItem *itemFavorite = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [btn setBackgroundImage:[UIImage imageNamed:@"new_collectBtn_normal"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"new_collect_selected"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(favoriteItemTouch:) forControlEvents:UIControlEventTouchUpInside];
    self.itemFavorite = itemFavorite;
    UIBarButtonItem * itemShare = [UIBarButtonItem itemWithImage:@"tab_mySpace_normal" highImage:nil target:self action:@selector(shareItemTouch)];
    self.navigationItem.rightBarButtonItems = @[itemShare,itemFavorite];
    //从数据库里查找是不是收藏过
    self.isFavorite = NO;
    NSArray * array = [[LLDBArticleManager sharedManager] searchAllArticle];
    for (WJList * list in array) {
        if ([list.url isEqualToString:self.urlString]) {
            self.isFavorite = YES;
            btn.selected = YES;
        }
    }

    [self setupWebView];
}

-(void)favoriteItemTouch:(UIButton *)sender
{
    //change favorite state
    self.isFavorite = !self.isFavorite;
    sender.selected = self.isFavorite;
    //与数据库沟通
    if (self.isFavorite) {
        [[LLDBArticleManager sharedManager] insertArticle:self.articleModel];
    }
    else
    {
        [[LLDBArticleManager sharedManager] deleteArticleWithID:self.articleModel.ID];
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
