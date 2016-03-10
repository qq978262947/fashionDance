//
//  WJSpecialVideoCell.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/9.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJSpecialVideoCell.h"
#import "WJProgressView.h"
#import <UIImageView+WebCache.h>

@interface WJSpecialVideoCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *VideoImageView;
@property (weak, nonatomic) IBOutlet UILabel *favoritesLabel;

@property (weak, nonatomic) IBOutlet UILabel *clickLabel;
@property (weak, nonatomic) IBOutlet WJProgressView *progressView;

@end

@implementation WJSpecialVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}


+(id)specialCellWithTableView:(UITableView *)tableView {
    NSString * className = NSStringFromClass([self class]);
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    return [tableView dequeueReusableCellWithIdentifier:className];
}


- (void)setList:(WJSpecialList *)list {
    _list = list;
    
    // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
    [self.progressView setProgress:list.pictureProgress animated:NO];
    self.titleLabel.text = list.title;
    self.favoritesLabel.text = [NSString stringWithFormat:@"喜欢:%li",(long)list.favorites];
    self.clickLabel.text = [NSString stringWithFormat:@"点击:%li",(long)list.click];
    [self.VideoImageView sd_setImageWithURL:[NSURL URLWithString:list.cover] placeholderImage:[UIImage imageNamed:@"FollowBtnClickBg"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        // 计算进度值
        list.pictureProgress = 1.0 * receivedSize / expectedSize;
        // 显示进度值
        [self.progressView setProgress:list.pictureProgress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

@end
