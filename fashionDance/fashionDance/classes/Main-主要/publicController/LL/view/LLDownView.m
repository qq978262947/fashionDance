//
//  LLDownView.m
//  汽车－参数页面
//
//  Created by 李璐 on 16/3/18.
//  Copyright © 2016年 李璐. All rights reserved.
//

#import "LLDownView.h"
#import "LLCanshuCollectionLayout.h"
#import "LLParameterModel.h"

@interface LLDownView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property(nonatomic,weak)UICollectionView * leftCollectionView;
@property(nonatomic,weak)UICollectionView * rightCollectionView;
@property(nonatomic,strong)NSArray * leftTitle;
@property(nonatomic,strong)NSArray * leftTilteKey;
@end

@implementation LLDownView

-(NSArray *)leftTitle
{
    if (!_leftTitle) {
        _leftTitle = @[@"厂商指导价",@"经销商最低报价",@"车厂",@"级别",@"车体结构",@"发动机",@"变速箱",@"工信部油耗",@"官方0-100加速",@"保养周期",@"保养政策",@"动力类型",@"长宽高"];
    }
    return _leftTitle;
}

-(NSArray *)leftTilteKey
{
    if (!_leftTilteKey) {
        _leftTilteKey = @[@"102",@"103",@"104",@"105",@"106",@"107",@"108",@"294",@"113",@"114",@"115",@"303",@"293"];
    }
    return _leftTilteKey;
}

-(void)dealloc
{
    NSNotificationCenter * defualtCenter = [NSNotificationCenter defaultCenter];
    [defualtCenter removeObserver:self];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        NSNotificationCenter * defualtCenter = [NSNotificationCenter defaultCenter];
        [defualtCenter addObserver:self selector:@selector(scrollNotificationHandle:) name:@"LLScroll" object:nil];
    }
    return self;
}

-(void)scrollNotificationHandle:(NSNotification*)notification
{
    if (![notification.object isEqual:self]) {
        UIScrollView * view = [notification.userInfo objectForKey:@"scrollView"];
        self.rightCollectionView.contentOffset = CGPointMake(view.contentOffset.x, self.rightCollectionView.contentOffset.y);
    }
}


-(UICollectionView *)leftCollectionView
{
    if (!_leftCollectionView) {
        CGRect frame = CGRectMake(0, 0, self.leftWidth, self.frame.size.height);
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 1;
        UICollectionView * view = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
        [view registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"test"];
        view.dataSource = self;
        view.delegate = self;
        view.bounces = 0;
        [self addSubview:view];
        
        _leftCollectionView = view;
    }
    return _leftCollectionView;
}

-(UICollectionView *)rightCollectionView
{
    if (!_rightCollectionView) {
        LLCanshuCollectionLayout * flowLayout = [[LLCanshuCollectionLayout alloc]init];
        flowLayout.sizeOfItem = CGSizeMake(self.cellWidth, self.cellHeight);
        UICollectionView * view = [[UICollectionView alloc]initWithFrame:CGRectMake(self.leftWidth, 0, WJScreenW - self.leftWidth, self.frame.size.height) collectionViewLayout:flowLayout];
        [view registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"test"];
        view.dataSource = self;
        view.delegate = self;
        view.bounces = 0;
        view.directionalLockEnabled = YES;
        [self addSubview:view];
        
        _rightCollectionView = view;
    }
    return _rightCollectionView;
}

#pragma mark 外界数据赋进
-(void)setData:(NSArray *)data
{
    _data = data;
    
    //准备工作
    LLCanshuCollectionLayout * layout = (LLCanshuCollectionLayout*)self.rightCollectionView.collectionViewLayout;
    layout.columnNumber = data.count;
    [self.rightCollectionView reloadData];
    [self.leftCollectionView reloadData];
}

#pragma mark 数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([collectionView isEqual:self.leftCollectionView]) {
        return 13;
    }
    else
    {
        return 13 * self.data.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
    if ([collectionView isEqual:self.leftCollectionView]) {
        NSString * title = self.leftTitle[indexPath.item];
        if (cell.subviews.count > 1) {
            //有subview
            UILabel * view = [[cell subviews] lastObject];
            view.text = title;
        }
        else
        {
            UILabel * view = [[UILabel alloc]initWithFrame:cell.bounds];
            [cell addSubview:view];
            view.text = title;
        }
        cell.backgroundColor = [UIColor whiteColor];

    }
    else
    {
        //取出数据源
        //算出此indexpath对应model
        LLParameterModel * model;
        if (self.data.count != 0) {
            NSInteger counter = indexPath.item%self.data.count;
            model = self.data[counter];
            //获得数据名
            NSString * getSelectName = self.leftTilteKey[indexPath.item/self.data.count];
            getSelectName = [NSString stringWithFormat:@"a%@",getSelectName];
            SEL getSelect = NSSelectorFromString(getSelectName);
            
            if (cell.subviews.count > 1) {
                //有subview
                UILabel * view = [[cell subviews] lastObject];
                if ([model respondsToSelector:getSelect]) {
                    view.text = [model performSelector:getSelect];
                }
            }
            else
            {
                UILabel * view = [[UILabel alloc]initWithFrame:cell.bounds];
                [cell addSubview:view];
                if ([model respondsToSelector:getSelect]) {
                    view.text = [model performSelector:getSelect];
                }
            }
            
            cell.backgroundColor = [UIColor whiteColor];
            
        }
        else
        {
            cell.backgroundColor = WArcColor;
        }

    }
 
    cell.layer.borderWidth = 1.5;
    cell.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    
    return cell;
}

#pragma mark layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //主要是给leftCollectionView用
    if ([collectionView isEqual:self.leftCollectionView]) {
        //左边collection view
        return CGSizeMake(self.leftWidth, self.cellHeight);
    }
    //下面无用
    else
    {
        return CGSizeMake(self.cellWidth, self.cellHeight);
    }
}

#pragma mark 联动效果
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offSet = scrollView.contentOffset;
    self.leftCollectionView.contentOffset = CGPointMake(0, offSet.y);
    self.rightCollectionView.contentOffset = CGPointMake(self.rightCollectionView.contentOffset.x, offSet.y);
    if ([scrollView isEqual:self.rightCollectionView]) {
        NSNotificationCenter * defualtCenter = [NSNotificationCenter defaultCenter];
        [defualtCenter postNotificationName:@"LLScroll" object:self userInfo:@{@"scrollView":scrollView}];
    }
}

#pragma mark 加载子view
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self leftCollectionView];
    [self rightCollectionView];
}

/**
 * 含一个左边的tableview，一个右边的collectionview
 */

@end
