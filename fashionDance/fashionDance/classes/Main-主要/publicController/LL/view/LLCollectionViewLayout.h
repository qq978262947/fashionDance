//
//  LLCollectionViewLayout.h
//  collectionlayout练习
//
//  Created by 李璐 on 16/3/11.
//  Copyright © 2016年 李璐. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLCarTypeVersionModel;

@interface LLCollectionViewLayout : UICollectionViewLayout


+(LLCollectionViewLayout *)layoutWithDataSoure:(NSArray<LLCarTypeVersionModel *>*)dataArray;

/** 数据源，为了动态计算每个cell高度，每次reload之前需要更换最新的数据源，否则数据显示有瑕疵 **/
@property(nonatomic,strong) NSArray * section1DataArray;

@end
