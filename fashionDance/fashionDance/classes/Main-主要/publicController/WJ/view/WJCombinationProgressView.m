//
//  WJCombinationProgressView.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJCombinationProgressView.h"

@implementation WJCombinationProgressView

+ (instancetype)combinationProgressView {
//    [self getIvars];
    return [[self alloc]initWithFrame:CGRectZero];
}

+ (instancetype)combinationProgressViewWithFrame:(CGRect)frame {
    return [[self alloc]initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupSubViews];
}

- (void)setupSubViews {
    
    UIProgressView * progressView = [[UIProgressView alloc]init];
    self.progressView = progressView;
    [self addSubview:progressView];
    
    UILabel *progressLabel = [[UILabel alloc]init];
    self.progressLabel = progressLabel;
    [self addSubview:progressLabel];
    progressLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
}


//+ (void)getIvars
//{
//    unsigned int count = 0;
//    
//    // 拷贝出所有的成员变量列表
//    Ivar *ivars = class_copyIvarList([UIProgressView class], &count);
//    
//    for (int i = 0; i<count; i++) {
//        // 取出成员变量
//        //        Ivar ivar = *(ivars + i);
//        Ivar ivar = ivars[i];
//        
//        // 打印成员变量名字
//        WJLog(@"%s %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
//    }
//    
//    // 释放
//    free(ivars);
//}

- (void)layoutSubviews {
    self.progressView.x = 5;
    self.progressView.y = self.width / 2;
    self.progressView.width = self.height - 30;
    self.progressView.height = 5;
    
    self.progressLabel.x = - self.progressView.width;
    self.progressLabel.y = -5;
    self.progressLabel.size = CGSizeMake(100, self.height);
}

@end
