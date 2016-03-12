//
//  WJCollectionViewCell.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJCollectionViewCell.h"
#import "WJFindCarResult.h"
#import "UIImageView+downloadImage.h"

@interface WJCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *carName;
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@property (weak, nonatomic) IBOutlet UILabel *carPrice;
@property (weak, nonatomic) IBOutlet UILabel *carData;

@end

@implementation WJCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


+(id)collectionCellCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    //1.加载xib,注册
    NSString * className = NSStringFromClass([self class]);
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:className];
    
    //2.在缓存池中取
    return [collectionView dequeueReusableCellWithReuseIdentifier:className forIndexPath:indexPath];
}

- (void)setCarResult:(WJFindCarResult *)carResult {
    _carResult = carResult;
    [self.carImageView setNormalImagewithURL:[NSURL URLWithString:carResult.picUrl]  placeholderImage:[UIImage imageNamed:@"FollowBtnClickBg"] completed:nil];
    self.carName.text = carResult.modelName;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:carResult.pubDate / 1000];
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"MM-dd";
    NSString *dateString = [fmt stringFromDate:date];
    
    self.carData.text = dateString;
    if (carResult.priceMax == 0) {
        self.carPrice.text = @"尚未上市";
    }else {
        self.carPrice.text = [NSString stringWithFormat:@"%i-%i万",(int)carResult.priceMin, (int)carResult.priceMax];
    }
}

@end
