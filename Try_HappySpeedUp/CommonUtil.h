//
//  CommonUtil.h
//  Try_downStage
//
//  Created by irons on 2015/6/23.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CommonUtil : SKSpriteNode

@property float screenHeight;
@property float screenWidth;

+ (id)sharedInstance;

@end
