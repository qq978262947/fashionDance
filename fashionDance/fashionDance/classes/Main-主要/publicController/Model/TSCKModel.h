//
//  TSCKModel.h
//  fashionDance
//
//  Created by Dylan on 3/17/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSCKModel : NSObject

@property (nonatomic,strong)NSNumber * imageCount;
@property (nonatomic,assign)BOOL isOnsale;
@property (nonatomic,strong)NSNumber * trimId;
@property (nonatomic,strong)NSString * trimName;
@property (nonatomic,strong)NSString * year;

+(instancetype)modWithDictionary:(NSDictionary *)dict;
@end
