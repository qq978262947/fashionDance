//
//  TSSXCarModel.h
//  fashionDance
//
//  Created by Dylan on 3/16/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSSXCarModel : NSObject
@property (nonatomic,strong)NSString *modelUrl;
@property (nonatomic,strong)NSNumber *modelId;
@property (nonatomic,strong)NSString *modelName;
@property (nonatomic,strong)NSString *minPrice;
@property (nonatomic,strong)NSString *maxPrice;

+(instancetype)modWithDict:(NSDictionary *)dict;
@end
