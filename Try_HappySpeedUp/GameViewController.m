//
//  GameViewController.m
//  Try_HappySpeedUp
//
//  Created by irons on 2015/9/21.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "GameOverViewController.h"
#import "GameCenterUtil.h"

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation GameViewController{
    ADBannerView * adBannerView;
    GameScene* scene;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
//    GameScene *scene = [GameScene unarchiveFromFile:@"GameScene"];
//    scene = [GameScene sceneWithSize:self.view.bounds.size];
    
    [self initAndaddScene:skView];
    
    adBannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, -50, 200, 30)];
    adBannerView.delegate = self;
    adBannerView.alpha = 1.0f;
    [self.view addSubview:adBannerView];
}

-(void)initAndaddScene:(SKView*)skView{
    // Create and configure the scene.
//    scene = [GameScene unarchiveFromFile:@"GameScene"];
    scene = [GameScene sceneWithSize:self.view.bounds.size];
    scene.size = self.view.frame.size;
    scene.scaleMode = SKSceneScaleModeAspectFill;
    scene.gameDelegate = self;
    
    // Present the scene.
    [skView presentScene:scene];
}

-(void) showRankView{
    GameCenterUtil * gameCenterUtil = [GameCenterUtil sharedInstance];
    gameCenterUtil.delegate = self;
    [gameCenterUtil isGameCenterAvailable];
    //    [gameCenterUtil authenticateLocalUser:self];
    [gameCenterUtil showGameCenter:self];
    [gameCenterUtil submitAllSavedScores];
}

-(void)showGameOver{
    //    return;
    GameOverViewController* gameOverDialogViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GameOverViewController"];
    gameOverDialogViewController.gameDelegate = self;
    
    gameOverDialogViewController.gameScoreForDistance = scene.gameScoreForDistance;
    
    self.navigationController.providesPresentationContextTransitionStyle = YES;
    self.navigationController.definesPresentationContext = YES;
    
    [gameOverDialogViewController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    [self presentViewController:gameOverDialogViewController animated:YES completion:^{
        //        [reset];
    }];
    
}

-(void)restartGame{
    SKView * skView = (SKView *)self.view;
    [self initAndaddScene:skView];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    [self layoutAnimated:true];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    //    [adBannerView removeFromSuperview];
    //    adBannerView.delegate = nil;
    //    adBannerView = nil;
    [self layoutAnimated:true];
}

-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    //    [MyScene setAllGameRun:NO];
    return true;
}

- (void)layoutAnimated:(BOOL)animated
{
    //    CGRect contentFrame = self.view.bounds;
    
    CGRect contentFrame = self.view.bounds;
    //    contentFrame.origin.y = -50;
    CGRect bannerFrame = adBannerView.frame;
    if (adBannerView.bannerLoaded)
    {
        //        contentFrame.size.height -= adBannerView.frame.size.height;
        contentFrame.size.height = 0;
        bannerFrame.origin.y = contentFrame.size.height;
    } else {
        //        bannerFrame.origin.y = contentFrame.size.height;
        bannerFrame.origin.y = -50;
    }
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
        adBannerView.frame = contentFrame;
        [adBannerView layoutIfNeeded];
        adBannerView.frame = bannerFrame;
    }];
}

@end
