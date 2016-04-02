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
#import "YUCarDetailModel.h"
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
         NSString *createSql;
         //offSaleYearList指向nsarray，是一个nsdata
        createSql = @"create table if not exists car1(modelId integer primary key,avgScore integer,minDprice double,picFocus varchar,barId varchar,nameZh varchar,type1 varchar,rootBrandNameZh varchar,max double,offSaleYearList blob,maxDprice double,countPics integer,rootBrandId integer,engineSize1 varchar,engineSize2 varchar,min double)";
        BOOL flag = [_myDatabase executeUpdate:createSql];
         if (flag == NO) {
             
               NSLog(@"%@",_myDatabase.lastErrorMessage);
         }

         createSql = @"create table if not exists footmark(modelId integer primary key,avgScore integer,minDprice double,picFocus varchar,barId varchar,nameZh varchar,type1 varchar,rootBrandNameZh varchar,max double,offSaleYearList blob,maxDprice double,countPics integer,rootBrandId integer,engineSize1 varchar,engineSize2 varchar,min double)";
         
         flag = [_myDatabase executeUpdate:createSql];
         
        if (flag == NO) {
            
              NSLog(@"%@",_myDatabase.lastErrorMessage);
        }
         
    }else
    {
         NSLog(@"%@",_myDatabase.lastErrorMessage);
    }
    
    
}
- (void)insertCar:(YUCarDetailModel *)carModel
{
    [self insertCar:carModel toTable:@"car1"];
}
- (NSArray *)searchAllCar
{
    return [self searchCarInTable:@"car1"];
}

- (void)deleteTopicWithmodelId:(NSInteger)modelId
{
    NSString *delectSql = @"delete from car1 where modelId =?";
    
    BOOL flag = [_myDatabase executeUpdate:delectSql,modelId];
    if (flag) {
        [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
        [SVProgressHUD showImage:[UIImage imageNamed:@"new_collectBtn_normal"] status:@"取消收藏成功"];
    }
    

}


//车浏览记录
-(void)insertCarfootmark:(YUCarDetailModel *)carModel
{
    [self insertCar:carModel toTable:@"footmark"];
}

-(NSArray *)searchAllfootmark
{
    return [self searchCarInTable:@"footmark"];
}

#pragma mark 私有方法
-(NSArray *)searchCarInTable:(NSString*)tableName
{
    NSString *selectSql = [NSString stringWithFormat:@"select * from %@",tableName];
    FMResultSet *rs =[_myDatabase executeQuery:selectSql];
    NSMutableArray *arrayM = [NSMutableArray array];
    
    while ([rs next]) {
        YUCarDetailModel * list = [[YUCarDetailModel alloc]init];
        list.modelId = [rs intForColumn:@"modelId"];
        list.avgScore = [rs intForColumn:@"avgScore"];
        list.minDprice = [rs doubleForColumn:@"minDprice"];
        list.picFocus = [rs stringForColumn:@"picFocus"];
        list.barId = [rs stringForColumn:@"barId"];
        list.nameZh = [rs stringForColumn:@"nameZh"];
        list.type1 = [rs stringForColumn:@"type1"];
        list.rootBrandNameZh = [rs stringForColumn:@"rootBrandNameZh"];
        list.max = [rs doubleForColumn:@"max"];
        list.offSaleYearList = [NSKeyedUnarchiver unarchiveObjectWithData:[rs dataForColumn:@"offSaleYearList"]];
        list.maxDprice = [rs doubleForColumn:@"maxDprice"];
        list.countPics = [rs intForColumn:@"countPics"];
        list.rootBrandId = [rs intForColumn:@"rootBrandId"];
        list.engineSize1 = [rs stringForColumn:@"engineSize1"];
        list.engineSize2 = [rs stringForColumn:@"engineSize2"];
        list.min = [rs doubleForColumn:@"min"];
        
        [arrayM addObject:list];
        
    }
    
    return arrayM;
}

-(void)insertCar:(YUCarDetailModel*)carModel toTable:(NSString*)tableName
{

    NSString *insertSql = [NSString stringWithFormat:@"insert into %@ (avgScore,minDprice,picFocus,barId,nameZh,type1,rootBrandNameZh,max,offSaleYearList,maxDprice,countPics,rootBrandId,engineSize1,engineSize2,modelId,min) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",tableName];
     BOOL flag;
    //得出offSaleYearList data
    NSData * offSaleYearListData = [NSKeyedArchiver archivedDataWithRootObject:carModel.offSaleYearList];
    flag = [_myDatabase executeUpdate:insertSql,carModel.avgScore,carModel.minDprice,carModel.picFocus,carModel.barId,carModel.nameZh,carModel.type1,carModel.rootBrandNameZh,carModel.max,offSaleYearListData,carModel.maxDprice,carModel.countPics,carModel.rootBrandId,carModel.engineSize1,carModel.engineSize2,carModel.modelId,carModel.min];
    if (flag && [tableName isEqualToString:@"car1"])
    {
        [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"new_collect_selected-1"] status:@"收藏成功"];
    }
    else
    {
          NSLog(@"%@",_myDatabase.lastErrorMessage);
    }
}
@end
