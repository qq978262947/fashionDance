//
//  WJMoreAboutCarModel.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJMoreAboutCarModel.h"
#define WJCarModelFont [UIFont systemFontOfSize:17]

@implementation WJMoreAboutCarModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}


- (CGFloat)cellHeightWithIndex:(long)index {
    CGFloat cellHeight = 45;
    // 文字的最大尺寸
    CGSize maxSize = CGSizeMake(WJScreenW - 2 * 10, MAXFLOAT);
    if (index == 0) {
        cellHeight -= 6;
        // 计算文字的高度
        cellHeight += [self.satisfy boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : WJCarModelFont} context:nil].size.height;
    } else if (index == 1) {
        cellHeight -= 6;
        cellHeight += [self.dissatisfy boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : WJCarModelFont} context:nil].size.height;
    } else if (index == 2) {
        cellHeight += [self.outside boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : WJCarModelFont} context:nil].size.height;
    } else if (index == 3){
        cellHeight += [self.inside boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : WJCarModelFont} context:nil].size.height;
    } else if (index == 4){
        cellHeight += [self.space boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : WJCarModelFont} context:nil].size.height;
    } else if (index == 5){
        cellHeight += [self.power boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : WJCarModelFont} context:nil].size.height;
    } else if (index == 6){
        cellHeight += [self.oprate boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : WJCarModelFont} context:nil].size.height;
    } else if (index == 7){
        cellHeight += [self.fuelcost boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : WJCarModelFont} context:nil].size.height;
    } else if (index == 8){
        cellHeight += [self.service boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : WJCarModelFont} context:nil].size.height;
    } else if (index == 9){
        cellHeight += [self.cost_performance boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : WJCarModelFont} context:nil].size.height;
    } else {
        cellHeight += [self.others boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : WJCarModelFont} context:nil].size.height;
    }
    return cellHeight;
}


@end
@implementation WJMoreAboutCarUser

@end


