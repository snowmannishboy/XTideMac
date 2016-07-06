//
//  XTSessionDelegate.m
//  XTide
//
//  Created by Lee Ann Rucker on 7/5/16.
//  Copyright © 2016 Lee Ann Rucker. All rights reserved.
//

#import "XTSessionDelegate.h"

NSString * const XTSessionReachabilityDidChangeNotification = @"XTSessionReachabilityDidChangeNotification";
NSString * const XTSessionAppContextNotification = @"XTSessionAppContextNotification";
NSString * const XTSessionUserInfoNotification = @"XTSessionUserInfoNotification";

@implementation XTSessionDelegate

+ (instancetype)sharedDelegate
{
    static XTSessionDelegate *sharedDelegate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDelegate = [[self alloc] init];
        [WCSession defaultSession].delegate = sharedDelegate;
        [[WCSession defaultSession] activateSession];
    });
    return sharedDelegate;
}


- (void)sessionReachabilityDidChange:(WCSession *)session
{
    [[NSNotificationCenter defaultCenter]
                postNotificationName:XTSessionReachabilityDidChangeNotification
							  object:self];
}


- (void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *,id> *)applicationContext
{
    [[NSNotificationCenter defaultCenter]
                postNotificationName:XTSessionAppContextNotification
							  object:self
                              userInfo:applicationContext];
}


- (void)session:(WCSession *)session didReceiveUserInfo:(NSDictionary<NSString *,id> *)userInfo
{
    [[NSNotificationCenter defaultCenter]
                postNotificationName:XTSessionUserInfoNotification
							  object:self
                            userInfo:userInfo];
}

@end
