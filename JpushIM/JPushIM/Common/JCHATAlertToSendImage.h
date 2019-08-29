//
//  JCHATAlertToSendImage.h
//  JChat
//
//  Created by oshumini on 15/12/9.
//  Copyright © 2015年 HXHG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface JCHATAlertToSendImage : NSObject
@property (nonatomic, strong) UIView *alertView;
//@property(strong, nonatomic)UIView *alertView;
@property(strong, nonatomic)UIImage *preImage;
+ (JCHATAlertToSendImage *)shareInstance;

- (void)showInViewWith:(UIImage *) image;
- (void)removeAlertView;
@end
