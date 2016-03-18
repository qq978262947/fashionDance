//
//  YuArticleViewController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YuArticleViewController.h"
#import "YUArticleQuotationViewController.h"
#import "YUArticleInformationViewController.h"
#import "YUTitleNews.h"
#import "YUArticleNewsCell.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"

static NSString *Id = @"YUArticleNewsCell";

@interface YuArticleViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
/** 顶部的标签栏 */
@property (nonatomic, weak) UIView *titlesView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;

@property (nonatomic, copy) NSMutableArray *titleNewsArray;
/** 当前type */
@property (nonatomic, assign) NSInteger type;

@end

@implementation YuArticleViewController

- (NSMutableArray *)titleNewsArray
{
    if (_titleNewsArray == nil) {
        _titleNewsArray = [NSMutableArray array];
    }
    
    return _titleNewsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    // 设置导航栏内容
//    [self setupNav];
    
    // 初始化子控制器
  //  [self setupChildVces];
    
    [self setupTableView];
    
    // 设置顶部标签栏
    [self setupTitlesView];
    
}


- (void)loadCellData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSString *urlString = [NSString stringWithFormat:@"http://autoapp.auto.sohu.com/api/news/list/model_%@_type_%ld_city_110000_page_1",self.modelId,self.type];
    
    __weak typeof (self) weakSelf = self;
    [[WJHttpTool httpTool] get:urlString params:nil success:^(id result) {
        
        NSArray *tmpArray = [YUTitleNews mj_objectArrayWithKeyValuesArray:result[@"news"]];
        [weakSelf.titleNewsArray addObjectsFromArray:tmpArray];
        [weakSelf.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
}


- (void)setupTableView
{
    // 设置tableview
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, WJScreenW, WJScreenH - 64 - 35 - 40) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置inset
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YUArticleNewsCell class]) bundle:nil] forCellReuseIdentifier:Id];
    
}

/**
 * 初始化子控制器
 */
- (void)setupChildVces
{
//    YUArticleQuotationViewController *quotationVC = [[YUArticleQuotationViewController alloc] init];
//    [self addChildViewController:quotationVC];
//    
//    YUArticleInformationViewController *video = [[YUArticleInformationViewController alloc] init];
//    [self addChildViewController:video];
}

/**
 *  设置顶部标签栏
 */
- (void)setupTitlesView
{
    // 标题栏
    UIView *titlesView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WJScreenW, 35)];
    titlesView.backgroundColor = [[UIColor colorWithWhite:0.925 alpha:1.000] colorWithAlphaComponent:1];
    self.titlesView = titlesView;
    [self.view addSubview:titlesView];
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    [titlesView addSubview:indicatorView];
    
    // 内部子标签
    NSArray *titles = @[@"咨询", @"行情"];
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    for (int i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * width, 0, width, height);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        
        button.tag = 100 + i;
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
    }
    // 默认点击第一个按钮
    UIButton *btn = [self.titlesView viewWithTag:100];
    [btn.titleLabel sizeToFit];
    [self titleClick:btn];
}

- (void)titleClick:(UIButton *)button
{
    
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
        
    }];
    
    if (button.tag == 100) {
        [self.titleNewsArray removeAllObjects];
        
        [self.tableView reloadData];
        self.type = 0;
        [self loadCellData];
        
    } else {
        
        [self.titleNewsArray removeAllObjects];
        
        [self.tableView reloadData];
        self.type = 1;
        [self loadCellData];
    }
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.mj_footer.hidden = (self.titleNewsArray.count == 0);
    return self.titleNewsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YUArticleNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:Id forIndexPath:indexPath];
    
    cell.titleNews = self.titleNewsArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
