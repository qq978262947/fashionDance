//
//  WJTableViewCell.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJPraiseTableViewCell.h"

@interface WJPraiseTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *carNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *fuelLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *satisfyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dissatisfyLabel;


@end

@implementation WJPraiseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}


+(id)praiseTableViewCellWithTableView:(UITableView *)tableView {
    NSString * className = NSStringFromClass([self class]);
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    return [tableView dequeueReusableCellWithIdentifier:className];
}

- (void)setAppraiseList:(WJContentAppraiseModel *)appraiseList {
    _appraiseList = appraiseList;
    self.carNameLabel.text = appraiseList.carName;
    self.avgScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)appraiseList.avgScore];
    self.priceLabel.text = [NSString stringWithFormat:@"%ld", (long)appraiseList.price];
    self.fuelLabel.text = [NSString stringWithFormat:@"%ld", (long)appraiseList.fuel];
    self.distanceLabel.text = appraiseList.distance;
    self.satisfyLabel.text = appraiseList.satisfy;
    self.dissatisfyLabel.text = appraiseList.dissatisfy;
    
}



@end
