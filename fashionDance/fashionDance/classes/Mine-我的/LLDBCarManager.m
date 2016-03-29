//
//  LLDBCarManager.m
//  fashionDance
//
//  Created by 李璐 on 16/3/24.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "LLDBCarManager.h"
#import "FMDatabase.h"
#import "SVProgressHUD.h"

#import "YUCarCellModel.h"

@implementation LLDBCarManager

{
    FMDatabase *_myDatabase;
}


+ (LLDBCarManager *)sharedManager
{
    static LLDBCarManager *manager =nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            
            manager = [[LLDBCarManager alloc]init];
        }
    });
    return manager;
}

-(instancetype)init
{
    if (self = [super init])
    {
        [self createDatabase];
    }
    return self;
}
- (void)createDatabase
{
    //    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/carCategory.sqlite"];
    
    _myDatabase  = [[FMDatabase alloc]initWithPath:path];
    //   NSLog(@"%@",path);
    
    BOOL ret  = [_myDatabase open];
     if (ret) {
        NSString *createSql = @"create table if not exists car(trimId integer primary key, picUrl varchar, priceGuide double, nameZh varchar(50), drvType varchar, year integer, transType varchar(50), maxDprice double,minDprice double,trimTypeName varchar)";
        
        BOOL flag = [_myDatabase executeUpdate:createSql];
        
        if (flag == NO) {
            
            //  NSLog(@"%@",_myDatabase.lastErrorMessage);
        }
        
    }else
    {
        // NSLog(@"%@",_myDatabase.lastErrorMessage);
    }
    
    
}
- (void)insertCar:(YUCarCellModel *)carModel
{
    NSString *insertSql = @"insert into car (trimId,picUrl,priceGuide,nameZh,drvType,year,transType,maxDprice,minDprice,trimTypeName) values(?,?,?,?,?,?,?,?,?,?)";
    
    BOOL flag = [_myDatabase executeUpdate:insertSql,@(carModel.trimId),carModel.picUrl,@(carModel.priceGuide),carModel.nameZh,carModel.drvType,@(carModel.year),carModel.transType,@(carModel.maxDprice),@(carModel.minDprice),carModel.trimTypeName];
    
    if (flag)
    {
        [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"new_collect_selected-1"] status:@"收藏成功"];
    }
    else
    {
        //  NSLog(@"%@",_myDatabase.lastErrorMessage);
    }

}
/*
 gn) NSInteger trimId;
 ) NSString *picUrl;
 ) NSString *nameZh;
 gn) CGFloat priceGuide;
 ) NSString *drvType;
 gn) NSInteger year;
 gn) CGFloat maxDprice;
 ) NSString *transType;
 gn) CGFloat minDprice;
 ) NSString *trimTypeName;
 */

- (NSArray *)searchAllCar
{
    NSString *selectSql = @"select * from car";
    FMResultSet *rs =[_myDatabase executeQuery:selectSql];
    NSMutableArray *arrayM = [NSMutableArray array];
    
    while ([rs next]) {
        YUCarCellModel * list = [[YUCarCellModel alloc]init];
        
        list.trimId = [rs intForColumn:@"trimId"];
        list.picUrl = [rs stringForColumn:@"picUrl"];
        list.nameZh = [rs stringForColumn:@"nameZh"];
        list.priceGuide = [rs doubleForColumn:@"priceGuide"];
        list.drvType = [rs stringForColumn:@"drvType"];
        list.year = [rs intForColumn:@"year"];
        list.maxDprice = [rs doubleForColumn:@"maxDprice"];
        list.minDprice = [rs doubleForColumn:@"minDprice"];
        list.transType = [rs stringForColumn:@"transType"];
        list.trimTypeName = [rs stringForColumn:@"trimTypeName"];
        
        [arrayM addObject:list];
        
    }
    
    return arrayM;

}

- (void)deleteTopicWithTrimID:(NSInteger)trimId
{
    NSString *delectSql = @"delete from car where trimId =?";
    
    BOOL flag = [_myDatabase executeUpdate:delectSql,trimId];
    if (flag) {
        [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
        [SVProgressHUD showImage:[UIImage imageNamed:@"new_collectBtn_normal"] status:@"取消收藏成功"];
    }
    

}

@end
