//
//  LLDBArticleManager.h
//  fashionDance
//
//  Created by 李璐 on 16/3/24.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WJList;
@interface LLDBArticleManager : NSObject

+ (LLDBArticleManager *)sharedManager;

- (void)createDatabase;

- (void)insertArticle:(WJList *)articleModel;

- (NSArray *)searchAllArticle;

- (void)deleteArticleWithID:(NSString*)ID;
@end
