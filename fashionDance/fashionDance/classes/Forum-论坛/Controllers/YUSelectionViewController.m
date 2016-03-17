//
//  YUSelectionViewController.m
//  fashionDance
//
//  Created by qianfeng on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUSelectionViewController.h"
#import "YUSelectionTopicCell.h"
#import "YUCollectionReusableView.h"
#import "WJHttpTool.h"
#import "YUSelectionTopic.h"
#import <MJExtension.h>
#import "YUMoreTopicViewController.h"
#import <SVProgressHUD.h>
#import "YUTopicWebViewController.h"


static NSString *Id = @"cell";

@interface YUSelectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, YUCollectionReusableViewDelegate>

@property (nonatomic, strong) NSArray *selectionTopics;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation YUSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configCollectionView];
    
    [self loadNewListData];
}

- (void)loadNewListData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    __weak typeof (self) weakSelf = self;
    [[WJHttpTool httpTool] get:@"http://saa.auto.sohu.com/v5/mobileapp/club/choicesIndex.do" params:nil success:^(id result) {
        
        weakSelf.selectionTopics = [YUSelectionTopic mj_objectArrayWithKeyValuesArray:result[@"RESULT"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.collectionView reloadData];
        });
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

/**
 *  配置collectionView
 */
- (void)configCollectionView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    // collectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    flowLayout.itemSize = CGSizeMake((WJScreenW - 30)/2, 150);
//    flowLayout.minimumLineSpacing = 10;
//    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.headerReferenceSize = CGSizeMake(WJScreenW, 30);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WJScreenW, WJScreenH - 49 - 64) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView = collectionView;
    collectionView.pagingEnabled = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:collectionView];
    
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YUSelectionTopicCell class]) bundle:nil] forCellWithReuseIdentifier:Id];
    [self.collectionView registerClass:[YUCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
}


#pragma mark   - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YUSelectionTopicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Id forIndexPath:indexPath];
    YUSelectionTopic *selectionTopic = self.selectionTopics[indexPath.section];
    YUHotTopicModel *listTopic = selectionTopic.list[indexPath.row];
    
    cell.topic = listTopic;

    return cell;
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        YUCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        if (self.selectionTopics[indexPath.section]) {
            headerView.selectionTopic = self.selectionTopics[indexPath.section];
        }
        
        headerView.delegate = self;
        reusableview = headerView;
    }
    
    //    if (kind == UICollectionElementKindSectionFooter)
    //    {
    //        RecipeCollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
    //
    //        reusableview = footerview;
    //    }
    
    reusableview.backgroundColor = [UIColor colorWithWhite:0.800 alpha:0.5];
    
    return reusableview;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YUTopicWebViewController *topicWebVc = [[YUTopicWebViewController alloc]init];
    
    YUSelectionTopic *selectionTopic = self.selectionTopics[indexPath.section];
    YUHotTopicModel *listTopic = selectionTopic.list[indexPath.row];
    topicWebVc.topicModel = listTopic;
    [self.navigationController pushViewController:topicWebVc animated:YES];
}

#pragma mark  - YUCollectionReusableViewDelegate
- (void)collectionReusableViewDidBtnClick:(YUCollectionReusableView *)collectionReusableView selectionTopic:(YUSelectionTopic *)selectionTopic
{
    YUMoreTopicViewController *moreVc = [[YUMoreTopicViewController alloc]init];
    
    moreVc.selectionTopic = selectionTopic;
    
    [self.navigationController pushViewController:moreVc animated:YES];
    
}

@end
