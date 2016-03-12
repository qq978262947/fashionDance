//
//  YUCollectionReusableView.h
//  fashionDance
//
//  Created by qianfeng on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YUSelectionTopic;
@class YUCollectionReusableView;
@protocol YUCollectionReusableViewDelegate <NSObject>

- (void)collectionReusableViewDidBtnClick:(YUCollectionReusableView *)collectionReusableView  selectionTopic:(YUSelectionTopic *)selectionTopic;

@end

@interface YUCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) YUSelectionTopic *selectionTopic;

@property (nonatomic,weak) id <YUCollectionReusableViewDelegate> delegate;

@end
