//
//  WJTabBarController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/8.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJTabBarController.h"
#import "WJNavgationController.h"
#import "CarConsultingController.h"
#import "CarFindController.h"
#import "CarPreferentialController.h"
#import "CarForumController.h"
#import "UIImage+reSize.h"

//#define WJImageSize CGSizeMake(25, 25)


@interface WJTabBarController ()

@end

@implementation WJTabBarController

+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:235/255.0 green:99/255.0  blue:113/255.0  alpha:255/255.0 ];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子控制器
    [self setupChildVc:[[CarConsultingController alloc] init] title:@"咨询" imageName:@"tab_forum_normal" selectedImageName:@"tab_forum_highlighted"];
    
    [self setupChildVc:[[CarFindController alloc] init] title:@"找车" imageName:@"tab_selectCar_normal" selectedImageName:@"tab_selectCar_highlighted"];
    
    [self setupChildVc:[[CarPreferentialController alloc] init] title:@"视频" imageName:@"tab_preferentialCar_normal" selectedImageName:@"tab_preferentialCar_highlighted"];
    
    [self setupChildVc:[[CarForumController alloc] init] title:@"论坛" imageName:@"tab_news_normal" selectedImageName:@"tab_news_highlighted"];
    
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WJScreenW, WJTopicCellBottomBarH)];
    whiteView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9];
    UIImage *navBgImage = [UIImage captureWithView:whiteView];
    [self.tabBar setBackgroundImage:navBgImage];
    // 更换tabBar
//    [self setValue:[[WJTabBar alloc] init] forKeyPath:@"tabBar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    
    // 设置普通状态下图片
    UIImage *normalImage = [UIImage imageNamed:imageName];
    vc.tabBarItem.image = normalImage;
    
    // 设置选中状态下图片
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selectedImage;
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    WJNavgationController *nav = [[WJNavgationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


@end
