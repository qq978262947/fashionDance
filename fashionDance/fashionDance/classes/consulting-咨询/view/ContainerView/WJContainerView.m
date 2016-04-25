//
//  WJButtonContainerView.m
//  舞吧
//
//  Created by 汪俊 on 16/2/23.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJContainerView.h"

// 按钮的高度
const float buttonHeight = 30;

@interface WJContainerView ()
// 存放按钮的view
@property (weak, nonatomic)UIView *buttonsView;
// 存放指示器的view
@property (weak, nonatomic)UIView *indicatorView;
// 存放按钮的数组
@property (strong, nonatomic)NSMutableArray *btnsArray;
// 判断指示器位置的变量
@property (assign, nonatomic)NSInteger index;
// 保存布局约束条件
//@property (strong, nonatomic)MASConstraint *leftConstraint;

@end


@implementation WJContainerView

- (NSMutableArray *)btnsArray{
    if (nil == _btnsArray) {
        _btnsArray = [NSMutableArray array];
    }
    return _btnsArray;
}

+ (instancetype)containerView{
    return [[self alloc]initWithFrame:CGRectZero];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupButtonsView];
    self.backgroundColor = [UIColor clearColor];
    _index = 0;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupButtonsView];
        self.backgroundColor = [UIColor clearColor];
        _index = 0;
    }
    return self;
}

- (void)setupButtonsView{
    // 创建存放按钮的视图
    UIView *buttonsView = [[UIView alloc]init];
    [self addSubview:buttonsView];
    self.buttonsView = buttonsView;
    
    buttonsView.backgroundColor = [UIColor clearColor];
    // 创建存放指示器的视图
    UIView *indicatorView = [[UIView alloc]init];
    [self addSubview:indicatorView];
    self.indicatorView = indicatorView;
    indicatorView.backgroundColor = [UIColor clearColor];
    // 配置默认动画效果
    [self setupAnimation];
}
/**
 *  配置默认动画效果
 */
- (void)setupAnimation{
    self.isOpenAnimation = YES;
    self.animationTime = 0.25;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 布局按钮的父空间
    [self configButtonsView];
    // 布局按钮
    [self configButtons];
    // 布局指示器
    [self configIndicatorView];
}

// 布局指示器
- (void)configIndicatorView{
    UIButton *btn = self.btnsArray[self.index];
    __weak typeof(self) weakSelf = self;
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn);
        make.top.equalTo(weakSelf.buttonsView.mas_bottom);
        make.width.equalTo(btn.titleLabel);
        make.height.equalTo(@5);
    }];
}

// 布局按钮
- (void)configButtons{
    UIButton *lastButton = nil;
    for (UIButton *btn in self.btnsArray) {
        __weak typeof(self) weakSelf = self;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(weakSelf.width / weakSelf.btnsArray.count));
            make.left.equalTo((lastButton == nil) ? @0 : lastButton.mas_right);
            make.top.equalTo(@0);
            make.height.equalTo(@(buttonHeight));
            
        }];
        lastButton = btn;
    }

}

// 配置存放button的视图
- (void)configButtonsView{
    __weak typeof(self) weakSelf = self;
    [self.buttonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(weakSelf);
        make.height.equalTo(@(buttonHeight));
    }];
}

- (void)setTitles:(NSArray *)titles{
    _titles = [titles copy];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        //        [button layoutIfNeeded]; // 强制布局(强制更新子控件的frame)
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        // 让按钮内部的label根据文字内容来计算尺寸
        [button.titleLabel sizeToFit];
        [self.buttonsView addSubview:button];
        [self.btnsArray addObject:button];
    
//        button.backgroundColor = [UIColor whiteColor];
    }
    UIButton *btn = self.btnsArray[_index];
    btn.selected = YES;
    btn.userInteractionEnabled = NO;
}


/**
 *  点击按钮调用的方法
 *
 *  @param btn titile
 */
- (void)titleClick:(UIButton *)btn{
    [self configButtonWithIndex:btn.tag];
    if ([self.delegate respondsToSelector:@selector(containerView:NumberOfRow:)]) {
        [self.delegate containerView:self NumberOfRow:btn.tag];
    }
}

/**
 *  重置按钮和指示器状态
 *
 *  @param selectedIndex NSInteger
 */
- (void)configButtonWithIndex:(NSInteger)selectedIndex{
    if (selectedIndex >= self.btnsArray.count) return;
    UIButton *priousBtn = self.btnsArray[self.index];
    priousBtn.selected = NO;
    priousBtn.userInteractionEnabled = YES;
    UIButton *currentBtn = self.btnsArray[selectedIndex];
    currentBtn.selected = YES;
    currentBtn.userInteractionEnabled = NO;
    self.index = currentBtn.tag;
}

/**
 *  保存当前选中的角标并刷新视图
 *
 *  @param index
 */
- (void)setIndex:(NSInteger)index{
    _index = index;
    
    if (self.isOpenAnimation) {
        [UIView animateWithDuration:self.animationTime animations:^{
            [self updateIndicatorViewConstraints];
        }];
    }else {
        [self updateIndicatorViewConstraints];
    }
}

/**
 *   更新约束
 */
- (void)updateIndicatorViewConstraints{
    UIButton *btn = self.btnsArray[self.index];
    __weak typeof(self) weakSelf = self;
    //添加动画
    [self.indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn);
        make.top.equalTo(weakSelf.buttonsView.mas_bottom);
        make.width.equalTo(btn.titleLabel);
        make.height.equalTo(@5);
    }];
    //必须调用此方法，才能出动画效果
    [self layoutIfNeeded];
}
/**
 *  设置选中状态标题颜色
 *
 *  @param selectedTitleColor selectedTitleColor
 */
- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor{
    _selectedTitleColor = selectedTitleColor;
    
    for (UIButton *btn in self.btnsArray) {
        [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
}

/**
 *  设置默认状态标题颜色
 *
 *  @param titleColor titleColor
 */
- (void)setTitleColor:(UIColor *)selectedTitleColor{
    _selectedTitleColor = selectedTitleColor;
    
    for (UIButton *btn in self.btnsArray) {
        [btn setTitleColor:selectedTitleColor forState:UIControlStateNormal];
    }
}
/**
 *  设置背景颜色
 *
 *  @param titleColor titleColor
 */
- (void)setButtonBackgroundColor:(UIColor *)buttonBackgroundColor{
    _buttonBackgroundColor = buttonBackgroundColor;
    for (UIButton *btn in self.btnsArray) {
        [btn setBackgroundColor:buttonBackgroundColor];
    }

}
/**
 *  设置背景图片
 *
 *  @param titleColor titleColor
 */
- (void)setButtonBackgroundImage:(UIImage *)buttonBackgroundImage{
    _buttonBackgroundImage = buttonBackgroundImage;
    for (UIButton *btn in self.btnsArray) {
        [btn setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    }
    
}
/**
 *  设置指示器颜色
 */
- (void)setIndicatorViewColor:(UIColor *)indicatorViewColor{
    _indicatorViewColor = indicatorViewColor;
    [self.indicatorView setBackgroundColor:indicatorViewColor];
}

@end
