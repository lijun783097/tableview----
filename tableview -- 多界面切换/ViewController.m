//
//  ViewController.m
//  tableview -- 多界面切换
//
//  Created by 镇微 on 2017/7/20.
//  Copyright © 2017年 镇微. All rights reserved.
//

#import "ViewController.h"
#import "MTSegmentedControl.h"
#import "CommonHtml5Controller.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MTSegmentedControl *segumentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.segumentView segmentedControl:@[@"综合",@"收益高",@"期限短"] Delegate:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickedBtn:(UIButton *)sender
{
    CommonHtml5Controller *htmlVC = [[CommonHtml5Controller alloc] init];
    
    htmlVC.htmlUrl = @"https://www.microtown.cn/appPage/recomPage1.jsp?fromAccount=9062477";
    
    [self.navigationController pushViewController:htmlVC animated:YES];
}
@end
