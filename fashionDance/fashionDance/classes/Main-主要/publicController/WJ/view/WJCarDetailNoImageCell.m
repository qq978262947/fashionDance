//
//  WJCarDetailNoImageCell.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/18.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJCarDetailNoImageCell.h"

@interface WJCarDetailNoImageCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLael;

@property (weak, nonatomic) IBOutlet UILabel *commandLabel;


@end

@implementation WJCarDetailNoImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}


+ (id)carDetailWordCellWithTableView:(UITableView *)tableView {
    NSString * className = NSStringFromClass([self class]);
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    return [tableView dequeueReusableCellWithIdentifier:className];
}

- (void)setAppraiseModel:(WJMoreAboutCarModel *)appraiseModel WithIndex:(long)index {
    if (index == 2) {
        if ([appraiseModel.outside isEqualToString:@""] || appraiseModel.outside == nil) {
            appraiseModel.outside = @"暂无最新的外饰信息";
        }
        self.titleLael.text = @"外观";
        self.commandLabel.text = appraiseModel.outside;
    } else if (index == 3){
        if ([appraiseModel.inside isEqualToString:@""] || appraiseModel.inside == nil) {
            appraiseModel.inside = @"暂无最新的内饰信息";
        }
        self.titleLael.text = @"内饰";
        self.commandLabel.text = appraiseModel.inside;
    } else if (index == 4){
        if ([appraiseModel.space isEqualToString:@""] || appraiseModel.space == nil) {
            appraiseModel.space = @"暂无最新的空间信息";
        }
        self.titleLael.text = @"空间";
        self.commandLabel.text = appraiseModel.space;
    } else if (index == 5){
        if ([appraiseModel.power isEqualToString:@""] || appraiseModel.power == nil) {
            appraiseModel.power = @"暂无最新的动力信息";
        }
        self.titleLael.text = @"动力";
        self.commandLabel.text = appraiseModel.power;
    } else if (index == 6){
        if ([appraiseModel.oprate isEqualToString:@""] || appraiseModel.oprate == nil) {
            appraiseModel.oprate = @"暂无最新的操控信息";
        }
        self.titleLael.text = @"操控";
        self.commandLabel.text = appraiseModel.oprate;
    } else if (index == 7){
        if ([appraiseModel.fuelcost isEqualToString:@""] || appraiseModel.fuelcost == nil) {
            appraiseModel.fuelcost = @"暂无最新的油耗信息";
        }
        self.titleLael.text = @"油耗";
        self.commandLabel.text = appraiseModel.fuelcost;
    } else if (index == 8){
        if ([appraiseModel.service isEqualToString:@""] || appraiseModel.service == nil) {
            appraiseModel.service = @"暂无最新的舒适信息";
        }
        self.titleLael.text = @"舒适";
        self.commandLabel.text = appraiseModel.service;
    } else if (index == 9){
        if ([appraiseModel.cost_performance isEqualToString:@""] || appraiseModel.cost_performance == nil) {
            appraiseModel.cost_performance = @"暂无最新的性价信息";
        }
        self.titleLael.text = @"性价";
        self.commandLabel.text = appraiseModel.cost_performance;
    } else {
        if ([appraiseModel.others isEqualToString:@""] || appraiseModel.others == nil) {
            appraiseModel.others = @"暂无最新的其它信息";
        }
        self.titleLael.text = @"其它";
        self.commandLabel.text = appraiseModel.others;
    }
}

@end
