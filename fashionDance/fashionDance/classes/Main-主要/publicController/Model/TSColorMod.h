//
//  TSColorMod.h
//  fashionDance
//
//  Created by Dylan on 3/17/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSColorMod : NSObject
@property (nonatomic,strong)NSString * colorName;
@property (nonatomic,strong)NSString * colorValue1;
@property (nonatomic,strong)NSString * colorValue2;
@property (nonatomic,strong)NSNumber * ID;
@property (nonatomic,strong)NSString * modelId;

+(instancetype)modWithDict:(NSDictionary *)dict;
@end
