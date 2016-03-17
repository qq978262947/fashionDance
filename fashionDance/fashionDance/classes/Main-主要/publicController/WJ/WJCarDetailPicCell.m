//
//  WJCarDetailPicCell.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJCarDetailPicCell.h"
#import "UIImageView+downloadImage.h"

@interface WJCarDetailPicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@end

@implementation WJCarDetailPicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}


+ (id)carDetailPicCellWithTableView:(UITableView *)tableView {
    NSString * className = NSStringFromClass([self class]);
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    return [tableView dequeueReusableCellWithIdentifier:className];
}

- (void)setPicUrlString:(NSString *)picUrlString {
    _picUrlString = [picUrlString copy];
    [self.picImageView setNormalImagewithURL:[NSURL URLWithString:picUrlString] placeholderImage:[UIImage imageNamed:@"FollowBtnClickBg"] completed:nil];
    WJLog(@"%@",picUrlString);
}


@end
