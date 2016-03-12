//
//  WJWaterFlowLayout.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WJWaterflowLayout;

@protocol WJWaterflowLayoutDelegate <NSObject>
@required
- (CGFloat)waterflowLayout:(WJWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(WJWaterflowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(WJWaterflowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(WJWaterflowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WJWaterflowLayout *)waterflowLayout;
@end

@interface WJWaterflowLayout : UICollectionViewLayout
/** 代理 */
@property (nonatomic, weak) id<WJWaterflowLayoutDelegate> delegate;
@end
