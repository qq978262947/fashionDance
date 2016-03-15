//
//  WJConsultingNoPicCell.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/15.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJConsultingNoPicCell.h"
#import "WJConsultingResult.h"


@interface WJConsultingNoPicCell ()

@property (weak, nonatomic) IBOutlet UILabel *carTitle;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commandLabel;

@end

@implementation WJConsultingNoPicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}


+(id)consultingCellWithTableView:(UITableView *)tableView {
    NSString * className = NSStringFromClass([self class]);
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    return [tableView dequeueReusableCellWithIdentifier:className];
}

- (void)setList:(WJList *)list {
    _list = list;
    self.carTitle.text = list.title;
    self.nameLabel.text = list.author;
    self.commandLabel.text = [NSString stringWithFormat:@"%li",(long)list.brandId];
}

@end
