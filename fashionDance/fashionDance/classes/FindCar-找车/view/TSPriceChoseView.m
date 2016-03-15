//
//  TSPriceChoseView.m
//  fashionDance
//
//  Created by Dylan on 3/15/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSPriceChoseView.h"
@interface TSPriceChoseView()
@property (nonatomic,strong)UIImageView * scaleBackView;
@end;
@implementation TSPriceChoseView

-(void)drawBackView
{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //一条线，获取一个path
    UIBezierPath * path=[UIBezierPath bezierPath];
    CGContextAddPath(ctx, path.CGPath);
    //把上下文渲染到视图
    //设置属性
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, 2);
    [[UIColor redColor]set];
    CGContextStrokePath(ctx);
}
@end
