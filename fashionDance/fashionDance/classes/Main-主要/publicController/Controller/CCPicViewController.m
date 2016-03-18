//
//  YUPicViewController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "CCPicViewController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "TSCKModel.h"
#import "TSCarPicMod.h"
#import "TSLXModel.h"
#import "TSHalfWithoutModController.h"
#import "TSHalfColorController.h"
#import "TSHalfController.h"
#import "SVProgressHUD.h"
#import "TSPhotoCell.h"
#import "TSPicReusableView.h"
#import "TSColorMod.h"
#import "MJRefresh.h"

@interface CCPicViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
//按钮数组
@property (nonatomic,strong)NSMutableArray * btnArray;
//tableviw
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,assign)BOOL collectionViewType;
//选择按钮
@property (nonatomic,strong)NSMutableArray * onsaleArray;
@property (nonatomic,strong)NSMutableArray * offsaleArray;
//颜色按钮
@property (nonatomic,strong)NSMutableArray * insideColor;
@property (nonatomic,strong)NSMutableArray * outsideColor;



@property (nonatomic,strong)NSMutableArray * allCKArray;
//@property (nonatomic,strong)NSArray * 
@property (nonatomic,strong)NSArray * allTypeArray;
//选中类型,根据mod中的id
@property (nonatomic,strong)TSCKModel * ckModel;
//显示图片的数组
//type1
@property (nonatomic,strong)NSMutableArray * titleArray;
@property (nonatomic,strong)NSMutableArray * dataArray;
//tpye2
@property (nonatomic,strong)NSMutableArray * bigDataArray;
@property (nonatomic,assign)NSInteger start;
@property (nonatomic,assign)BOOL firstReq;
@property (nonatomic,strong)NSString * collectionTitle;
@end

@implementation CCPicViewController
-(NSNumber *)type
{
    if (_type==nil) {
        _type=[NSNumber numberWithInteger:0];
    }
    return _type;
}
-(NSNumber *)trim
{
    if (_trim==nil) {
        _trim=[NSNumber numberWithInteger:-1];
    }
    return _trim;
}
-(NSNumber *)color
{
    if (_color==nil) {
        _color=[NSNumber numberWithInteger:0];
    }
    return _color;
}
-(NSMutableArray *)bigDataArray
{
    if (_bigDataArray==nil) {
        _bigDataArray=[NSMutableArray array];
    }
    return _bigDataArray;
}
-(NSMutableArray *)btnArray
{
    if (_btnArray==nil) {
        _btnArray=[NSMutableArray array];
    }
    return _btnArray;
}
-(NSMutableArray *)insideColor
{
    if (_insideColor==nil) {
        _insideColor=[NSMutableArray array];
    }
    return _insideColor;
}
-(NSMutableArray *)outsideColor
{
    if (_outsideColor==nil) {
        _outsideColor=[NSMutableArray array];
    }
    return _outsideColor;
}
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
+(instancetype)ccpicviewcontrollerWithString:(NSString *)modid
{
    CCPicViewController * ctl=[CCPicViewController new];
    ctl.modelId=modid;
    return ctl;
}
- (void)viewDidLoad
{
    self.page=1;
    self.size=20;
    self.collectionViewType=YES;
    self.firstReq=YES;
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self downLoadListData];
    [self downLoadData];
    [self getColor];
    [self configsubViews];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)downLoadData
{
    //获取页面图片
    //http://autoapp.auto.sohu.com/api/pic/listForIndex/model_4395_trim_-1

    
    NSString * path=[NSString stringWithFormat:@"http://autoapp.auto.sohu.com/api/pic/listForIndex/model_%@_trim_%@",self.modelId,self.trim];
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
            [self.titleArray addObject:@"外饰"];
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
       // [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSError *error)
    {
        NSLog(@"%@",error);
        //[self.collectionView.mj_footer endRefreshing];
    }];
}
-(void)downloadLXData
{
    if (self.color.integerValue==0&&self.trim.integerValue==-1&&self.type.integerValue==0)
    {
        [self downLoadData];
        return;
    }
    //http://autoapp.auto.sohu.com/api/pic/listForIndex/model_4905_trim_-1
    //http://autoapp.auto.sohu.com/api/pic/list/model_4905_trim_-1_type_1000_color_0_page_1_size_20
    //http://autoapp.auto.sohu.com/api/pic/list/model_4898_trim_-1_type_2000_color_0_page_1_size_20
    //http://autoapp.auto.sohu.com/api/pic/list/model_4898_trim_-1_type_3000_color_0_page_1_size_20
    //http://autoapp.auto.sohu.com/api/pic/list/model_4898_trim_-1_type_9000_color_0_page_1_size_20
    //接口
    //model trim color
    //type
    //page size
    if (self.firstReq)
    {
        self.bigDataArray=nil;
    }
    NSString * path=[NSString stringWithFormat:@"http://autoapp.auto.sohu.com/api/pic/list/model_%@_trim_%@_type_%@000_color_%@_page_%d_size_%d",self.modelId,self.trim,self.type,self.color,self.page,self.size];
    [[WJHttpTool httpTool]get:path params:nil success:^(NSDictionary * result)
    {
        NSDictionary * res=result[@"result"];
        NSArray * items=res[@"PicItems"];
        for (NSDictionary * dict in items)
        {
            TSLXModel * mod=[TSLXModel modWithDict:dict];
            [self.bigDataArray addObject:mod];
        }

        self.firstReq=NO;
        if (self.start==self.bigDataArray.count) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        else
        {
            self.start=self.bigDataArray.count;
            [self.collectionView.mj_footer endRefreshing];
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.collectionView.mj_footer endRefreshing];
    }];
    
}
-(void)getColor
{
    /*
     全部颜色
     选中颜色
     http://autoapp.auto.sohu.com/api/pic/colorList/model_4720_trim_131140
     */
    self.insideColor=nil;
    self.outsideColor=nil;

    NSString * path=[NSString stringWithFormat:@"http://autoapp.auto.sohu.com/api/pic/colorList/model_4720_trim_%@",self.trim];
    [[WJHttpTool httpTool]get:path params:nil success:^(NSDictionary * result)
     {
         NSArray * inside=result[@"inside"];
         for (NSDictionary * dict in inside)
         {
             TSColorMod * mod=[TSColorMod modWithDict:dict];
             [self.insideColor addObject:mod];
         }
         NSArray * outside=result[@"outside"];
         for (NSDictionary * dict in outside)
         {
             TSColorMod * mod=[TSColorMod modWithDict:dict];
             [self.outsideColor addObject:mod];
         }
         
     } failure:^(NSError *error) {
         
     }];
}
//configToolBar
-(void)configsubViews
{
    //顶部工具条
    NSArray * titleArray=@[@"全部车款",@"全部类型",@"全部颜色"];
    
    for (int i = 0;i<3;i++)
    {
        UIButton * btn=[[UIButton alloc]init];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor redColor]];
        btn.frame=CGRectMake(SCRW/3*i,0 , SCRW/3,50);
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        //btn.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 0, SCRW/3);
        //btn.imageEdgeInsets=UIEdgeInsetsMake(0, (SCRW/3), 0, 0);
        [self.view addSubview:btn];
        //[btn setImage:[UIImage imageNamed:@"left2"] forState:UIControlStateNormal];
        btn.tag=100+i;
        [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:btn];
    }
    //下面collectionView
    UICollectionViewFlowLayout * flaw=[UICollectionViewFlowLayout new];
    
    flaw.headerReferenceSize = CGSizeMake(SCRW, 35);
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, SCRW, SCRH-NAVH-TabbarH-50) collectionViewLayout:flaw];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
}
-(void)btnTouch:(UIButton *)btn
{
    switch (btn.tag) {
        case 100:
        {
            //全部车款
            TSCKModel * ckmod=[TSCKModel new];
            ckmod.trimName=@"全部车型";
            ckmod.trimId=[NSNumber numberWithInteger:-1];
            TSHalfController * half=[TSHalfController halfControllerWithArray:@[@[ckmod],self.onsaleArray,self.offsaleArray] andTitleArray:@[@"",@"在售车款",@"停售车款"] andtitle:@"全部款式"];
            [half setTSHalfControllerBlock:^(TSHalfController * h, TSCKModel *mod) {
                self.trim=mod.trimId;
                //设置按钮标题
                
                [btn setTitle:mod.trimName forState:UIControlStateNormal];
                [self getColor];
                self.collectionViewType=YES;
                [self downLoadData];
            }];
            [self presentViewController:half animated:YES completion:nil];
        }
            break;
        case 101:
        {
            //全部类型
            TSHalfWithoutModController * half=[TSHalfWithoutModController halfControllerWithArray:@[self.allTypeArray] andTitleArray:@[@""] andtitle:@"全部类型"];
            [half setTSHalfWithoutModControllerBlock:^(TSHalfWithoutModController *h, NSNumber *number,NSString * title) {
                self.type=number;
                self.collectionTitle=title;
                [btn setTitle:title forState:UIControlStateNormal];
                
                self.collectionViewType=NO;
                self.firstReq=YES;
                self.collectionView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    [self downloadLXData];
                }];
                [self downloadLXData];
            }];
            [self presentViewController:half animated:YES completion:nil];
        }
            break;
        case 102:
        {
            //全部颜色
            TSHalfColorController * color=[TSHalfColorController halfControllerWithArray:@[self.outsideColor,self.insideColor] andTitleArray:@[@"外部颜色",@"内部颜色"]andtitle:@"全部颜色"];
            [color setTSHalfColorControllerBlock:^(TSHalfColorController * h, TSColorMod * mod) {
                self.color=mod.ID;
                self.collectionTitle=mod.colorName;
                [btn setTitle:mod.colorName forState:UIControlStateNormal];
                //下载数据
                self.collectionViewType=NO;
                self.firstReq=YES;
                self.collectionView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    [self downloadLXData];
                }];
                [self downloadLXData];
            }];
            [self presentViewController:color animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark collectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.collectionViewType) {
        NSArray * tempArray=self.dataArray[section];
        return tempArray.count;
    }
    else
    {
        return self.bigDataArray.count;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.collectionViewType) {
        return self.dataArray.count;
    }
    else
    {
        return 1;
    }
    return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //返回一个cell
    TSPhotoCell * cell=[TSPhotoCell cellWithCollectionView:collectionView andindexPath:indexPath];
    if (self.collectionViewType)
    {
        NSArray * temp=self.dataArray[indexPath.section];
        TSCarPicMod * mod=temp[indexPath.row];
        [cell configWithUrl:mod.url];
    }
    else
    {
        TSLXModel * mod=self.bigDataArray[indexPath.row];
        [cell configWithUrl:mod.PicUrl];
    }
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCRW/3-15, 66);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.collectionViewType)
    {
        NSArray * temp=self.dataArray[indexPath.section];
        TSCarPicMod * mod=temp[indexPath.row];
        MJPhotoBrowser * browser=[[MJPhotoBrowser alloc]init];
        MJPhoto * photo=[[MJPhoto alloc]init];
        browser.photos=@[photo];
        photo.url = [NSURL URLWithString:mod.url];
        [self.navigationController pushViewController:browser animated:YES];
    }
    else
    {
        TSLXModel * mod=self.bigDataArray[indexPath.row];
        MJPhotoBrowser * browser=[[MJPhotoBrowser alloc]init];
        MJPhoto * photo=[[MJPhoto alloc]init];
        photo.url = [NSURL URLWithString:mod.PicUrl];
        browser.photos=@[photo];
        [self.navigationController pushViewController:browser animated:YES];
    }
    //弹出Photo
}
//1.要显示什么的头部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * reView ;
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        TSPicReusableView * view=[TSPicReusableView cellWithTableView:collectionView andindexPath:indexPath];
        if (self.collectionViewType) {
            [view configWithString:self.titleArray[indexPath.section]];
        }
        else
        {
            [view configWithString:self.collectionTitle];
        }
        
        return view;
    }
    return reView;
}//end method

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
