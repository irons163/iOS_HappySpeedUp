//
//  GameScene.h
//  Try_HappySpeedUp
//

//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol gameDelegate;

@interface GameScene : SKScene

@property (weak) id<gameDelegate> gameDelegate;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;

-(int)gameScoreForDistance;

@end
