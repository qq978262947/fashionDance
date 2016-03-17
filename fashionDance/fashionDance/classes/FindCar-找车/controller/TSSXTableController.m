//
//  TSSXTableController.m
//  fashionDance
//
//  Created by Dylan on 3/16/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSSXTableController.h"
#import "TSSXCarModel.h"
#import "TSXCCell.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
//#import "<#header#>"

@interface TSSXTableController ()
@property (nonatomic,assign)NSInteger pageCount;
@property (nonatomic,assign)NSInteger pageNumber;
@property (nonatomic,assign)NSInteger cellCount;
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation TSSXTableController
-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
+(instancetype)tableControllerWithUrl:(NSString *)ulrStr
{
    TSSXTableController * sxTableCtl=[[TSSXTableController alloc]init];
    sxTableCtl.resURL=ulrStr;
    return sxTableCtl;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configSubViews];
    [SVProgressHUD show];
    self.tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self downLoadData];
    }];
    [self downLoadData];
    
}
-(void)configSubViews
{
    self.pageCount=20;
    self.pageNumber=0;
}
-(void)downLoadData
{
    //分页请求，当前第几页，每页多少个
    NSString * path=[NSString stringWithFormat:@"%@-%ld-%ld",self.resURL,self.pageNumber,self.pageCount];
    [[WJHttpTool httpTool]get:path params:nil success:^(NSDictionary * result)
    {
        NSArray * items=[result objectForKey:@"items"];
        for (NSDictionary * dict in items)
        {
            TSSXCarModel * mod=[TSSXCarModel modWithDict:dict];
            [self.dataArray addObject:mod];
        }
        self.pageNumber++;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];

        if (self.cellCount==self.dataArray.count)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else
        {
            [self.tableView.mj_footer endRefreshing];
            self.cellCount=self.dataArray.count;
        }
        
    } failure:^(NSError *error)
    {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSXCCell * cell=[TSXCCell cellWithTableView:tableView];
    [cell configWithMod:self.dataArray[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
