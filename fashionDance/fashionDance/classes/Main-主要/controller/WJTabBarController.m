//
//  WJTabBarController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/8.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJTabBarController.h"
#import "WJNavgationController.h"
#import "WJDanceController.h"
#import "WJRecommendController.h"
#import "WJShowsTopperController.h"
#import "WJSpecialController.h"
#import "WJTrainingController.h"
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
    [self setupChildVc:[[WJSpecialController alloc] init] title:@"专题" imageName:@"module_12288" selectedImageName:@"module_12288_press"];
    
    [self setupChildVc:[[WJRecommendController alloc] init] title:@"推荐" imageName:@"module_99340" selectedImageName:@"module_99340_press"];
    
    [self setupChildVc:[[WJShowsTopperController alloc] init] title:@"精彩表演" imageName:@"module_99341" selectedImageName:@"module_99341_press"];
    
    [self setupChildVc:[[WJDanceController alloc] init] title:@"舞蹈圈" imageName:@"module_12290" selectedImageName:@"module_12290_press"];
    
    [self setupChildVc:[[WJTrainingController alloc] init] title:@"训练营" imageName:@"module_6944" selectedImageName:@"module_6944_press"];
    
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
    normalImage = [UIImage scaleImage:normalImage toScale:0.2];
    vc.tabBarItem.image = normalImage;
    
    // 设置选中状态下图片
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [[UIImage scaleImage:selectedImage toScale:0.21]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selectedImage;
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    WJNavgationController *nav = [[WJNavgationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


@end
