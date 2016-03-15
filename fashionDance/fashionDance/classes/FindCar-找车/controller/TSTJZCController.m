//
//  TSTJZCController.m
//  fashionDance
//
//  Created by Dylan on 3/14/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSTJZCController.h"
#import "TSDrawView.h"

@interface TSTJZCController ()
@end

@implementation TSTJZCController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configSubviews];
}
-(void)configSubviews
{
    self.view.backgroundColor=[UIColor redColor];
    TSDrawView * drawView=[[TSDrawView alloc]init];
    [self.view addSubview:drawView];
    [drawView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.top.equalTo(0);
        make.height.equalTo(150);
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
