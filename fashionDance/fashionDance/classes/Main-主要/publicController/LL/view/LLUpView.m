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
@property (weak, nonatomic) IBOutlet UIButton *upButtonX;
@property (weak, nonatomic) IBOutlet UIButton *downButtonX;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftWidthCon;

//@property(nonatomic,weak)UIButton * upButton;
//@property(nonatomic,weak)UIButton * downButton;
//@property(nonatomic,weak)UIScrollView * scrollView;

@end

@implementation LLUpView

-(void)setLeftWidth:(CGFloat)leftWidth
{
    _leftWidth = leftWidth;
    
    [self.leftWidthCon setConstant:100];
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
        self.scrollViewX.contentOffset = CGPointMake(view.contentOffset.x, 0);
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSNotificationCenter * defualtCenter = [NSNotificationCenter defaultCenter];
    
    [defualtCenter postNotificationName:@"LLScroll" object:self userInfo:@{@"scrollView":scrollView}];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    
    //测试用的content offset
    self.scrollViewX.contentSize = CGSizeMake(self.data.count * self.widthCell, self.scrollViewX.frame.size.height);
    CAGradientLayer * layer = [CAGradientLayer layer];
    [layer setFrame:self.scrollViewX.bounds];
    layer.locations = @[@0.25,@0.5,@0.75];
    layer.colors = @[(id)WArcColor.CGColor,(id)WArcColor.CGColor,(id)WArcColor.CGColor,(id)WArcColor.CGColor];
    [self.scrollViewX.layer addSublayer:layer];
}

-(void)dealloc
{
    NSNotificationCenter * defualtCenter = [NSNotificationCenter defaultCenter];
    [defualtCenter removeObserver:self];
}
/**
 * 含有两个button，一个scroll view
 */

//-(UIButton *)upButton
//{
//    if (!_upButton) {
//        UIButton * view = [[UIButton alloc]init];
//        [self addSubview:view];
//        _upButton = view;
//
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(0).offset(16);
//            make.leading.equalTo(0).offset(16);
//            make.width.equalTo(@(self.leftWidth));
//            make.bottom.equalTo(self.downButton).offset(16);
//            make.right.equalTo(self.scrollView).offset(16);
//        }];
//        [view setBackgroundColor:WArcColor];
//
//    }
//    return _upButton;
//}
//
//-(UIButton *)downButton
//{
//    if (!_downButton) {
//        UIButton * view = [[UIButton alloc]init];
//        [self addSubview:view];
//        _downButton = view;
//
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.equalTo(@(self.leftWidth));
//            make.leading.equalTo(0).offset(16);
//            make.bottom.equalTo(0).offset(16);
//            make.right.equalTo(self.scrollView).offset(16);
//        }];
//        [view setBackgroundColor:WArcColor];
//
//    }
//    return _downButton;
//}
//
//-(UIScrollView *)scrollView
//{
//    if (!_scrollView) {
//        UIScrollView * view = [[UIScrollView alloc]init];
//        _scrollView = view;
//        [self addSubview:view];
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.trailing.equalTo(0);
//            make.top.equalTo(0);
//            make.bottom.equalTo(0);
//        }];
//        [view setBackgroundColor:WArcColor];
//    }
//    return _scrollView;
//}
//
//-(void)willMoveToSuperview:(UIView *)newSuperview
//{
//    [self upButton];
//    [self downButton];
//    [self scrollView];
//}
@end
