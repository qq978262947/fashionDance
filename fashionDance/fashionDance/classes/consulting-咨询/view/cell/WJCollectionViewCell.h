//
//  WJCollectionViewCell.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJFindCarResult;

@interface WJCollectionViewCell : UICollectionViewCell

+(id)collectionCellCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) WJFindCarResult *carResult;

@end
