//
//  WJHeaderView.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WJHeaderViewButtonTypeFindHot, // 看热门
    WJHeaderViewButtonTypeFindNewCar, // 看新车
    WJHeaderViewButtonTypeusedCar, // 二手车
    WJHeaderViewButtonTypeCheckBreakRules , // 查违章
} WJHeaderViewButtonType;

@class WJHeaderView;

@protocol WJHeaderViewDelegate <NSObject>
/**
 *  点击headerview的按钮调用的方法
 *
 *  @param headerView WJHeaderView
 *  @param buttonType WJHeaderViewButtonType
 */
- (void)headerView:(WJHeaderView *)headerView DidClick:(WJHeaderViewButtonType)buttonType;

@end

@interface WJHeaderView : UIView
/**
 *  代理
 */
@property (weak, nonatomic)id<WJHeaderViewDelegate> delegate;

/**
 *  实例化方法
 *
 *  @param frame headerView的frame
 *
 *  @return 实例对象
 */
+ (instancetype)headerViewWithFrame:(CGRect)frame;
/**
 *  实例化方法
 *
 *  @return 实例对象
 */
+ (instancetype)headerView;

@end
