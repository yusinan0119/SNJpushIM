//
//  AppDelegate.h
//  JpushIM
//
//  Created by 小花瓣 on 2019/7/14.
//  Copyright © 2019 小花瓣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JMessage/JMessage.h>

#define JMESSAGE_APPKEY @"4f7aef34fb361292c566a1cd"
#define CHANNEL @"Publish channel"

@interface AppDelegate : UIResponder <UIApplicationDelegate, JMessageDelegate>
{
    UIAlertView *myAlertView;
}
@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic)BOOL isDBMigrating;


@end

