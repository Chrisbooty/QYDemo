//
//  ViewController.m
//  QY.163Demo
//
//  Created by Cijian on 2017/2/11.
//  Copyright © 2017年 Cijian. All rights reserved.
//

#import "ViewController.h"
#import "QYSDK.h"
#import "QYSessionViewController.h"
#import "QYSource.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)click:(id)sender {
    QYSource *source = [[QYSource alloc] init];
    source.title =  @"Chris客服1111";
    source.urlString = @"https://chriswu.qiyukf.com/";
    QYSessionViewController *sessionViewController = [[QYSDK sharedSDK] sessionViewController];
    sessionViewController.sessionTitle = @"Chris客服222";
    sessionViewController.source = source;
    sessionViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sessionViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
