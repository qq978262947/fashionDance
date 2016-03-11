//
//  WJConsultingCell.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJConsultingCell.h"
#import "WJConsultingResult.h"
#import "UIImageView+downloadImage.h"

@interface WJConsultingCell ()
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@property (weak, nonatomic) IBOutlet UILabel *carTitle;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commandLabel;

@end

@implementation WJConsultingCell

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
    [self.carImageView setNormalImagewithURL:[NSURL URLWithString:list.picUrl]  placeholderImage:[UIImage imageNamed:@"FollowBtnClickBg"] completed:nil];
    self.carTitle.text = list.title;
    self.nameLabel.text = list.author;
    self.commandLabel.text = [NSString stringWithFormat:@"%li",(long)list.subbrandId];
}

@end
