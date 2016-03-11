//
//  WJButtonContainerView.h
//  百思不得姐
//
//  Created by 汪俊 on 16/2/23.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "UIView+WJExtension.h"

@class WJContainerView;

@protocol WJContainerViewDelegate <NSObject>
/**
 *  代理方法 － 点击title按钮时调用
 *
 *  @param containerView 当前视图
 *  @param index         0 - n 依次对应按钮的下标（非枚举类型）
 */
- (void)containerView:(WJContainerView *)containerView NumberOfRow:(NSInteger)index;

@end



@interface WJContainerView : UIView



@property (copy, nonatomic) NSArray *titles;
/**
 *  初始化方法
 *
 *  @return WJContainerView
 */
+ (instancetype)containerView;
/**
 *  代理
 */
@property (weak, nonatomic)id<WJContainerViewDelegate> delegate;
/**
 *  普通状态下titile的颜色
 */
@property (strong, nonatomic)UIColor *titleColor;
/**
 *  选择状态下titile的颜色
 */
@property (strong, nonatomic)UIColor *selectedTitleColor;
/**
 *  按钮背景色
 */
@property (strong, nonatomic)UIColor *buttonBackgroundColor;
/**
 *  按钮背景图片
 */
@property (strong, nonatomic)UIColor *buttonBackgroundImage;
/**
 *  指示器颜色
 */
@property (strong, nonatomic)UIColor *indicatorViewColor;
/**
 *  切换title的动画时间
 */
@property (assign, nonatomic)NSTimeInterval animationTime;
/**
 *  是否开启打开动画
 */
@property (assign, nonatomic)BOOL isOpenAnimation;
/**
 *  根据传进来点击的按钮index重置按钮和指示器状态
 *
 *  @param selectedIndex NSInteger
 */
- (void)configButtonWithIndex:(NSInteger)selectedIndex;

@end
