//
//  YUPicViewController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "CCPicViewController.h"

@interface CCPicViewController ()

@end

@implementation CCPicViewController

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
            //创建控制器
            
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
