//
//  YUPicViewController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "CCPicViewController.h"
#import "TSCKModel.h"
#import "TSCarPicMod.h"
#import "TSHalfController.h"
#import "SVProgressHUD.h"
#import "TSPhotoCell.h"
@interface CCPicViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
//tableviw
@property (nonatomic,strong)UICollectionView * collectionView;
//
@property (nonatomic,strong)NSMutableArray * onsaleArray;
@property (nonatomic,strong)NSMutableArray * offsaleArray;
@property (nonatomic,strong)NSMutableArray * allCKArray;
//@property (nonatomic,strong)NSArray * 
@property (nonatomic,strong)NSArray * allTypeArray;
//选中类型,根据mod中的id
@property (nonatomic,strong)TSCKModel * ckModel;
//显示图片的数组
@property (nonatomic,strong)NSMutableArray * titleArray;
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation CCPicViewController
-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)titleArray
{
    if (_titleArray==nil) {
        _titleArray=[NSMutableArray array];
    }
    return _titleArray;
}
-(NSMutableArray *)onsaleArray
{
    if (_onsaleArray==nil) {
        _onsaleArray=[NSMutableArray array];
    }
    return _onsaleArray;
}
-(NSMutableArray *)offsaleArray
{
    if (_offsaleArray==nil) {
        _offsaleArray=[NSMutableArray array];
    }
    return _offsaleArray;
}
-(NSArray *)allTypeArray
{
    if (_allTypeArray==nil)
    {
        _allTypeArray=@[@"外观",@"内饰",@"底盘/发动机",@"其他"];
    }
    return _allTypeArray;
}
- (void)viewDidLoad
{
    self.modelId=@"4395";
    [self downLoadListData];
    [self downLoadData];
    [self configsubViews];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)downLoadData
{
    //获取页面图片
    //http://autoapp.auto.sohu.com/api/pic/listForIndex/model_4395_trim_-1
    NSString * path=@"http://autoapp.auto.sohu.com/api/pic/listForIndex/model_4395_trim_-1";
    [[WJHttpTool httpTool]get:path params:nil success:^(id result)
    {
        self.dataArray=nil;
        self.titleArray=nil;
        
        NSArray * outside=result[@"outside"];
        if (outside != nil||outside.count!=0)
        {
            NSMutableArray * tempArray=[NSMutableArray array];
            for (NSDictionary * dict in outside)
            {
                TSCarPicMod * mod=[TSCarPicMod modWithDict:dict];
                [tempArray addObject:mod];
            }
            [self.dataArray addObject:tempArray];
            [self.titleArray addObject:@"内饰"];
        }
        
        NSArray * chassis=result[@"chassis"];
        if (chassis != nil||chassis.count!=0)
        {
            NSMutableArray * tempArray=[NSMutableArray array];
            for (NSDictionary * dict in chassis)
            {
                TSCarPicMod * mod=[TSCarPicMod modWithDict:dict];
                [tempArray addObject:mod];
            }
            [self.dataArray addObject:tempArray];
            [self.titleArray addObject:@"底盘/发动机"];
        }
        NSArray * inside=result[@"inside"];
        if (inside != nil||inside.count!=0)
        {
            NSMutableArray * tempArray=[NSMutableArray array];
            for (NSDictionary * dict in inside)
            {
                TSCarPicMod * mod=[TSCarPicMod modWithDict:dict];
                [tempArray addObject:mod];
            }
            [self.dataArray addObject:tempArray];
            [self.titleArray addObject:@"内饰"];
        }
        NSArray * others=result[@"others"];
        if (others != nil||others.count!=0)
        {
            NSMutableArray * tempArray=[NSMutableArray array];
            for (NSDictionary * dict in others)
            {
                TSCarPicMod * mod=[TSCarPicMod modWithDict:dict];
                [tempArray addObject:mod];
            }
            [self.dataArray addObject:tempArray];
            [self.titleArray addObject:@"其他"];
        }
        [self.collectionView reloadData];
        
    }
    failure:^(NSError *error)
    {
        NSLog(@"%@",error);
    }];
}
-(void)downLoadListData
{
    //获取全部车款列表
    NSString * path=[NSString stringWithFormat:@"http://autoapp.auto.sohu.com/api/pic/listTrimCounts/model_%@",self.modelId];
    [[WJHttpTool httpTool]get:path params:nil success:^(NSDictionary * result)
    {
        //字典解析
        NSArray * onsale=result[@"onsale"];
        for (NSDictionary * dict in onsale)
        {
            TSCKModel * mod= [TSCKModel modWithDictionary:dict];
            [self.onsaleArray addObject:mod];
        }
        NSArray * offsale=result[@"offsale"];
        for (NSDictionary * dict in offsale)
        {
            TSCKModel * mod= [TSCKModel modWithDictionary:dict];
            [self.offsaleArray addObject:mod];
        }
        NSLog(@"%@",result);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)getColor
{
    /*
     全部颜色
     http://autoapp.auto.sohu.com/api/pic/listForIndex/model_4720_trim_-1
     选中颜色
     http://autoapp.auto.sohu.com/api/pic/colorList/model_4720_trim_131140
     */
}
//configToolBar
-(void)configsubViews
{
    //顶部工具条
    NSArray * titleArray=@[@"全部车款",@"全部类型",@"全部颜色"];
    for (int i = 0;i<3;i++)
    {
        UIButton * btn=[[UIButton alloc]init];
        [btn setBackgroundColor:[UIColor darkGrayColor]];
        btn.frame=CGRectMake(SCRW/3*i,0 , SCRW/3,50);
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.tag=100+i;
        [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    //下面collectionView
    UICollectionViewFlowLayout * flaw=[UICollectionViewFlowLayout new];
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, SCRW, SCRH-NAVH-TabbarH-50) collectionViewLayout:flaw];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
}
-(void)btnTouch:(UIButton *)btn
{
    switch (btn.tag) {
        case 100:
        {
            //全部车款
            //创建控制器，直接传入mod数组
            TSHalfController * half=[TSHalfController halfControllerWithArray:@[@"",@"在售车款",@"停售车款"] andTitleArray:@[@[@"全部车款"],self.onsaleArray,self.offsaleArray]];
            [self presentViewController:half animated:YES completion:nil];
            //回调
        }
            break;
        case 101:
        {
            //全部类型
            TSHalfController * half=[TSHalfController halfControllerWithArray:@[@"",@""] andTitleArray:@[@[@"全部类型"],self.allTypeArray]];
            [self presentViewController:half animated:YES completion:nil];
        }
            break;
        case 102:
        {
            //全部颜色
            
        }
            break;
            
        default:
            break;
    }
}
#pragma mark collectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray * tempArray=self.dataArray[section];
    return tempArray.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //选中后弹出Photo
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //返回一个cell
    NSArray * temp=self.dataArray[indexPath.section];
    TSCarPicMod * mod=temp[indexPath.row];
    TSPhotoCell * cell=[TSPhotoCell cellWithCollectionView:collectionView andindexPath:indexPath];
    [cell configWithUrl:mod.url];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 60);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}














- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
