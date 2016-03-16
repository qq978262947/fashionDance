//
//  TSTJZCController.m
//  fashionDance
//
//  Created by Dylan on 3/14/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSTJZCController.h"
#import "TSDrawView.h"
#import "TSTitleCell.h"
#import "TSSpecificController.h"
#import "ReactiveCocoa.h"
@interface TSTJZCController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray * titleArray;
@property (nonatomic,strong)NSArray * specicsArray;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)TSDrawView * drawView;
@property (nonatomic,strong)UIView * toolBarView;
@property (nonatomic,strong)UIButton * resetBtn;
//符合条件按钮
@property (nonatomic,strong)UIButton * eligibleBtn;
@end

@implementation TSTJZCController
-(NSMutableArray *)numberArray
{
    if (_numberArray==nil)
    {
        _numberArray=[NSMutableArray array];
        for (int i = 0; i<7; i++)
        {
            NSNumber * num=[NSNumber numberWithInteger:0];
            [_numberArray addObject:num];
        }
    }
    return _numberArray;
}
-(NSArray *)specicsArray
{
    if (_specicsArray==nil)
    {
        NSString * path=[[NSBundle mainBundle]pathForResource:@"TSConfigList.plist" ofType:nil];
        _specicsArray=[NSArray arrayWithContentsOfFile:path];
    }
    return _specicsArray;
}
-(NSMutableArray *)titleArray
{
    if (_titleArray==nil) {
        NSString * path=[[NSBundle mainBundle]pathForResource:@"TSTitleList.plist" ofType:nil];
        _titleArray=[NSMutableArray arrayWithContentsOfFile:path];
    }
    return _titleArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configSubviews];
    
    [self valueChangedForSearchBtn];
    
    [self configLogics];
}
-(void)configLogics
{

        RAC(self.resetBtn,enabled)=[RACSignal combineLatest:@[RACObserve(self, number1),RACObserve(self, number2),RACObserve(self, number3),RACObserve(self, number4),RACObserve(self, number5),RACObserve(self, number6),RACObserve(self, number7)] reduce:^id(NSNumber * number1,NSNumber * number2,NSNumber * number3,NSNumber * number4,NSNumber * number5,NSNumber * number6,NSNumber * number7)
        {
            //&&number2.integerValue!=0&&number3.integerValue!=0&&number4.integerValue!=0&&number5.integerValue!=0&&number6.integerValue!=0&&number7.integerValue!=0
            return @((number1.integerValue!=0)&&(number2.integerValue!=0)&&(number3.integerValue!=0)&&(number4.integerValue!=0)&&(number5.integerValue!=0)&&(number6.integerValue!=0)&&(number7.integerValue!=0));
        }];
}

-(void)configSubviews
{
    self.number1=[NSNumber numberWithInteger:0];
    self.number2=[NSNumber numberWithInteger:0];
    self.number3=[NSNumber numberWithInteger:0];
    self.number4=[NSNumber numberWithInteger:0];
    self.number5=[NSNumber numberWithInteger:0];
    self.number6=[NSNumber numberWithInteger:0];
    self.number7=[NSNumber numberWithInteger:0];
    
    
    //底部符合条件视图
    UIView * toolBarView=[[UIView alloc]init];
    [self.view addSubview:toolBarView];
    self.toolBarView=toolBarView;
    toolBarView.backgroundColor=[UIColor whiteColor];
    [toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
        make.height.equalTo(80);
    }];
    //重置按钮
    UIButton * resetBtn=[[UIButton alloc]init];
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [resetBtn addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBarView addSubview:resetBtn];
    [resetBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.bottom.equalTo(0);
        make.width.equalTo(80);
    }];
    //符合条件按钮
    UIButton * eligibleBtn=[[UIButton alloc]init];
    [eligibleBtn setBackgroundColor:[UIColor redColor]];
    [eligibleBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [eligibleBtn setTitle:@"有0个车型符合条件" forState:UIControlStateNormal];
    [self.toolBarView addSubview:eligibleBtn];
    self.eligibleBtn=eligibleBtn;
    [self.eligibleBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(resetBtn.mas_right);
        make.right.equalTo(-10);
        make.top.equalTo(15);
        make.bottom.equalTo(-15);
    }];
    
    
    
    //tableview
    self.tableView=[[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.top.equalTo(0);
        make.bottom.equalTo(toolBarView.mas_top);
    }];
    self.view.backgroundColor=[UIColor redColor];
    TSDrawView * drawView=[[TSDrawView alloc]initWithFrame:CGRectMake(0, 0, SCRW, 150)];
    self.tableView.tableHeaderView=drawView;
    self.drawView=drawView;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    

}
-(void)resetAction
{
    NSLog(@"resetAction");
}
-(void)searchAction
{
    NSLog(@"searchAction");
}
-(void)valueChangedForSearchBtn
{
    NSString * path1=@"http://autoapp.auto.sohu.com/api/search/count";
    NSInteger bigNumber=self.drawView.bigNumber;
    if (bigNumber>100)
    {
        bigNumber=0;
    }
    NSString * path2=[NSString stringWithFormat:@"-1024-%@-%@-%@-%@-%@-%@-%@-%ld-%ld",self.numberArray[0],self.numberArray[1],self.numberArray[2],self.numberArray[3],self.numberArray[4],self.numberArray[5],self.numberArray[6],self.drawView.smallNumber,bigNumber];
    NSString * path = [NSString stringWithFormat:@"%@%@",path1,path2];
    [[WJHttpTool httpTool]get:path params:nil success:^(NSDictionary * result)
    {
        NSString * title=[NSString stringWithFormat:@"有%@个车型符合条件",result[@"count"]];
        [self.eligibleBtn setTitle:title forState:UIControlStateNormal];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
/*
 http://autoapp.auto.sohu.com/api/search/count-1024-0-3-0-0-0-0-0-0-0
 http://autoapp.auto.sohu.com/api/search/count-1024-0-7-0-0-0-0-0-0-0
 http://autoapp.auto.sohu.com/api/search/count-1024-0-7-0-0-0-0-0-0-25
 http://autoapp.auto.sohu.com/api/search/count-1024-0-7-0-0-0-0-0-11-25
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSTitleCell * cell=[TSTitleCell cellWithTableView:tableView];
    cell.nameLabel.text=self.titleArray[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TSSpecificController * spec=[TSSpecificController specificControllerWithArray:self.specicsArray[indexPath.row] andTitle:self.titleArray[indexPath.row]];
    [spec setTSSpecificControllerRetBlock:^(TSSpecificController *sp, NSNumber * number, NSArray *selectArray)
    {
       //判断行数，改变请求数字
        NSInteger selectInteger = [self.titleArray indexOfObject:sp.titleStr];
        self.numberArray[selectInteger]=number;
        
        NSIndexPath * index=[NSIndexPath indexPathForRow:selectInteger inSection:0];
        TSTitleCell * cell = [tableView cellForRowAtIndexPath:index];
        //改变cell字符串
        NSString * str=[NSString string];
        for (int i = 0 ; i<selectArray.count; i++)
        {
            if (str!=nil&&str.length!=0)
            {
                str=[str stringByAppendingString:@","];
            }
            str=[str stringByAppendingString:selectArray[i]];
        }
        cell.dtLabel.text=str;
        [cell.dtLabel setTextColor:[UIColor blueColor]];
        
        if (number.integerValue==0)
        {
            cell.dtLabel.text=@"不限";
            [cell.dtLabel setTextColor:[UIColor grayColor]];
        }
    
        //进行请求
        [self valueChangedForSearchBtn];
    }];
    [self presentViewController:spec animated:YES completion:nil];
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
