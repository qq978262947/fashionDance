//
//  YUPicViewController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "CCPicViewController.h"
#import "TSCKModel.h"
@interface CCPicViewController ()
@property (nonatomic,strong)NSMutableArray * onsaleArray;
@property (nonatomic,strong)NSMutableArray * offsaleArray;
@property (nonatomic,strong)NSArray * allTypeArray;
//选中类型,根据mod中的id
@property (nonatomic,strong)TSCKModel * ckModel;
@end

@implementation CCPicViewController
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
        _allTypeArray=@[@"外观",@"内饰",@"底盘",@"发动机",@"其他"];
    }
    return _allTypeArray;
}
- (void)viewDidLoad
{
    /*
     
     //车款
     http://autoapp.auto.sohu.com/api/pic/listTrimCounts/model_2051
     //类型
     外观，内饰，底盘，发动机，其他
     //颜色
        http://autoapp.auto.sohu.com/api/pic/listForIndex/model_4933_trim_-1
     
     */
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)downLoadData
{
    //获取页面图片
    //http://autoapp.auto.sohu.com/api/pic/listForIndex/model_4395_trim_-1
    
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
-(void)configToolBar
{
    for (int i = 0;i<3;i++)
    {
        UIButton * btn=[[UIButton alloc]init];
        btn.frame=CGRectMake(SCRW/3*i,0 , SCRW/3,50);
        [self.view addSubview:btn];
        btn.tag=100+i;
        [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)btnTouch:(UIButton *)btn
{
    switch (btn.tag) {
        case 100:
        {
            //全部车款
            //创建控制器，直接传入mod数组
            
            //回调
        }
            break;
        case 101:
        {
            //全部类型
            
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
