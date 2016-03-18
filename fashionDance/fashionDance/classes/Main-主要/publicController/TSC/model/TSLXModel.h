//
//  TSLXModel.h
//  fashionDance
//
//  Created by Dylan on 3/17/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLXModel : NSObject
@property (nonatomic,strong)NSNumber * index;
@property (nonatomic,strong)NSNumber * PicId;
@property (nonatomic,strong)NSString * PicUrl;

+(instancetype)modWithDict:(NSDictionary *)dict;
@end
