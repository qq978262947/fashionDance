//
//  YULineLabel.m
//  fashionDance
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YULineLabel.h"

@implementation YULineLabel

- (void)drawTextInRect:(CGRect)rect{
    [super drawTextInRect:rect];
    
    CGSize textSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    CGFloat strikeWidth = textSize.width;
    CGRect lineRect;
    CGFloat origin_x;
    CGFloat origin_y = 0.0;
    
    
    if ([self textAlignment] == NSTextAlignmentRight) {
        
        origin_x = rect.size.width - strikeWidth;
        
    } else if ([self textAlignment] == NSTextAlignmentCenter) {
        
        origin_x = (rect.size.width - strikeWidth)/2 ;
        
    } else {
        
        origin_x = 0;
    }
    
    
    if (self.lineType == LineTypeUp) {
        
        origin_y =  2;
    }
    
    if (self.lineType == LineTypeMiddle) {
        
        origin_y =  rect.size.height/2;
    }
    
    if (self.lineType == LineTypeDown) {//下画线
        
        origin_y = rect.size.height - 2;
    }
    
    lineRect = CGRectMake(origin_x , origin_y, strikeWidth, 1);
    
    if (self.lineType != LineTypeNone) {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGFloat R, G, B, A;
        UIColor *uiColor = self.lineColor;
        CGColorRef color = [uiColor CGColor];
        long numComponents = CGColorGetNumberOfComponents(color);
        
        if( numComponents == 4)
        {
            const CGFloat *components = CGColorGetComponents(color);
            R = components[0];
            G = components[1];
            B = components[2];
            A = components[3];
            
            CGContextSetRGBFillColor(context, R, G, B, A);
            
        }
        
        CGContextFillRect(context, lineRect);
    }
}
@end
