//
//  AppDelegate.m
//  JpushIM
//
//  Created by 小花瓣 on 2019/7/14.
//  Copyright © 2019 小花瓣. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "JPushIM/Common/JCHATFileManager.h"
#import "JPushIM/JChatConstants.h"

@interface AppDelegate ()<UIApplicationDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = UIColor.whiteColor;
    
    ViewController *vc = [[ViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    [JMessage addDelegate:self withConversation:nil];
    
    //    [JMessage setLogOFF];
    [JMessage setDebugMode];
    [JMessage setupJMessage:launchOptions
                     appKey:@"876d9ec7883dc19006006213"
                    channel:CHANNEL
           apsForProduction:NO
                   category:nil
             messageRoaming:YES];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JMessage registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                      UIUserNotificationTypeSound |
                                                      UIUserNotificationTypeAlert)
                                          categories:nil];
    } else {
        //categories 必须为nil
        [JMessage registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                      UIRemoteNotificationTypeSound |
                                                      UIRemoteNotificationTypeAlert)
                                          categories:nil];
    }
    
    [self registerJPushStatusNotification];
    
    [JCHATFileManager initWithFilePath];//demo 初始化存储路径

    [JMessage resetBadge];

    
    return YES;
}


- (void)registerJPushStatusNotification {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidSetup:)
                          name:kJMSGNetworkDidSetupNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkIsConnecting:)
                          name:kJMSGNetworkIsConnectingNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidClose:)
                          name:kJMSGNetworkDidCloseNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidRegister:)
                          name:kJMSGNetworkDidRegisterNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidLogin:)
                          name:kJMSGNetworkDidLoginNotification
                        object:nil];
    
    [defaultCenter addObserver:self
                      selector:@selector(receivePushMessage:)
                          name:kJMSGNetworkDidReceiveMessageNotification
                        object:nil];
    
}

#pragma - mark JMessageDelegate
- (void)onReceiveNotificationEvent:(JMSGNotificationEvent *)event{
    SInt32 eventType = (JMSGEventNotificationType)event.eventType;
    switch (eventType) {
        case kJMSGEventNotificationCurrentUserInfoChange:{
            NSLog(@"Current user info change Notification Event ");
        }
            break;
        case kJMSGEventNotificationReceiveFriendInvitation:
        case kJMSGEventNotificationAcceptedFriendInvitation:
        case kJMSGEventNotificationDeclinedFriendInvitation:
        case kJMSGEventNotificationDeletedFriend:
        {
            //JMSGFriendNotificationEvent *friendEvent = (JMSGFriendNotificationEvent *)event;
            NSLog(@"Friend Notification Event");
        }
            break;
        case kJMSGEventNotificationReceiveServerFriendUpdate:
            NSLog(@"Receive Server Friend update Notification Event");
            break;
            
            
        case kJMSGEventNotificationLoginKicked:
            NSLog(@"LoginKicked Notification Event ");
        case kJMSGEventNotificationServerAlterPassword:{
            if (event.eventType == kJMSGEventNotificationServerAlterPassword) {
                NSLog(@"AlterPassword Notification Event ");
            }
        case kJMSGEventNotificationUserLoginStatusUnexpected:
            if (event.eventType == kJMSGEventNotificationServerAlterPassword) {
                NSLog(@"User login status unexpected Notification Event ");
            }
            if (!myAlertView) {
                myAlertView =[[UIAlertView alloc] initWithTitle:@"登录状态出错"
                                                        message:event.eventDescription
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
                [myAlertView show];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)onDBMigrateStart {
    NSLog(@"onDBmigrateStart in appdelegate");
    _isDBMigrating = YES;
}

- (void)onDBMigrateFinishedWithError:(NSError *)error {
    NSLog(@"onDBmigrateFinish in appdelegate");
    _isDBMigrating = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:kDBMigrateFinishNotification object:nil];
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kuserName];
//    [JMSGUser logout:^(id resultObject, NSError *error) {
//        NSLog(@"Logout callback with - %@", error);
//    }];
//    JCHATAlreadyLoginViewController *loginCtl = [[JCHATAlreadyLoginViewController alloc] init];
//    loginCtl.hidesBottomBarWhenPushed = YES;
//    UINavigationController *navLogin = [[UINavigationController alloc] initWithRootViewController:loginCtl];
//    self.window.rootViewController = navLogin;
//
//    myAlertView = nil;
//    return;
//}


- (void)networkDidSetup:(NSNotification *)notification {
//    DDLogDebug(@"Event - networkDidSetup");
}

- (void)networkIsConnecting:(NSNotification *)notification {
//    DDLogDebug(@"Event - networkIsConnecting");
}

- (void)networkDidClose:(NSNotification *)notification {
//    DDLogDebug(@"Event - networkDidClose");
}

- (void)networkDidRegister:(NSNotification *)notification {
//    DDLogDebug(@"Event - networkDidRegister");
}

- (void)networkDidLogin:(NSNotification *)notification {
//    DDLogDebug(@"Event - networkDidLogin");
}

- (void)receivePushMessage:(NSNotification *)notification {
//    DDLogDebug(@"Event - receivePushMessage");
    
    NSDictionary *info = notification.userInfo;
    if (info) {
//        DDLogDebug(@"The message - %@", info);
    } else {
//        DDLogWarn(@"Unexpected - no user info in jpush mesasge");
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    application.applicationIconBadgeNumber = 0;
    [application cancelAllLocalNotifications];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application cancelAllLocalNotifications];

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [JMessage resetBadge];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    DDLogInfo(@"Action - didRegisterForRemoteNotificationsWithDeviceToken");
//    DDLogVerbose(@"Got Device Token - %@", deviceToken);
    
    [JMessage registerDeviceToken:deviceToken];
}


@end
