
//
//  DetailViewController.m
//  LeftSlide
//
//  Created by 夏桂峰 on 16/3/28.
//  Copyright © 2016年 夏桂峰. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    [self.view addSubview:lb];
    lb.center=self.view.center;
    lb.text=self.msg;
    lb.textAlignment=NSTextAlignmentCenter;
    
}

@end
