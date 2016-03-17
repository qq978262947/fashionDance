//
//  YUDBManager.m
//  Test
//
//  Created by qianfeng on 16/1/9.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "YUDBManager.h"
#import "FMDatabase.h"
#import "YUHotTopicModel.h"
#import "SVProgressHUD.h"

@implementation YUDBManager

{
    FMDatabase *_myDatabase;
}


+ (YUDBManager *)sharedManager
{
    static YUDBManager *manager =nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            
            manager = [[YUDBManager alloc]init];
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
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/topic.sqlite"];
    
    _myDatabase  = [[FMDatabase alloc]initWithPath:path];
 //   NSLog(@"%@",path);
    
    BOOL ret  = [_myDatabase open];
    
    if (ret) {
        NSString *createSql = @"create table if not exists topic(bid integer primary key autoincrement, topicId varchar(50), isElite integer, title varchar(50), barName varchar(50), replayCount integer, nickName varchar(50), pic1 varchar(50), pic2 varchar(50), pic3 varchar(50), imgUrl varchar(50), replyCount integer, authorName varchar(50))";
        
        BOOL flag = [_myDatabase executeUpdate:createSql];
        
        if (flag == NO) {
            
          //  NSLog(@"%@",_myDatabase.lastErrorMessage);
        }
        
    }else
    {
       // NSLog(@"%@",_myDatabase.lastErrorMessage);
    }
    
    
}
- (void)insertTopic:(YUHotTopicModel *)topic;
{
    NSString *insertSql = @"insert into topic (bid,topicId,isElite,title,barName,replayCount,nickName,pic1,pic2,pic3,imgUrl,replyCount,authorName) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
    
    BOOL flag = [_myDatabase executeUpdate:insertSql,@(topic.bid),topic.topicId,@(topic.isElite),topic.title,topic.barName,@(topic.replayCount),topic.nickName,topic.pic1,topic.pic2,topic.pic3,topic.imgUrl,@(topic.replyCount),topic.authorName];
    
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

- (NSArray *)searchAllTopic;
{
    NSString *selectSql = @"select * from topic";
    FMResultSet *rs =[_myDatabase executeQuery:selectSql];
    NSMutableArray *arrayM = [NSMutableArray array];
    
    while ([rs next]) {
        YUHotTopicModel *topic = [[YUHotTopicModel alloc]init];
        
        topic.bid = [rs intForColumn:@"bid"];
        topic.topicId = [rs stringForColumn: @"topicId"];
        topic.isElite = [rs boolForColumn:@"isElite"];
        topic.title = [rs stringForColumn: @"title"];
        topic.barName = [rs stringForColumn:@"barName"];
        topic.replayCount = [rs intForColumn:@"replayCount"];
        topic.nickName = [rs stringForColumn: @"nickName"];
        topic.pic1 = [rs stringForColumn: @"pic1"];
        topic.pic2 = [rs stringForColumn: @"pic2"];
        topic.pic3 = [rs stringForColumn: @"pic3"];
        topic.imgUrl = [rs stringForColumn: @"imgUrl"];
        topic.authorName = [rs stringForColumn: @"authorName"];
        topic.replyCount = [rs intForColumn:@"replyCount"];
        
        [arrayM addObject:topic];
        
    }
    
    return arrayM;
}

//- (void)updateNews:(YUNews *)news withNewsId:(NSInteger)newsId
//{
//    
//    NSString *updateSql = @"update news set title=? ,time=? ,image=? ,nid=?,where newsId =?";
//    
//    BOOL flag =  [_myDatabase executeUpdate:updateSql,news.title,news.createTime,news.header_img_url,news.nid,@(newsId)];
//    if (flag == NO) {
//        
//        NSLog(@"%@",_myDatabase.lastErrorMessage);
//        
//    }
//    
//}
- (void)deleteTopicWithID:(NSInteger)bid
{
    NSString *delectSql = @"delete from topic where bid =?";
    
    BOOL flag = [_myDatabase executeUpdate:delectSql,@(bid)];
    if (flag) {
        [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
        [SVProgressHUD showImage:[UIImage imageNamed:@"new_collectBtn_normal"] status:@"取消收藏成功"];
    }
    
}

-(void)deleteCollectWithTopic:(YUHotTopicModel *)topic
{
    [self deleteTopicWithID:topic.bid];
}

@end
