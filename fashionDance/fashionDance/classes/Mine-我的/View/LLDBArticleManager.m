//
//  LLDBArticleManager.m
//  fashionDance
//
//  Created by 李璐 on 16/3/24.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "LLDBArticleManager.h"
#import "FMDatabase.h"
#import "SVProgressHUD.h"
#import "WJConsultingResult.h"

@implementation LLDBArticleManager
{
    FMDatabase *_myDatabase;
}


+ (LLDBArticleManager *)sharedManager
{
    static LLDBArticleManager *manager =nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            
            manager = [[LLDBArticleManager alloc]init];
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
        NSString *createSql = @"create table if not exists article(ID varchar primary key, picUrl varchar, author varchar, pubtime long, brandId integer,title varchar(50),subbrandId integer, modelId integer,url varchar)";
        
        BOOL flag = [_myDatabase executeUpdate:createSql];
        
        if (flag == NO) {
            
            //  NSLog(@"%@",_myDatabase.lastErrorMessage);
        }
        
    }else
    {
        // NSLog(@"%@",_myDatabase.lastErrorMessage);
    }
    
    
}

- (void)insertArticle:(WJList *)articleModel
{
    
    NSString *insertSql = @"insert into article (ID,picUrl,author,title,pubtime,brandId,subbrandId,modelId,url) values(?,?,?,?,?,?,?,?,?)";
    BOOL flag = [_myDatabase executeUpdate:insertSql,articleModel.ID,articleModel.picUrl,articleModel.author,articleModel.title,@(articleModel.pubtime),@(articleModel.brandId),@(articleModel.subbrandId),@(articleModel.modelId),articleModel.url];
    
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

- (void)deleteArticleWithID:(NSString*)ID
{
    NSString *delectSql = @"delete from article where ID =?";
    
    BOOL flag = [_myDatabase executeUpdate:delectSql,ID];
    if (flag) {
        [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
        [SVProgressHUD showImage:[UIImage imageNamed:@"new_collectBtn_normal"] status:@"取消收藏成功"];
    }
    
}

- (NSArray *)searchAllArticle
{
    NSString *selectSql = @"select * from article";
    FMResultSet *rs =[_myDatabase executeQuery:selectSql];
    NSMutableArray *arrayM = [NSMutableArray array];
    
    while ([rs next]) {
        WJList * list = [[WJList alloc]init];
        
        list.ID = [rs stringForColumn:@"ID"];
        list.picUrl = [rs stringForColumn:@"picUrl"];
        list.pubtime = [rs longLongIntForColumn:@"pubtime"];
        list.brandId = [rs intForColumn:@"brandId"];
        list.title = [rs stringForColumn:@"title"];
        list.subbrandId = [rs intForColumn:@"subbrandId"];
        list.modelId = [rs intForColumn:@"modelId"];
        list.url = [rs stringForColumn:@"url"];
        list.author = [rs stringForColumn:@"author"];
        
        [arrayM addObject:list];
        
    }
    
    return arrayM;

}
@end
