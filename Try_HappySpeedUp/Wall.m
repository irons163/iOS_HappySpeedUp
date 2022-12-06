//
//  Wall.m
//  Try_HappySpeedUp
//
//  Created by irons on 2015/9/21.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "Wall.h"

@implementation Wall

- (BOOL)isNeedCreateNewInstance {
    bool isNeedCreateNewInstance = false;
    if (self.position.y >= 50) {
        isNeedCreateNewInstance = true;
    }
    return isNeedCreateNewInstance;
}

- (BOOL)isNeedRemoveInstance {
    bool isNeedRemoveInstance = false;
    if (self.position.y <= 0) {
        isNeedRemoveInstance = true;
    }
    return isNeedRemoveInstance;
}

- (void)move {
    self.position = CGPointMake(self.position.x, self.position.y - 3);
}

- (void)move:(float)speedY {
    self.position = CGPointMake(self.position.x, self.position.y - speedY);
}

@end
