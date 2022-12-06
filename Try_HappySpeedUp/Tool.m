//
//  Tool.m
//  Try_HappySpeedUp
//
//  Created by irons on 2015/9/25.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "Tool.h"

@implementation Tool

- (BOOL)isNeedRemoveInstance {
    bool isNeedRemoveInstance = false;
    if (self.position.y < 0) {
        isNeedRemoveInstance = true;
    }
    return isNeedRemoveInstance;
}

@end
