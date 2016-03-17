//
//  TSPhotoCell.m
//  fashionDance
//
//  Created by Dylan on 3/17/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSPhotoCell.h"
#import "UIImageView+WebCache.h"
@interface TSPhotoCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation TSPhotoCell

+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView andindexPath:(NSIndexPath *)indexPath
{
    NSString * identifity=NSStringFromClass([self class]);
    UINib * nib=[UINib nibWithNibName:identifity bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:identifity];
    return  [collectionView dequeueReusableCellWithReuseIdentifier:identifity forIndexPath:indexPath];
}
-(void)configWithUrl:(NSString *)url
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"error"]];
}
@end
