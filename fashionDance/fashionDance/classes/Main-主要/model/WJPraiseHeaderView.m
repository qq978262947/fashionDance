//
//  WJPraiseHeaderView.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJPraiseHeaderView.h"

@implementation WJPraiseHeaderView

+ (instancetype)praiseHeaderView {
    return [[self alloc]initWithFrame:CGRectZero];
}

+ (instancetype)praiseHeaderViewWithFrame:(CGRect)frame {
    return [[self alloc]initWithFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupSubViews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
}



@end
