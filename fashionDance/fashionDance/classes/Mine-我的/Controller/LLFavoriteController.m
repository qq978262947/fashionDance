//
//  LLFavoriteController.m
//  fashionDance
//
//  Created by 李璐 on 16/3/24.
//  Copyright © 2016年 汪俊. All rights reserved.
//

/**
 * 我们要从数据库中取值
 */

#import "LLFavoriteController.h"
#import "WJScrollTitleView.h"
#import "LLDBCarManager.h"
//论坛收藏
#import "YUDBManager.h"
#import "YUHotTopicModel.h"
#import "YUHotTopicCell.h"

//文章收藏
#import "LLDBArticleManager.h"
#import "WJConsultingResult.h"
#import "WJConsultingCell.h"
#import "WJConsultingNoPicCell.h"

//第三方尝试
#import "LLFavoriteArticleController.h"
#import "LLFavoriteCarController.h"
#import "LLFavoriteTopicController.h"

@interface LLFavoriteController ()<WJScrollTitleViewDelegate>
@property(nonatomic,weak)LLFavoriteArticleController * articleContrl;
@property(nonatomic,weak)LLFavoriteCarController * carContrl;
@property(nonatomic,weak)LLFavoriteTopicController * topicContrl;
@end

@implementation LLFavoriteController
- (void)scrollTitleView:(WJScrollTitleView *)containerView NumberOfRow:(NSInteger)index
{
    
    switch (index) {
        case 0:
            //车
            break;
        case 1:
            //文章
            break;
        case 2:
            //帖子
            break;
            
        default:
            break;
    }//end switch
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    WJScrollTitleView * view = [WJScrollTitleView scrollTitleViewWithFrame:CGRectMake(0, 0, WJScreenW, WJScreenH)];
    LLFavoriteArticleController * article = [[LLFavoriteArticleController alloc]init];
    article.articleData = [[LLDBArticleManager sharedManager] searchAllArticle];
    [self addChildViewController:article];
    self.articleContrl = article;
    
    LLFavoriteTopicController * topic = [[LLFavoriteTopicController alloc]init];
    topic.forumData = [[YUDBManager sharedManager] searchAllTopic];
    [self addChildViewController:topic];
    self.topicContrl = topic;
    
    LLFavoriteCarController * car = [[LLFavoriteCarController alloc]init];
    car.carData = [[LLDBCarManager sharedManager] searchAllCar];
    [self addChildViewController:car];
    
    
    view.viewControllers = @[topic,article,car];
    view.titles = @[@"论坛",@"文章",@"汽车"];
    view.titlesScrollWidth = WJScreenW;
    view.delegate = self;
    [self.view addSubview:view];
    
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    self.articleContrl.articleData = [[LLDBArticleManager sharedManager] searchAllArticle];
//    self.topicContrl.forumData = [[YUDBManager sharedManager] searchAllTopic];
//}

@end
