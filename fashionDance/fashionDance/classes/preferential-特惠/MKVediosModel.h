//
//  MKVediosModel.h
//  fashionDance
//
//  Created by Monky on 16/3/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class VedioResult;
@interface MKVediosModel : JSONModel
@property (nonatomic,strong)NSNumber<Optional> *code;
@property (nonatomic,strong)NSString<Optional> *msg;
@property (nonatomic,strong)VedioResult<Optional> *result;
@end

@class VedioResultList;
@protocol VedioResultList;
@interface VedioResult : JSONModel
@property (nonatomic,strong)NSNumber<Optional> *endTime;
@property (nonatomic,strong)NSNumber<Optional> *pageSize;
@property (nonatomic,strong)NSNumber<Optional> *startTime;
@property (nonatomic,strong)NSArray<VedioResultList,Optional> *newsList;
@end

@interface VedioResultList : JSONModel
@property (nonatomic,strong)NSNumber<Optional> *cmsId;
@property (nonatomic,strong)NSString<Optional> *author;
@property (nonatomic,strong)NSNumber<Optional> *createdAt;
@property (nonatomic,strong)NSString<Optional> *cmsParentName;
@property (nonatomic,strong)NSString<Optional> *columnId;
@property (nonatomic,strong)NSString<Optional> *csUrl;
@property (nonatomic,strong)NSString<Optional> *picUrl;
@property (nonatomic,strong)NSString<Optional> *title;
@property (nonatomic,strong)VedioResult<Optional> *result;
@end