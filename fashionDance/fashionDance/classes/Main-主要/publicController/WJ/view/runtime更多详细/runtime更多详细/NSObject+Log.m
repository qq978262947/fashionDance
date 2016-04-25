//
//  NSObject+Log.m
//  runtime更多详细
//
//  Created by 汪俊 on 16/3/19.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "NSObject+Log.h"

@implementation NSObject (Log)// 自动打印属性字符串

+ (void)resolveDict:(NSDictionary *)dict{	// 拼接属性字符串代码
    NSMutableString *strM = [NSMutableString string];	// 1.遍历字典，把字典中的所有key取出来，生成对应的属性代码
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // 类型经常变，抽出来
        NSString *type;
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFString")]) {
            type = @"NSString";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFArray")]){
            type = @"NSArray";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")]){
            type = @"int";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFDictionary")]){
            type = @"NSDictionary";
        }		// 属性字符串
        NSString *str;
        if ([type containsString:@"NS"]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, strong) %@ *%@;",type,key];
        }else{
            str = [NSString stringWithFormat:@"@property (nonatomic, assign) %@ %@;",type,key];
        }		// 每生成属性字符串，就自动换行。
        [strM appendFormat:@"\n%@\n",str];
    }];	// 把拼接好的字符串打印出来，就好了。
    NSLog(@"%@",strM);
}


@end
