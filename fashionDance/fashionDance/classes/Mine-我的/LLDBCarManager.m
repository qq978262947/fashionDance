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
        NSString *createSql = @"create table if not exists topic(url integer varchar key autoincrement, topicId varchar(50), isElite integer, title varchar(50), barName varchar(50), replayCount integer, nickName varchar(50), pic1 varchar(50), pic2 varchar(50), pic3 varchar(50), imgUrl varchar(50), replyCount integer, authorName varchar(50))";
        
        BOOL flag = [_myDatabase executeUpdate:createSql];
        
        if (flag == NO) {
            
            //  NSLog(@"%@",_myDatabase.lastErrorMessage);
        }
        
    }else
    {
        // NSLog(@"%@",_myDatabase.lastErrorMessage);
    }
    
    
}

@end
