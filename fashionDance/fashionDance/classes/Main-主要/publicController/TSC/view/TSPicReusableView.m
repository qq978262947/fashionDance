//
//  TSPicReusableView.m
//  fashionDance
//
//  Created by Dylan on 3/17/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSPicReusableView.h"

@implementation TSPicReusableView

+(instancetype)cellWithTableView:(UICollectionView *)collectionView andindexPath:(NSIndexPath *)indexPath
{
    NSString * identifity=NSStringFromClass([self class]);
    UINib * nib=[UINib nibWithNibName:identifity bundle:nil];
    [collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];;
}
-(void)configWithString:(NSString *)title
{
    self.titleLabel.text=title;
}
@end
