//
//  GameOverViewController.h
//  Easy_Dodge
//
//  Created by irons on 2015/7/3.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol gameDelegate;

@interface GameOverViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *gameTimeLabel;

- (IBAction)restartClick:(id)sender;

@property (weak) id<gameDelegate> gameDelegate;
@property int gameScoreForDistance;

@end
