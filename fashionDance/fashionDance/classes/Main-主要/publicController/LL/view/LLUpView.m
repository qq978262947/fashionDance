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
        view.layer.borderColor = [UIColor blackColor].CGColor;
        view.layer.borderWidth = 2.0;
        lastButton = view;
        i++;
    }//end forin
}

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
