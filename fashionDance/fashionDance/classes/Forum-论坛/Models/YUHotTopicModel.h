//
//  YUHotTopicModel.h
//  fashionDance
//
//  Created by qianfeng on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Pics;
@interface YUHotTopicModel : NSObject

@property (nonatomic, assign) BOOL isElite;

@property (nonatomic, assign) BOOL isTop;

@property (nonatomic, assign) NSInteger replayCount;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *barName;

@property (nonatomic, copy) NSString *barId;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *topicId;

@property (nonatomic, copy) NSString *threadType;

@property (nonatomic, assign) NSInteger clickCount;

@property (nonatomic, assign) NSInteger bid;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic,copy) NSString *pic1;

@property (nonatomic,copy) NSString *pic2;

@property (nonatomic,copy) NSString *pic3;

@property (nonatomic, strong) NSArray<Pics *> *pics;

/** 原YUTopicList数据  */

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) NSInteger replyCount;

@property (nonatomic, assign) NSInteger authorId;

@property (nonatomic, copy) NSString *authorName;

@property (nonatomic, copy) NSString *topicDescription;

/** 额外增加的属性  */
@property (nonatomic, assign) CGFloat hotTopicCellH;

@end
@interface Pics : NSObject

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *url;

@end

