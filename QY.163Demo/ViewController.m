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
    
    //设置sessionInfo 以及商品信息
    QYCommodityInfo *commodityInfo = [[QYCommodityInfo alloc] init];
    commodityInfo.title = @"原味虎皮鸡爪 - title";
    commodityInfo.desc = @"原味虎皮鸡爪 - desc";
    commodityInfo.pictureUrlString = @"http://qiyukf.com/main/res/img/index/barcode.png";
    commodityInfo.urlString = @"http://qiyukf.com/";
    commodityInfo.note = @"￥10000";
    commodityInfo.show = YES; //访客端是否要在消息中显示商品信息，YES代表显示,NO代表不显示
    
    sessionViewController.commodityInfo = commodityInfo;
    
    [self.navigationController pushViewController:sessionViewController animated:YES];
    
    [[QYSDK sharedSDK] registerPushMessageNotification:^(QYPushMessage *message) {
//        NSString *time = [self showTime:message.time showDetail:YES];
        NSString *content = [NSString stringWithFormat:@" 内容：%@", message.text] ;
        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"推送消息"
                                                         message:content delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [dialog show];
    }];
    
    
}

- (void)dealloc {
    [[QYSDK sharedSDK] logout:^(){}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
