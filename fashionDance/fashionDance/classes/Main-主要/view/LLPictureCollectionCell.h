//
//  LLPictureCollectionCell.h
//  fashionDance
//
//  Created by 李璐 on 16/3/12.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLCarTypeInfoModel.h"

typedef void(^IsSaleDataChangedBlock)(BOOL isSale);

@interface LLPictureCollectionCell : UICollectionViewCell

@property(nonatomic,strong)LLCarTypeInfoModel * data;

/**
 * 在售还是停售改变时调用
 */
@property(nonatomic,copy)IsSaleDataChangedBlock isSaleDataChangedBlock;

@end
