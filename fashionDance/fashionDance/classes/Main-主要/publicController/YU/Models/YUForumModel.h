//
//  YUForumModel.h
//  fashionDance
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YUForumModel : NSObject

@property (nonatomic, copy) NSString *parentUnion;

@property (nonatomic, copy) NSString *memberCount;

@property (nonatomic, strong) NSArray *subClubList;

@property (nonatomic, copy) NSString *barId;

@property (nonatomic, copy) NSString *isAuthorityClub;

@property (nonatomic, copy) NSString *master;

@property (nonatomic, copy) NSString *logoUrl;

@property (nonatomic, copy) NSString *topicCount;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *clubIntro;

@property (nonatomic, copy) NSString *barUrl;

@property (nonatomic, copy) NSString *miniMasters;

@property (nonatomic, copy) NSString *barName;

@end
