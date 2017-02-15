//
//  AppDelegate.m
//  QY.163Demo
//
//  Created by Cijian on 2017/2/11.
//  Copyright © 2017年 Cijian. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "QYSDK.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[QYSDK sharedSDK] registerAppId:@"14d2e3ebd8a91a19644d84fa8a9b9d81" appName:@"QY.163Demo"];
    
    
    
    //注册 APNS
    if ([[UIApplication sharedApplication]
         respondsToSelector:@selector(registerForRemoteNotifications)])
    {
        UIUserNotificationType types = UIRemoteNotificationTypeBadge
        | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert;
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        UIRemoteNotificationType types = UIRemoteNotificationTypeAlert
        | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }
    
    
    QYUserInfo *userInfo = [[QYUserInfo alloc] init];
    userInfo.userId = @"QYUserInfo.userId";
    NSMutableArray *array = [NSMutableArray new];
    NSMutableDictionary *dictRealName = [NSMutableDictionary new];
    [dictRealName setObject:@"real_name" forKey:@"key"];
    [dictRealName setObject:@"边晨" forKey:@"value"];
    [array addObject:dictRealName];
    NSMutableDictionary *dictMobilePhone = [NSMutableDictionary new];
    [dictMobilePhone setObject:@"mobile_phone" forKey:@"key"];
    [dictMobilePhone setObject:@"13805713536" forKey:@"value"];
    [dictMobilePhone setObject:@(NO) forKey:@"hidden"];
    [array addObject:dictMobilePhone];
    NSMutableDictionary *dictEmail = [NSMutableDictionary new];
    [dictEmail setObject:@"email" forKey:@"key"];
    [dictEmail setObject:@"bianchen@163.com" forKey:@"value"];
    [array addObject:dictEmail];
    NSMutableDictionary *dictAuthentication = [NSMutableDictionary new];
    [dictAuthentication setObject:@"0" forKey:@"index"];
    [dictAuthentication setObject:@"authentication" forKey:@"key"];
    [dictAuthentication setObject:@"实名认证" forKey:@"label"];
    [dictAuthentication setObject:@"已认证" forKey:@"value"];
    [array addObject:dictAuthentication];
    NSMutableDictionary *dictBankcard = [NSMutableDictionary new];
    [dictBankcard setObject:@"1" forKey:@"index"];
    [dictBankcard setObject:@"bankcard" forKey:@"key"];
    [dictBankcard setObject:@"绑定银行卡" forKey:@"label"];
    [dictBankcard setObject:@"622202******01116068" forKey:@"value"];
    [array addObject:dictBankcard];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:array
                                                   options:0
                                                     error:nil];
    if (data)
    {
        userInfo.data = [[NSString alloc] initWithData:data
                                              encoding:NSUTF8StringEncoding];
    }
    
    [[QYSDK sharedSDK] setUserInfo:userInfo];
    
    
    //判断接收信息
    if (launchOptions) {
        NSDictionary *dicUserInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    }
    
    
    return YES;
}

#pragma mark -推送
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    if (deviceToken) {
        NSLog(@"获取deviceToken成功!");
    }else {
        NSLog(@"获取deviceToken失败!");
    }
    
    [[QYSDK sharedSDK] updateApnsToken:deviceToken];
}

#pragma mark -接收推送信息
- (void)application:(UIApplication *)application didReceiveRemoteNotification: (NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    NSLog(@"%@",userInfo[@"aps"][@"alert"]);
    NSLog(@"%@",[(UINavigationController *)self.window.rootViewController visibleViewController]);
    ViewController *vc = (ViewController *)[(UINavigationController *)self.window.rootViewController visibleViewController];
    if ([vc isKindOfClass:[ViewController class]]) {
        [vc click:nil];
    }
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    NSInteger count = [[[QYSDK sharedSDK] conversationManager] allUnreadCount];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
