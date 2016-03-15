//
//  TSCarMod.h
//  fashionDance
//
//  Created by Dylan on 3/14/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSCarMod : NSObject
/**
 *  logoUrl : http://m4.auto.itc.cn/c_zoom,w_160/logo/brand/339.png,
	namePy : ruhu,
	id : 339,
	nameZh : 如虎,
	capitalPy : R
 */
@property (nonatomic,strong) NSString * capitalPy;
@property (nonatomic,strong) NSString * logoUrl;
@property (nonatomic,strong) NSString * namePy;
@property (nonatomic,strong) NSString * nameZh;
@property (nonatomic,strong)NSNumber * cid;



@end
