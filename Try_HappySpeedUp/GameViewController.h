//
//  GameViewController.h
//  Try_HappySpeedUp
//

//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@protocol gameDelegate <NSObject>

- (void)showGameOver;
- (void)showRankView;
- (void)restartGame;

@end

@interface GameViewController : UIViewController<gameDelegate>

@end
