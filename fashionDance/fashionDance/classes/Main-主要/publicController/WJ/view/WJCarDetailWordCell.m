//
//  WJCarDetailWordCell.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJCarDetailWordCell.h"

@interface WJCarDetailWordCell ()
@property (weak, nonatomic) IBOutlet UILabel *ImageLabel;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation WJCarDetailWordCell

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
    if (0 == index) {
        self.ImageLabel.text = @"😄";
        self.title.text = @"最满意";
        self.descLabel.text = [appraiseModel.satisfy isEqualToString:@""] || appraiseModel.satisfy == nil ? @"暂无最满意评论" : appraiseModel.satisfy;
    } else if(1 == index) {
        self.ImageLabel.text = @"😫";
        self.title.text = @"最不满意";
        self.descLabel.text = [appraiseModel.dissatisfy isEqualToString:@""] || appraiseModel.dissatisfy == nil ? @"暂无最不满意评论" : appraiseModel.dissatisfy;
    }
    
    
}


@end
