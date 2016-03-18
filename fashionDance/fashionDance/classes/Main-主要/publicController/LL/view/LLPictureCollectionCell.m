//
//  LLPictureCollectionCell.m
//  fashionDance
//
//  Created by 李璐 on 16/3/12.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "LLPictureCollectionCell.h"
#import "UIImageView+downloadImage.h"
#import "UIImage+Color.h"


@interface LLPictureCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *picFocus;
@property (weak, nonatomic) IBOutlet UILabel *countPics;
@property (weak, nonatomic) IBOutlet UILabel *Dprice;

@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *saleButton;
@property (weak, nonatomic) IBOutlet UIButton *offSaleButton;
@end

@implementation LLPictureCollectionCell

-(void)awakeFromNib
{
    [self.saleButton setSelected:YES];
}

-(void)setData:(LLCarTypeInfoModel *)data
{
    _data = data;
    
    NSURL * url = [NSURL URLWithString:data.picFocus];
    [self.picFocus setNormalImagewithURL:url placeholderImage:[UIImage imageWithColor:[UIColor grayColor]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //
    }];
    self.countPics.text = [NSString stringWithFormat:@"共%ld张图片",(long)data.countPics];
}
- (IBAction)saleDataChanged:(UIButton*)sender
{
    WJLog(@"sale change button click");
    if ([sender isEqual:self.saleButton]) {
        self.offSaleButton.selected = NO;
        self.isSaleDataChangedBlock(YES);
    }
    else
    {
        self.saleButton.selected = NO;
        self.isSaleDataChangedBlock(NO);
    }
    sender.selected = YES;
}

@end
