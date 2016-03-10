//
//  UIView+WJExtension.h
//  01-百思不得姐
//
//  Created by wangjun on 15/7/22.
//  Copyright (c) 2015年 wangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WJExtension)
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
- (BOOL)isShowingOnKeyWindow;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/
@end
