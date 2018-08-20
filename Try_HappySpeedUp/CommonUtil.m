//
//  CommonUtil.m
//  Try_downStage
//
//  Created by irons on 2015/6/23.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "CommonUtil.h"

static CommonUtil* instance;

@implementation CommonUtil

+ (id)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

@end
