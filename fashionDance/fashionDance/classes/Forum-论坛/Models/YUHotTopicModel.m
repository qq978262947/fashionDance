//
//  YUHotTopicModel.m
//  fashionDance
//
//  Created by qianfeng on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUHotTopicModel.h"

@implementation YUHotTopicModel

+ (NSDictionary *)objectClassInArray{
    return @{@"pics" : [Pics class]};
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"topicDescription" : @"description",
             @"pic1" : @"pics[0].url",
             @"pic2" : @"pics[1].url",
             @"pic3" : @"pics[2].url",
             };
}

- (void)setHotTopicCellH:(CGFloat)hotTopicCellH
{
    _hotTopicCellH = hotTopicCellH;
    
    if (self.pics.count > 0) {
        
        
    }
    
}

@end

@implementation Pics

@end


