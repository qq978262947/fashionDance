//
//  LLDownView.m
//  汽车－参数页面
//
//  Created by 李璐 on 16/3/18.
//  Copyright © 2016年 李璐. All rights reserved.
//

#import "LLDownView.h"
#import "LLCanshuCollectionLayout.h"

@interface LLDownView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property(nonatomic,weak)UICollectionView * leftCollectionView;
@property(nonatomic,weak)UICollectionView * rightCollectionView;

@end

@implementation LLDownView

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
        flowLayout.columnNumber = 10;
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

#pragma mark 数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([collectionView isEqual:self.leftCollectionView]) {
        return 20;
    }
    else
    {
        return 70;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
    cell.backgroundColor = WArcColor;
    
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
    if (offSet.x == 0) {
        self.leftCollectionView.contentOffset = offSet;
        self.rightCollectionView.contentOffset = offSet;
    }
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
