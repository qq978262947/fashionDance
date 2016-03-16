//
//  YUTopicHeaderView.m
//  fashionDance
//
//  Created by qianfeng on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUTopicHeaderView.h"
#import "YUImageCell.h"
#import "YUBannerListModel.h"
#import "YUHotTopicModel.h"

#define YUMaxSections 50

static NSString *Id = @"cell";

@interface YUTopicHeaderView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) UIView *bottomView;

@end

@implementation YUTopicHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //配置collectionView
        [self configCollectionView];
        
        [self configBottomView];
        
    }
    return self;
}


- (void)setBannerListModels:(NSArray *)bannerListModels
{
    _bannerListModels = bannerListModels;
    
    [self.collectionView reloadData];
    
    self.pageControl.numberOfPages = bannerListModels.count;
    
    if (bannerListModels) {
        // 添加定时器
        [self addTimer];
    }
}

- (void)configBottomView
{
    UIView *bottomView = [[UIView alloc]init];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    bottomView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:0.3];
    
    //配置标题label
    [self configTitleLabel];
    
    //配置pageControl
    [self configPageControl];
}

/**
 *  配置标题label
 */
- (void)configTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc]init];
    [self.bottomView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:13];
    [titleLabel sizeToFit];
    
}

/**
 *  配置pageControl
 */
- (void)configPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    [self.bottomView addSubview:pageControl];
    pageControl.numberOfPages = self.bannerListModels.count;
    pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    self.pageControl = pageControl;
    
}

/**
 *  配置collectionView
 */
- (void)configCollectionView
{
    // collectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    flowLayout.itemSize = CGSizeMake(WJScreenW, YUImageCellH);
    flowLayout.minimumLineSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WJScreenW, YUImageCellH) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    self.collectionView = collectionView;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:collectionView];
    
    // 注册cell
    [collectionView registerClass:[YUImageCell class] forCellWithReuseIdentifier:Id];
    
}


/**
 *  添加定时器
 */
- (void)addTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

/**
 *  移除定时器
 */
- (void)removeTimer
{
    // 停止定时器
    [self.timer invalidate];
    self.timer = nil;
}

- (NSIndexPath *)resetIndexPath
{
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:YUMaxSections / 2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    //    NSLog(@"%@",currentIndexPathReset);
    return currentIndexPathReset;
}

/**
 *  下一页
 */
- (void)nextPage
{
    // 1.马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    
    // 2.计算出下一个需要展示的位置
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.bannerListModels.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    // 3.通过动画滚动到下一个位置
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}


#pragma mark   - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return YUMaxSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.bannerListModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YUImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Id forIndexPath:indexPath];
    YUBannerListModel *bannerListModel = self.bannerListModels[indexPath.item];
    cell.bannerListModel = bannerListModel;
    
    YUHotTopicModel *topicModel = bannerListModel.topic;
    topicModel.imgUrl = bannerListModel.imgUrl;
    self.titleLabel.text = topicModel.title;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YUBannerListModel *bannerListModel = self.bannerListModels[indexPath.item];
    YUHotTopicModel *topicModel = bannerListModel.topic;
    
    [self.delegate collectionViewDidSelectItem:self topicModel:topicModel];
}

#pragma mark  - UICollectionViewDelegate

/**
 *  当用户即将开始拖拽的时候就调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer = nil;
}


/**
 *  当用户停止拖拽的时候就调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.bannerListModels) {
        int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.bannerListModels.count;
        self.pageControl.currentPage = page;
    }
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 0, WJScreenW, YUImageCellH);
    
    self.bottomView.frame = CGRectMake(0, YUImageCellH - 30, WJScreenW, 30);
    
    self.pageControl.frame = CGRectMake(WJScreenW - 70, 0, 50, 30);

    self.titleLabel.frame = CGRectMake(10, 0, WJScreenW - 70, 30);
}


@end
