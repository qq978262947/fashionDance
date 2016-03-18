//
//  TSPicReusableView.h
//  fashionDance
//
//  Created by Dylan on 3/17/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSPicReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+(instancetype)cellWithTableView:(UICollectionView *)collectionView andindexPath:(NSIndexPath *)indexPath;
-(void)configWithString:(NSString *)title;

@end
