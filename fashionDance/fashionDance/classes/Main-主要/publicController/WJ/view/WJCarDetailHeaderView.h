//
//  WJCarDetailHeaderView.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJMoreAboutCarModel.h"


@interface WJCarDetailHeaderView : UIView

+ (instancetype)carDetailHeaderView;

+ (instancetype)carDetailHeaderViewWithFrame:(CGRect)frame;

@property (weak, nonatomic)WJMoreAboutCarModel *moreAboutCarModel;

@end
