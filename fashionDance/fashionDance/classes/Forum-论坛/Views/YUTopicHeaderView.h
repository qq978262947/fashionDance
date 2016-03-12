//
//  YUTopicHeaderView.h
//  fashionDance
//
//  Created by qianfeng on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YUTopicHeaderView;
@class YUHotTopicModel;

@protocol YUTopicHeaderViewDelegate <NSObject>

- (void)collectionViewDidSelectItem:(YUTopicHeaderView *)topicHeaderView topicModel:(YUHotTopicModel *)topicModel;

@end

@interface YUTopicHeaderView : UIView

@property (nonatomic, strong) NSArray *bannerListModels;

@property (nonatomic, weak) id <YUTopicHeaderViewDelegate> delegate;

@end
