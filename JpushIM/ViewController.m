//
//  ViewController.m
//  JpushIM
//
//  Created by 小花瓣 on 2019/7/14.
//  Copyright © 2019 小花瓣. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"
#import "JPushIM/JChatConstants.h"
#import "JCHATStringUtils.h"
#import "JCHATConversationViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登陆";
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"登陆" forState:UIControlStateNormal];
    [button setBackgroundColor:UIColor.orangeColor];
    button.layer.cornerRadius = 5;
    [button setFrame:CGRectMake(30, 300, self.view.frame.size.width-60, 44)];
    [button addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dBMigrateFinish)
                                                 name:kDBMigrateFinishNotification object:nil];
    
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    if (appDelegate.isDBMigrating) {
        NSLog(@"is DBMigrating don't get allconversations");
        [MBProgressHUD showMessage:@"正在升级数据库" toView:self.view];
    }
}


- (void)dBMigrateFinish {
    JCHATMAINTHREAD(^{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    });
}

-(void)login {
    
    [JMSGUser loginWithUsername:@"10000095"
                       password:@"10000095"
              completionHandler:^(id resultObject, NSError *error) {
                  if (error == nil) {
                      [[NSUserDefaults standardUserDefaults] setObject:@"10000095" forKey:klastLoginUserName];
                      AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;

                      // 显示登录状态？
                      [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
                      
                      [[NSNotificationCenter defaultCenter] postNotificationName:kupdateUserInfo object:nil];
                      

                      
                      JCHATConversationViewController *chatVC = [[JCHATConversationViewController alloc]init];
                      
                      [JMSGConversation createSingleConversationWithUsername:@"9999999" completionHandler:^(id resultObject, NSError *error) {
                          
                          chatVC.conversation = resultObject;
                          
                          JCHATMAINTHREAD(^{
                              
                              [self.navigationController pushViewController:chatVC animated:YES];

                          });
                          
                      }];
                      
                      
                  } else {
                      JCHATMAINTHREAD(^{
                          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                      });
                      [MBProgressHUD showMessage:[JCHATStringUtils errorAlert:error] view:self.view];
                  }
              }];
}


@end
