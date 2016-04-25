//
//  WJScrollTitleView+AOP.m
//  WJContainerViewExample
//
//  Created by 汪俊 on 16/3/19.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJScrollTitleView+AOP.h"
#import "NSObject+WJAOP.h"
#import "WJConstraintModel.h"

@implementation WJScrollTitleView (AOP)


+ (void)load
{
    
    [WJScrollTitleView aop_changeMethod:@selector(setViewControllers:) newMethod:@selector(aop_setViewControllers:)];
    [WJScrollTitleView aop_changeMethod:@selector(setTitles:) newMethod:@selector(aop_setTitles:)];
    
}

- (void)aop_setViewControllers:(NSMutableArray *)viewControllers {
    
    NSMutableArray *newViewControllers = [NSMutableArray array];
    for (UIViewController *vc in viewControllers) {
        if ([vc isKindOfClass:[UIViewController class]]) {
            
            WJConstraintModel *constraintModel = [WJConstraintModel constraintModel];
            constraintModel.viewController = vc;
            constraintModel.viewControllerClass = WJControllerClassView;
            [newViewControllers addObject:constraintModel];
            
            if ([vc isKindOfClass:[UITableViewController class]]) {
                
                UITableViewController *tableVC = (UITableViewController *)vc;
                tableVC.automaticallyAdjustsScrollViewInsets = NO;
                constraintModel.viewControllerClass = WJControllerClassTableView;
                
            } else if ([vc isKindOfClass:[UICollectionViewController class]]) {
                
                UICollectionViewController *collectionVC = (UICollectionViewController *)vc;
                collectionVC.automaticallyAdjustsScrollViewInsets = NO;
                constraintModel.viewControllerClass = WJControllerClassCollectionView;
            }
            
        }
    }
    
    [self aop_setViewControllers:newViewControllers];
}

- (void)aop_setTitles:(NSArray *)titles {
    NSMutableArray *titleStrings = [NSMutableArray array];
    for (NSString *title in titles) {
        if ([title isKindOfClass:[NSString class]]) {
            if ([title isEqualToString:@""]) continue;
            [titleStrings addObject:title];
        }
    }
    [self aop_setTitles:titleStrings];
}

@end
