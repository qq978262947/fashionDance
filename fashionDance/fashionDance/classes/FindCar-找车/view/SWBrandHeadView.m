//
//  SWBrandHeadView.m
//  fashionDance
//
//  Created by 苏威 on 16/3/15.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "SWBrandHeadView.h"

@implementation SWBrandHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        /**
         *  初始化子控件
         */
        [self setupButtonWithNormal:@"like_selected" title:@"我的收藏"];
        [self setupButtonWithNormal:@"like_selected" title:@"游览历史"];
        [self setupButtonWithNormal:@"like_selected" title:@"热门排行"];
        
    }
    return self;
}

-(void)setupButtonWithNormal:(NSString *)normal title:(NSString *)title
{
    UIButton *collBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [collBtn setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [collBtn setTitle:title forState:UIControlStateNormal];
    [self addSubview:collBtn];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
   
    NSInteger count = self.subviews.count;
     CGFloat width = self.width/count ;
    for (int i = 0 ; i<count;i++) {
        UIButton *button = self.subviews[i];
        button.width = width;
        button.height = self.height;
        button.y = 0;
        button.x = i*width;
        CGSize size = button.currentImage.size;
        
        button.imageEdgeInsets = UIEdgeInsetsMake(0, size.width, size.height, 0);
        button.titleEdgeInsets = UIEdgeInsetsMake(size.height, -10, 0, 10);
    }
    
}
@end
