//
//  TSCarPicMod.h
//  fashionDance
//
//  Created by Dylan on 3/17/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSCarPicMod : NSObject
@property (nonatomic,strong)NSNumber * colorId;
@property (nonatomic,strong)NSString * colorOpt;
@property (nonatomic,strong)NSNumber * flagType;
@property (nonatomic,strong)NSNumber * flagView;
@property (nonatomic,strong)NSNumber * ID;
@property (nonatomic,strong)NSNumber * modelId;
@property (nonatomic,strong)NSNumber * trimId;
@property (nonatomic,strong)NSString * url;

+(instancetype)modWithDict:(NSDictionary *)dict;
@end
