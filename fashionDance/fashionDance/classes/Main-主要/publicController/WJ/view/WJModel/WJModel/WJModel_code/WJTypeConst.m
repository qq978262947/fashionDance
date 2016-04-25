//
//  WJTypeConst.m
//  WJModel
//
//  Created by 汪俊 on 16/3/19.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJTypeConst.h"

/**
 *  成员变量类型（属性类型）
 */
NSString *const WJPropertyTypeInt = @"i";
NSString *const WJPropertyTypeShort = @"s";
NSString *const WJPropertyTypeFloat = @"f";
NSString *const WJPropertyTypeDouble = @"d";
NSString *const WJPropertyTypeLong = @"q";
NSString *const WJPropertyTypeChar = @"c";
NSString *const WJPropertyTypeBOOL1 = @"c";
NSString *const WJPropertyTypeBOOL2 = @"b";
NSString *const WJPropertyTypePointer = @"*";

NSString *const WJPropertyTypeIvar = @"^{objc_ivar=}";
NSString *const WJPropertyTypeMethod = @"^{objc_method=}";
NSString *const WJPropertyTypeBlock = @"@?";
NSString *const WJPropertyTypeClass = @"#";
NSString *const WJPropertyTypeSEL = @":";
NSString *const WJPropertyTypeId = @"@";