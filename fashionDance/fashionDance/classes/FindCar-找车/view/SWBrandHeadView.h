//
//  SWBrandHeadView.h
//  fashionDance
//
//  Created by 苏威 on 16/3/15.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ButtonClickBlock)(UIButton * sender);
@interface SWBrandHeadView : UIView

@property(nonatomic,copy)ButtonClickBlock buttonClickBlock;

@end
