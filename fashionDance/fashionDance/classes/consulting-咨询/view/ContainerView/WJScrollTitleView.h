//
//  WJScrollTitleView.h
//  WJContainerViewExample
//
//  Created by 汪俊 on 16/3/14.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJScrollTitleView;

@protocol WJScrollTitleViewDelegate <NSObject>

- (void)scrollTitleView:(WJScrollTitleView *)containerView NumberOfRow:(NSInteger)index;

@end

@interface WJScrollTitleView : UIView
//////////////////////////////////////////////////////////////////////// 初始化
+ (instancetype)scrollTitleViewWithFrame:(CGRect)frame;

+ (instancetype)scrollTitleView;
/**
 *  设置标题最大偏移量
 *
 */
@property (assign, nonatomic)CGFloat titlesScrollWidth;
/**
 *  contentView的背景颜色
 */
@property (strong, nonatomic)UIColor *contentBackgroundColor;

@property (weak, nonatomic)id <WJScrollTitleViewDelegate> delegate;
//////////////////////////////////////////////////////////////////////// 设置头部标题
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
 *  指定存放头部标题的view数组
 */
@property (strong, nonatomic)NSArray *titles;
////////////////////////////////////////////////////////////////////////other

/**
 *  指定存放内容的view数组
 */
@property (copy, nonatomic)NSArray *views;


@end
