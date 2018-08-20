//
//  Wall.h
//  Try_HappySpeedUp
//
//  Created by irons on 2015/9/21.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Wall : SKSpriteNode

-(BOOL)isNeedCreateNewInstance;
-(BOOL)isNeedRemoveInstance;
-(void)move;
-(void)move:(float)speedY;
@end
