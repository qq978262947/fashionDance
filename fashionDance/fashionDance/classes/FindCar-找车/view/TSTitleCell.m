//
//  TSTitleCell.m
//  fashionDance
//
//  Created by Dylan on 3/15/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSTitleCell.h"

@implementation TSTitleCell

+(TSTitleCell *)cellWithTableView:(UITableView *)tableView
{
    NSString * identifity=NSStringFromClass([self class]);
    UINib * nib=[UINib nibWithNibName:identifity bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifity];
    return [tableView dequeueReusableCellWithIdentifier:identifity];
}

@end
