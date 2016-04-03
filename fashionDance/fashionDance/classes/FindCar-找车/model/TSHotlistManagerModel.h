//
//  TSHotlistManagerModel.h
//  fashionDance
//
//  Created by 李璐 on 16/4/3.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSHotlistManagerModel : NSObject

@property(nonatomic,strong)NSString * pageCount;
@property(nonatomic,strong)NSString * pageIndex;
@property(nonatomic,strong)NSString * pageSize;
@property(nonatomic,strong)NSString * itemCount;

//自己后期给的辅助网络请求的值
@property(nonatomic,assign)int number;
@end
