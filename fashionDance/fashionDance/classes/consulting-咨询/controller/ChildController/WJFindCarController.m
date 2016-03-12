//
//  WJFindCarController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJFindCarController.h"
#import "WJWaterFlowLayout.h"
#import "WJCollectionViewCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "WJHttpTool.h"
#import "WJFindCarResult.h"

@interface WJFindCarController () <WJWaterflowLayoutDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *resultArray;

@property (assign, nonatomic)int year;
@end

@implementation WJFindCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 集成瀑布流布局
    [self setupLayout];
    // 集成刷新控件
    [self setupRefresh];
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewCars)];
    // 自动改变透明度
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreCars)];
    
}

/**
 *  集成瀑布流布局
 */
- (void)setupLayout
{
    // 创建布局
    WJWaterflowLayout *layout = [[WJWaterflowLayout alloc] init];
    layout.delegate = self;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    self.collectionView = collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.resultArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJCollectionViewCell *cell = [WJCollectionViewCell collectionCellCellWithCollectionView:collectionView indexPath:indexPath];
    
    cell.layer.cornerRadius = 2;
    
    WJFindCarResult *carResult = self.resultArray[indexPath.item];
    cell.carResult = carResult;
    
    return cell;
}

#pragma mark - <WJWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(WJWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
//    WJShop *shop = self.shops[index];
    
    return 150 + arc4random_uniform(40);
}

- (CGFloat)rowMarginInWaterflowLayout:(WJWaterflowLayout *)waterflowLayout
{
    return 5;
}

- (CGFloat)columnCountInWaterflowLayout:(WJWaterflowLayout *)waterflowLayout
{
//    if (self.resultArray.count <= 50) return 2;
    return 2;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WJWaterflowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


#pragma mark - <privateMethod>
- (void)loadNewCars {
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    self.year = (int)[calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSString *urlString = [NSString stringWithFormat:@"http://autoapp.auto.sohu.com/api/model/newcar/%i",self.year];
    [[WJHttpTool httpTool]get:urlString params:nil success:^(NSDictionary *responseObj) {
        self.resultArray = [WJFindCarResult mj_objectArrayWithKeyValuesArray:responseObj];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
    }];
}

- (void)loadMoreCars {
    NSString *urlString = [NSString stringWithFormat:@"http://autoapp.auto.sohu.com/api/model/newcar/%i",--self.year];
    [[WJHttpTool httpTool]get:urlString params:nil success:^(NSDictionary *responseObj) {
        NSArray *array = [WJFindCarResult mj_objectArrayWithKeyValuesArray:responseObj];
        if (array.count != 0) {
            [self.resultArray addObjectsFromArray:array];
            [self.collectionView reloadData];
        } else {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [self.collectionView.mj_footer endRefreshing];
    }];
}

@end
