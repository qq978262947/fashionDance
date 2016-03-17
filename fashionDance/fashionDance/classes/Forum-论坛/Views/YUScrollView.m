//
//  YUScrollView.m
//  fashionDance
//
//  Created by qianfeng on 16/3/14.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUScrollView.h"

@implementation YUScrollView

/**
 *  解决UIScrollview和cell的手势冲突问题
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UITableViewCellContentView")] || [otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UITableViewWrapperView")]) {
        
        return YES;
    }
    return NO;
//    return [super gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
}

@end
