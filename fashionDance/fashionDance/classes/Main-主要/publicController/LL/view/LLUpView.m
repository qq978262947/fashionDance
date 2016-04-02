//
//  LLUpView.m
//  汽车－参数页面
//
//  Created by 李璐 on 16/3/18.
//  Copyright © 2016年 李璐. All rights reserved.
//

#import "LLUpView.h"
#import "LLParameterModel.h"

@interface LLUpView ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftWidthCon;


@property(strong,nonatomic)NSArray * lableArray;
//@property(nonatomic,weak)UIButton * upButton;
//@property(nonatomic,weak)UIButton * downButton;
//@property(nonatomic,weak)UIScrollView * scrollView;

@end

@implementation LLUpView

-(void)setData:(NSArray *)data
{
    _data = data;
    
    for (UIView * view in self.lableArray) {
        [view removeFromSuperview];
    }
    self.lableArray = nil;
    
    int i = 0;
    UILabel * lastButton;
    for (LLParameterModel * model in data) {
        UILabel * view = [[UILabel alloc]init];
        [self.scrollViewX addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.equalTo(self.scrollViewX.mas_left).offset(0);
            }
            else
            {
                make.left.equalTo(lastButton.mas_right).offset(0);
            }
            make.bottom.equalTo(self.scrollViewX).offset(0);
            make.top.equalTo(self.scrollViewX).offset(0);
            make.height.width.equalTo(@(self.widthCell));
            
            if (i == self.data.count - 1) {
                make.trailing.equalTo(self.scrollViewX).offset(-0);
            }
        }];
        view.numberOfLines = 0;
        view.text = [NSString stringWithFormat:@"%@ %@款 %@",model.MODELNAME,model.YEAR,model.NAME];
        view.layer.borderColor = [UIColor grayColor].CGColor;
        view.layer.borderWidth = 1.5;
        view.textAlignment = NSTextAlignmentCenter;
        lastButton = view;
        i++;
    }//end forin
}

-(void)setLeftWidth:(CGFloat)leftWidth
{
    _leftWidth = leftWidth;
    
    [self.leftWidthCon setConstant:(leftWidth-1)];
}

-(void)awakeFromNib
{
    //注册通知
    NSNotificationCenter * defualtCenter = [NSNotificationCenter defaultCenter];
    //接受来自任何类的LLScroll通知
    [defualtCenter addObserver:self selector:@selector(scrollNotificationHandle:) name:@"LLScroll" object:nil];
}

-(void)scrollNotificationHandle:(NSNotification*)notification
{
    if (![notification.object isEqual:self]) {
        UIScrollView * view = [notification.userInfo objectForKey:@"scrollView"];
        self.scrollViewX.contentOffset = CGPointMake(view.contentOffset.x, self.scrollViewX.contentOffset.y);
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSNotificationCenter * defualtCenter = [NSNotificationCenter defaultCenter];
    
    [defualtCenter postNotificationName:@"LLScroll" object:self userInfo:@{@"scrollView":scrollView}];
}

//-(void)willMoveToSuperview:(UIView *)newSuperview
//{
//    
//    //测试用的content offset
//    self.scrollViewX.contentSize = CGSizeMake(self.data.count * self.widthCell, self.scrollViewX.frame.size.height);
//}

-(void)dealloc
{
    NSNotificationCenter * defualtCenter = [NSNotificationCenter defaultCenter];
    [defualtCenter removeObserver:self];
}
@end
