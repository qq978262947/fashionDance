//
//  TSCarMod.h
//  fashionDance
//
//  Created by Dylan on 3/14/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSCarMod : NSObject
@property (nonatomic,strong) NSString * capitalPy;
@property (nonatomic,strong) NSString * logoUrl;
@property (nonatomic,strong) NSString * namePy;
@property (nonatomic,strong) NSString * nameZh;
@property (nonatomic,strong)NSNumber * ID;


+(instancetype)modWithDict:(NSDictionary *)dict;

@end
