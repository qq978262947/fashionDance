//
//  UIBarButtonItem+WJExtension.m
//  01-百思不得姐
//
//  Created by wangjun on 15/7/22.
//  Copyright (c) 2015年 wangjun. All rights reserved.
//

#import "UIBarButtonItem+WJExtension.h"
#import "UIImage+reSize.h"
#define WJBarItemImageScale 0.5

@implementation UIBarButtonItem (WJExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)itemWithReImage:(NSString *)imageName highImage:(NSString *)highImageName target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalImage = [UIImage scaleImage:[UIImage imageNamed:imageName] toScale:WJBarItemImageScale];
    UIImage *highLightImage = [UIImage scaleImage:[UIImage imageNamed:highImageName] toScale:WJBarItemImageScale];
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    [button setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

@end
