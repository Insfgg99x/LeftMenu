//
//  ViewController.m
//  LeftSlide
//
//  Created by 夏桂峰 on 16/3/28.
//  Copyright © 2016年 夏桂峰. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self createData];
    [self createTbView];
}
-(void)setup
{
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.title=@"原生左滑多菜单";
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    _dataArray=[NSMutableArray array];
}
-(void)createData
{
    for(int i=0;i<10;i++)
    {
        [_dataArray addObject:[NSString stringWithFormat:@"%016zd",i]];
    }
}
-(void)createTbView
{
    UITableView *tbView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    tbView.delegate=self;
    tbView.dataSource=self;
    [self.view addSubview:tbView];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cid=@"cid";
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if(!cell)
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
    cell.textLabel.text=_dataArray[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
//左滑菜单项
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) wkSelf=self;
    //删除
    UITableViewRowAction *deleteAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删掉" handler:^(UITableViewRowAction *  action, NSIndexPath *  indexPath) {
    
        [wkSelf.dataArray removeObjectAtIndex:indexPath.row];
        [tableView setEditing:NO animated:YES];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    //置顶
    UITableViewRowAction *topAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction * action, NSIndexPath * indexPath) {
        id obj=[wkSelf.dataArray objectAtIndex:indexPath.row];
        [wkSelf.dataArray removeObjectAtIndex:indexPath.row];
        [wkSelf.dataArray insertObject:obj atIndex:0];
        [tableView setEditing:NO animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tableView reloadData];
        });
    }];
    topAction.backgroundColor=[UIColor orangeColor];
    
    return @[deleteAction,topAction];
}
//选中cell (当cell的左滑打开时，点击cell，关闭左滑，默认情况下跳转第二个页面)
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail=[DetailViewController new];
    detail.msg=[_dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}
@end
