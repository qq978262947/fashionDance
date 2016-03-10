//
//  WJSpecialList.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/9.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJSpecialList : NSObject

@property (nonatomic, assign) NSInteger review;

@property (nonatomic, assign) NSInteger video_review;

@property (nonatomic, assign) NSInteger favorites;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger aid;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, assign) NSInteger click;

@property (assign, nonatomic)CGFloat pictureProgress;
@end
