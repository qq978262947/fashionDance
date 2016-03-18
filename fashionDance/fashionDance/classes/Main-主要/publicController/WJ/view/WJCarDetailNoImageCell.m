//
//  WJCarDetailNoImageCell.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/18.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJCarDetailNoImageCell.h"

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

- (void)setAppraiseModel:(WJMoreAboutCarModel *)appraiseModel {
    _appraiseModel = appraiseModel;
}

@end
