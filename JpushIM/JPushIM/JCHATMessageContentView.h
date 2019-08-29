//
//  JCHATMessageContentView.h
//  JChat
//
//  Created by HuminiOS on 15/11/2.
//  Copyright © 2015年 HXHG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatImageBubble.h"
#import <JMessage/JMessage.h>

@interface JCHATMessageContentView :UIImageView
@property(assign, nonatomic)BOOL isReceivedSide;

@property(strong, nonatomic)UILabel *textContent;
@property(strong, nonatomic)UIImageView *voiceConent;
@property(strong, nonatomic)JMSGMessage *message;
- (void)setMessageContentWith:(JMSGMessage *)message;

- (void)setMessageContentWith:(JMSGMessage *)message handler:(void(^)(NSUInteger messageMediaDataLength))block;

@end
