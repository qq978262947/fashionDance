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
#import "TSSXTableController.h"
#import "UIImage+reSize.h"

@interface TSTJZCController ()<UITableViewDelegate,UITableViewDataSource>
//标题数组
@property (nonatomic,strong)NSMutableArray * titleArray;
//详细选项数组
@property (nonatomic,strong)NSArray * specicsArray;
//已选择的选项数组
@property (nonatomic,strong)NSMutableArray * selectArray;
@property (nonatomic,strong)NSString * selectString;

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)TSDrawView * drawView;
@property (nonatomic,strong)UIView * toolBarView;
@property (nonatomic,strong)UIButton * resetBtn;
//符合条件按钮
@property (nonatomic,strong)UIButton * eligibleBtn;
@end

@implementation TSTJZCController
-(NSString *)selectString
{
    if (_selectString==nil)
    {
        _selectString=@"000000000";
    }
    return _selectString;
}
-(NSMutableArray *)selectArray
{
    if (_selectArray==nil)
    {
        _selectArray=[NSMutableArray array];
        for (int i = 0;i<7;i++)
        {
            //一开始存七个空字符串
            [_selectArray addObject:@""];
        }
    }
    return _selectArray;
}
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
}

-(void)configSubviews
{
    //底部符合条件视图
    UIView * toolBarView=[[UIView alloc]init];
    [self.view addSubview:toolBarView];
    self.toolBarView=toolBarView;
    toolBarView.backgroundColor=[UIColor whiteColor];
    [toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(-TabbarH);
        make.height.equalTo(80);
    }];
    //重置按钮
    UIButton * resetBtn=[[UIButton alloc]init];
    self.resetBtn=resetBtn;
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
    eligibleBtn.layer.cornerRadius=5;
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
    //拖动更新
    __weak typeof(self) weakSelf=self;
    [self.drawView setTSDrawViewDragBlock:^(TSDrawView * draw,BOOL isSamll) {
        [weakSelf valueChangedForSearchBtn];
        if (isSamll)
        {
            //判断是否修改
            if (draw.smallNum.integerValue==0)
            {
                NSString * str1=[weakSelf.selectString substringToIndex:7];
                NSString * str2=[weakSelf.selectString substringFromIndex:8];
                weakSelf.selectString=[NSString stringWithFormat:@"%@0%@",str1,str2];

            }
            else
            {
                NSString * str1=[weakSelf.selectString substringToIndex:7];
                NSString * str2=[weakSelf.selectString substringFromIndex:8];
                weakSelf.selectString=[NSString stringWithFormat:@"%@1%@",str1,str2];
            }
        }
        else
        {
            //判断是否修改
            if (draw.bigNumber==101)
            {
                NSString * str1=[weakSelf.selectString substringToIndex:8];
                NSString * str2=[weakSelf.selectString substringFromIndex:9];
                weakSelf.selectString=[NSString stringWithFormat:@"%@0%@",str1,str2];
                             //   NSLog(@"%@,%@,%@",str1,str2,weakSelf.selectString);
            }
            else
            {
                NSString * str1=[weakSelf.selectString substringToIndex:8];
                NSString * str2=[weakSelf.selectString substringFromIndex:9];
                weakSelf.selectString=[NSString stringWithFormat:@"%@1%@",str1,str2];
            }
        }
    }];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    RAC(resetBtn,enabled)=[RACSignal combineLatest:@[RACObserve(self, selectString)] reduce:^id(NSString * selectString)
                                {
                                    return @(![selectString isEqualToString:@"000000000"]);
                                }];
}
-(void)resetAction
{
    //归零
    self.numberArray=nil;
    //清除文字
    self.selectArray=nil;
    //清除标记
    self.selectString=nil;
    //图标归位
    [self.drawView clears];
    [self.tableView reloadData];
    [self valueChangedForSearchBtn];

}
-(void)searchAction
{
    NSString * path1=@"http://autoapp.auto.sohu.com/api/search/result";
    NSInteger bigNumber=self.drawView.bigNumber;
    if (bigNumber>100)
    {
        bigNumber=0;
    }
    NSString * path2=[NSString stringWithFormat:@"-1024-%@-%@-%@-%@-%@-%@-%@-%ld-%ld",self.numberArray[0],self.numberArray[1],self.numberArray[2],self.numberArray[3],self.numberArray[4],self.numberArray[5],self.numberArray[6],self.drawView.smallNumber,bigNumber];
    NSString * path = [NSString stringWithFormat:@"%@%@",path1,path2];
    TSSXTableController * sxCtl=[TSSXTableController tableControllerWithUrl:path];
    [self.navigationController pushViewController:sxCtl animated:YES];

}
//数值改变进行请求
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
        
    } failure:^(NSError *error)
    {
        NSLog(@"%@",error);
    }];
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
    cell.dtLabel.text=self.selectArray[indexPath.row];
    cell.dtLabel.textColor=WJColor(120, 220, 230);
    if (cell.dtLabel.text==nil||cell.dtLabel.text.length==0)
    {
        cell.dtLabel.text=@"不限";
        cell.dtLabel.textColor=[UIColor grayColor];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIImage *image = [UIImage captureWithView:[UIApplication sharedApplication].keyWindow];
    [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor colorWithPatternImage:image];
    
    TSSpecificController * spec=[TSSpecificController specificControllerWithArray:self.specicsArray[indexPath.row] andTitle:self.titleArray[indexPath.row]];
    //返回传值
    [spec setTSSpecificControllerRetBlock:^(TSSpecificController *sp, NSNumber * number, NSArray *selectArray)
    {
       //判断行数，改变请求数字
        NSInteger selectInteger = [self.titleArray indexOfObject:sp.titleStr];
        self.numberArray[selectInteger]=number;
        
        if (selectArray.count!=0)
        {
            //不为零，设置为1
            NSString * str1=[self.selectString substringToIndex:selectInteger];
            NSString * str2=[self.selectString substringFromIndex:selectInteger+1];
            self.selectString=[NSString stringWithFormat:@"%@1%@",str1,str2];
        }
        else
        {
            //为0就不拼接设置0
            NSString * str1=[self.selectString substringToIndex:selectInteger];
            NSString * str2=[self.selectString substringFromIndex:selectInteger+1];
            self.selectString=[NSString stringWithFormat:@"%@0%@",str1,str2];
        }

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
        self.selectArray[selectInteger]=str;

        //进行请求
        [self valueChangedForSearchBtn];
        [self.tableView reloadData];
    }];
    [self presentViewController:spec animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
