//
//  Config.h
//  fashionDance
//
//  Created by 李璐 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#ifndef Config_h
#define Config_h


#pragma mark -- 颜色

// 随机数
#define WArcNum(x) arc4random_uniform(x)
// 颜色
#define WColorRGB(r, g, b) WColorRGBA(r, g, b, 1.000f)
#define WColorRGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
// 随机颜色
#define WArcColor WColorRGB(WArcNum(128) + 128, WArcNum(128) + 128, WArcNum(128) + 28)

#define WColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//-------------------获取设备大小-------------------------
// NavBar高度
#define WNavigationBarHeight (44.0)
// 状态栏高度
#define WStatusBarHeight (20.0)
// 顶部高度
#define WTopHeight (WNavigationBarHeight + WStatusBarHeight)
// 底部 TabBar 高度
#define WTabBarHeight 49
// 动态获取屏幕宽高
#define WScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define WScreenWidth ([UIScreen mainScreen].bounds.size.width)

//字体大小
#define LLSubTitleFont [UIFont systemFontOfSize:12.0]
#define LLTitleFont [UIFont systemFontOfSize:14.0]
#define LLSuperTitleFont [UIFont systemFontOfSize:16.0]

#endif /* Config_h */
