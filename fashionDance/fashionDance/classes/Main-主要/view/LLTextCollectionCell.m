//
//  LLTextCollectionCell.m
//  fashionDance
//
//  Created by 李璐 on 16/3/12.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "LLTextCollectionCell.h"

@interface LLTextCollectionCell ()
@property (weak, nonatomic) IBOutlet UILabel *year;

@property (weak, nonatomic) IBOutlet UILabel *minPrice;
@property (weak, nonatomic) IBOutlet UILabel *is2S;
@property (weak, nonatomic) IBOutlet UILabel *typeDetail;
@property (weak, nonatomic) IBOutlet UILabel *priceGuide;
@property (weak, nonatomic) IBOutlet UIButton *addToCompare;
@property (weak, nonatomic) IBOutlet UIButton *budget;
@property (weak, nonatomic) IBOutlet UIButton *source2S;
@end

@implementation LLTextCollectionCell

-(void)setData:(LLCarTypeVersionModel *)data
{
    _data = data;
    
    //判断是否需要隐藏is2S
    if (data.isSale) {
        self.is2S.hidden = YES;
    }
    self.year.text = [[data.year stringValue] stringByAppendingString:data.nameZh];
    self.typeDetail.text = [data.drvType stringByAppendingString:data.transType];
    self.minPrice.text = [data.minDprice stringValue];
    self.priceGuide.text = [NSString stringWithFormat:@"%f",data.priceGuide];

}

@end
