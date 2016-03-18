//
//  TSPhotoCell.h
//  fashionDance
//
//  Created by Dylan on 3/17/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSPhotoCell : UICollectionViewCell
+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView andindexPath:(NSIndexPath *)indexPath;
-(void)configWithUrl:(NSString *)url;


@end
