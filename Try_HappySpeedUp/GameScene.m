//
//  GameScene.m
//  Try_HappySpeedUp
//
//  Created by irons on 2015/9/21.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "GameScene.h"
#import "Player.h"
#import "Wall.h"
#import "CommonUtil.h"
#import "BitmapUtil.h"
#import "TextureHelper.h"
#import "GameCenterUtil.h"
#import "MyADView.h"
#import "MyUtils.h"
#import "Tool.h"

@implementation GameScene{
    int direction;
    BitmapUtil* bitmapUtil;
    int offsetX;
    int offsetY;
    SKSpriteNode * backgroundNode, * backgroundNode2;
    int backgroundMovePointsPerSec;
    int gameScoreForDistance;
    SKLabelNode* gameScoreForDistanceLabel;
    int distanceCount;
    int readyStep;
    NSTimer * theGameTimer, * theReadyTimer, *theToolTimer;
    SKLabelNode* readyLabel;
    bool readyFlag;
    SKSpriteNode * rankBtn;
    MyADView * myAdView;
    
    NSMutableArray * musicBtnTextures;
    
    SKSpriteNode * musicBtn;
    float speedX;
    float speedY;
    
    int toolTimeCount;
    bool flyFlag;
    
    bool toolCounterStart;
    bool checkEatToolable;
    
    bool gameFlag;
    NSMutableArray* walls;
    NSMutableArray* tools;
    Player *player;
}

-(void)initGame{
    gameFlag = true;
    readyFlag = true;
    flyFlag = false;
    toolCounterStart = false;
    checkEatToolable = true;
    readyStep = 0;
    speedX = BASE_SPEEDX;
    speedY = BASE_SPEEDY;

    ((CommonUtil*)[CommonUtil sharedInstance]).screenHeight = self.frame.size.height;
    ((CommonUtil*)[CommonUtil sharedInstance]).screenWidth = self.frame.size.width;
    bitmapUtil = [BitmapUtil sharedInstance];
    offsetX = bitmapUtil.wall_size.width;
    offsetY = bitmapUtil.wall_size.height;
//    offsetY = 0;
    readyLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    readyLabel.text = @"";
    readyLabel.fontSize = 80;
//    readyLabel.color = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
    readyLabel.fontColor = [UIColor redColor];
    readyLabel.position = CGPointMake(self.frame.size.width/2 - readyLabel.frame.size.width/2, self.frame.size.height/2 );
    
    [self addChild:readyLabel];
    
    rankBtn = [SKSpriteNode spriteNodeWithImageNamed:@"btnL_GameCenter-hd"];
    rankBtn.size = CGSizeMake(42,42);
    rankBtn.anchorPoint = CGPointMake(0, 0);
    rankBtn.position = CGPointMake(self.frame.size.width - rankBtn.size.width, self.frame.size.height/2);
    rankBtn.zPosition = 1;
    [self addChild:rankBtn];
    
    musicBtnTextures = [NSMutableArray array];
    [musicBtnTextures addObject:[SKTexture textureWithImageNamed:@"btn_Music-hd"]];
    [musicBtnTextures addObject:[SKTexture textureWithImageNamed:@"btn_Music_Select-hd"]];
    
    
    musicBtn = [SKSpriteNode spriteNodeWithImageNamed:@"btn_Music-hd"];
    musicBtn.size = CGSizeMake(42,42);
    musicBtn.anchorPoint = CGPointMake(0, 0);
    musicBtn.position = CGPointMake(self.frame.size.width - musicBtn.size.width, self.frame.size.height/2 - 42);
    musicBtn.zPosition = 1;
    [self addChild:musicBtn];
    
    NSArray* musics = [NSArray arrayWithObjects:@"am_white.mp3", @"biai.mp3", @"cafe.mp3", @"deformation.mp3", nil];
    
    int index = arc4random_uniform(4);
    [MyUtils preparePlayBackgroundMusic:musics[index]];
    
    id isPlayMusicObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"isPlayMusic"];
    BOOL isPlayMusic = true;
    if(isPlayMusicObject==nil){
        isPlayMusicObject = false;
    }else{
        isPlayMusic = [isPlayMusicObject boolValue];
    }
    if(isPlayMusic){
        [MyUtils backgroundMusicPlayerPlay];
        musicBtn.texture = musicBtnTextures[0];
    }else{
        [MyUtils backgroundMusicPlayerPause];
        musicBtn.texture = musicBtnTextures[1];
    }
    
    myAdView = [MyADView spriteNodeWithTexture:nil];
    myAdView.size = CGSizeMake(self.frame.size.width, self.frame.size.width/5.0f);
    //        myAdView.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - 35);
    myAdView.position = CGPointMake(self.frame.size.width/2, 0);
    [myAdView startAd];
    myAdView.zPosition = 1;
    myAdView.anchorPoint = CGPointMake(0.5, 0);
    [self addChild:myAdView];
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
//    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//    
//    myLabel.text = @"Hello, World!";
//    myLabel.fontSize = 65;
//    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
//                                   CGRectGetMidY(self.frame));
//    
//    [self addChild:myLabel];
    
    walls = [NSMutableArray array];
    tools = [NSMutableArray array];
    direction = DIRECTION_RIGHT;
    [self initGame];
    [self getBackground];
    
    [self addChild:backgroundNode];
    backgroundMovePointsPerSec = speedY;
    [self createInitWall];
    [self createPlayer];
    [self initGameScoreForDistanceLabel];
}

-(void)initReadyTimer{
    readyStep = 0;
    theReadyTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                     target:self
                                                   selector:@selector(countReadyTimer)
                                                   userInfo:nil
                                                    repeats:YES];
//    [timers addObject:theReadyTimer];
}

-(void)countReadyTimer{
    
    //    for (int i = 0; i < 4; i++) {
    //        readyStep = i;
    if (readyStep == 0) {
        
        //            canvas.drawText("READY", 150, height / 2, paint);
        readyLabel.text = @"READY";
        readyLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 );
    } else if(readyStep==5){
        readyLabel.hidden = YES;
        [theReadyTimer invalidate];
        readyFlag = false;
        return;
    }
    else {
        //            canvas.drawText(4 - readyStep + "", width / 2, height / 2,
        //                            paint);
        readyLabel.text = [NSString stringWithFormat:@"%d", 4 - readyStep];
//        readyLabel.position = CGPointMake(self.frame.size.width/2 - readyLabel.frame.size.width/2, self.frame.size.height/2 );
        readyLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 );
    }
    
    readyStep++;
    //        sleep(1);
    //    }
}

-(void)initToolTimer{
    readyStep = 0;
    theToolTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                     target:self
                                                   selector:@selector(countToolTimer)
                                                   userInfo:nil
                                                    repeats:YES];
    //    [timers addObject:theReadyTimer];
}

-(void)countToolTimer{
    if(toolCounterStart && toolTimeCount<=0){
        toolCounterStart = false;
        [self resetSpeed];
        return;
    }else if(!toolCounterStart){
        return;
    }
    toolTimeCount--;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        if(CGRectContainsPoint(rankBtn.calculateAccumulatedFrame, location)){
            //        rankBtn.texture = storeBtnClickTextureArray[PRESSED_TEXTURE_INDEX];
            
            [self.gameDelegate showRankView];
        }else if(CGRectContainsPoint(musicBtn.calculateAccumulatedFrame, location)){
            if([MyUtils isBackgroundMusicPlayerPlaying]){
                [MyUtils backgroundMusicPlayerPause];
                musicBtn.texture = musicBtnTextures[1];
                [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"isPlayMusic"];
            }else{
                [MyUtils backgroundMusicPlayerPlay];
                musicBtn.texture = musicBtnTextures[0];
                [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"isPlayMusic"];
            }
        }
    }
    
    direction = -direction;
    speedX = -speedX;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if(readyFlag && theReadyTimer==nil){
        [self initReadyTimer];
        [self initToolTimer];
    }
    
    if (!gameFlag || readyFlag)
        return;
    
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // 如果上次更新后得时间增量大于1秒
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
    
    
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    self.lastSpawnTimeInterval += timeSinceLast;
    if (self.lastSpawnTimeInterval > 0.05) {
        self.lastSpawnTimeInterval = 0;
        
        [self move];
        [self draw];
        if(checkEatToolable)
        [self checkEatTool];
        [self checkRemoveTools];
    }
    
}

const int BASE_SPEEDX = 6;
const int BASE_SPEEDY = 7.5;

const int TOOL_TIME = 10;

const int WALL_LEFT_AND_RIGHT_DISTANCE = 230;


int playerStartX = 160;
int platerStartY = 200;



int DIRECTION_LEFT = -1;
int DIRECTION_RIGHT = 1;


-(void) createInitWall {
    int wallLeftX = 40, wallRightX = wallLeftX + WALL_LEFT_AND_RIGHT_DISTANCE;
//    int wallY = ((CommonUtil*)[CommonUtil sharedInstance]).screenHeight;
    int wallY = 0;
    for (int i = 0; i < 60; i++) {
        [self createWallLineWithLeftX:wallLeftX WithRightX:wallRightX WithY:wallY enableOffsetX:false];
        wallY += offsetY;
    }
    
}

-(void) createWallLineWithLeftX:(int) wallLeftX WithRightX:(int) wallRightX WithY:(int) wallY enableOffsetX:(BOOL)enableOffsetX{
//    if (wallLeftX < 20) {
//        offsetX = -offsetX;
//    } else if (wallRightX > ((CommonUtil*)[CommonUtil sharedInstance]).screenWidth - 20
//               - bitmapUtil.wall_size.width) {
//        offsetX = -offsetX;
//    }

    if(enableOffsetX){
        int dir = arc4random_uniform(2);
        if(dir == 0){
            offsetX = -offsetX;
        }
        
        wallLeftX += offsetX;
        wallRightX += offsetX;
    }
    
    if (wallY >= ((CommonUtil*)[CommonUtil sharedInstance]).screenHeight+offsetY)
        return;
    
    wallY += offsetY;
    
//    System.out.println("wallY" + wallY);
    
    Wall* wallLeft = [Wall spriteNodeWithTexture:bitmapUtil.wall_bitmap];
    wallLeft.size = bitmapUtil.wall_size;
    wallLeft.position = CGPointMake(wallLeftX, wallY);
    wallLeft.xScale = -1;
    Wall* wallRight = [Wall spriteNodeWithTexture:bitmapUtil.wall_bitmap];
    wallRight.size = bitmapUtil.wall_size;
    wallRight.position = CGPointMake(wallRightX, wallY);
    [self addChild:wallLeft];
    [self addChild:wallRight];
    
    NSMutableArray* wallLine = [NSMutableArray array];
    [wallLine addObject:wallLeft];
    [wallLine addObject:wallRight];
    [walls addObject:wallLine];
}

-(void)initGameScoreForDistanceLabel{
//    gameScoreForDistanceLabel = [SKLabelNode labelNodeWithText:@"0"];
    gameScoreForDistanceLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    gameScoreForDistanceLabel.text = @"0";
    gameScoreForDistanceLabel.fontSize = 30;
    gameScoreForDistanceLabel.fontColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.7 alpha:1.0];
    gameScoreForDistanceLabel.position = CGPointMake(gameScoreForDistanceLabel.frame.size.width/2, self.frame.size.height - 100 - gameScoreForDistanceLabel.frame.size.height);
    gameScoreForDistanceLabel.zPosition = 5;
    [self addChild:gameScoreForDistanceLabel];
}

-(void) createPlayer {
    
//    player = new Player(playerStartX, platerStartY);
    player = [Player spriteNodeWithImageNamed:@"yellow_point.png"];
    NSArray* array =  [TextureHelper getTexturesWithSpriteSheetNamed:@"hamster" withinNode:nil sourceRect:CGRectMake(0, 0, 192, 200) andRowNumberOfSprites:2 andColNumberOfSprites:7
                                                           sequence:@[@7,@8]];
    
    player.texture = array[0];
    [player runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:array timePerFrame:0.2]]];
    player.size = CGSizeMake(35, 35);
    player.position = CGPointMake(playerStartX, platerStartY);
    player.zPosition = 2;
    [self addChild:player];
    
//    for(NSArray* wallLine in walls){
//        for(Wall* wall in wallLine){
//            wall.position = CGPointMake(wall.position.x-, wall.position.y);
//        }
//    }
}

-(void) move{
    
//    player.move(speedX);
//    player.position = CGPointMake(player.position.x+speedX, player.position.y);
    
//    for(SKNode* node in self.children){
//        node.position = CGPointMake(node.position.x-speedX, node.position.y);
//    }

    [self moveBg];
    
    int offsetXByWallCorrecX = 0;
    
    if(flyFlag){
        for(NSArray* wallLine in walls){
            for(Wall* wall in wallLine){
                if(wall.position.y > player.position.y-player.size.height/2 && wall.position.y < player.position.y+player.size.height/2)
                {
                    int wallCorrectLeftX = player.position.x - WALL_LEFT_AND_RIGHT_DISTANCE/2;
                    offsetXByWallCorrecX = wall.position.x - wallCorrectLeftX ;
                    break;
    //                wall.position.x;
                }
            }
        }
    }
    
    for(NSArray* wallLine in walls){
        for(Wall* wall in wallLine){
            if(flyFlag){
                wall.position = CGPointMake(wall.position.x-offsetXByWallCorrecX, wall.position.y);
            }else{
                NSLog(@"wall %f",speedX);
                wall.position = CGPointMake(wall.position.x-speedX, wall.position.y);
            }
            
        }
    }
    
    if(flyFlag){
        [self moveTools:offsetXByWallCorrecX];
    }else{
        [self moveTools:speedX];
    }
    
    [self doWallMoveAndCollisionDetectedAndCreateAndRemoveWall];
    
    distanceCount += speedY;
    static int increaseScoreDistance = 10;
    if(distanceCount<increaseScoreDistance){
        return;
    }else{
        distanceCount -= increaseScoreDistance;
    }
    gameScoreForDistance += increaseScoreDistance;
    gameScoreForDistanceLabel.text = [NSString stringWithFormat:@"%d",gameScoreForDistance];
    gameScoreForDistanceLabel.position = CGPointMake(gameScoreForDistanceLabel.frame.size.width/2, self.frame.size.height - 100 - gameScoreForDistanceLabel.frame.size.height);
    
    if(gameScoreForDistance%1500 == 0){
        NSArray* wallLine = [walls lastObject];
        Wall* wall = wallLine[0];
        [self createToolWithToolX:wall.position.x + WALL_LEFT_AND_RIGHT_DISTANCE/2];
    }
}

-(bool) isCollision:(Player*)player withOeject:(SKSpriteNode*)wall {
    CGRect rectPlayer = player.calculateAccumulatedFrame;
    CGRect rectPlayerCollisionArea = CGRectMake(rectPlayer.origin.x + rectPlayer.size.width*0.25, rectPlayer.origin.y + rectPlayer.size.height*0.25, rectPlayer.size.width *0.5, rectPlayer.size.height *0.5);
    CGRect rectWall = wall.calculateAccumulatedFrame;
    return CGRectIntersectsRect(rectPlayerCollisionArea, rectWall);
}

-(void) doWallMoveAndCollisionDetectedAndCreateAndRemoveWall {
    bool isCollision = false;
    bool isNeedCreateNewInstance = false;
    bool isNeedRemoveInstance = false;
    int firstCarPosition = 0;
    int LastCatPosition = walls.count - 1;
    Wall* lastLeftWall = nil;
    for (int wallLinePosition = 0; wallLinePosition < walls.count; wallLinePosition++) {
        bool isChecked = false;
        for (Wall* wall in walls[wallLinePosition]) {
            
            [wall move:speedY];
//            [wall move];
            if(!isChecked){
                isChecked = true;
                if (wallLinePosition == LastCatPosition) {
                    isNeedCreateNewInstance =[wall isNeedCreateNewInstance];
                    lastLeftWall = wall;
                }
                if (wallLinePosition == firstCarPosition) {
                    isNeedRemoveInstance = [wall isNeedRemoveInstance];
                }
            }
            if (!isCollision)
                isCollision = [self isCollision:player withOeject:wall];
        }
    }
    
    if (isNeedCreateNewInstance) {
        int wallLeftX = lastLeftWall.position.x;
        int wallRightX = wallLeftX + WALL_LEFT_AND_RIGHT_DISTANCE;
        int wallY = lastLeftWall.position.y;
        [self createWallLineWithLeftX:wallLeftX WithRightX:wallRightX WithY:wallY enableOffsetX:true];
    }
    if (isNeedRemoveInstance) {
        NSMutableArray* wallWithLine = walls[firstCarPosition];
        [walls removeObject:wallWithLine];
//        walls.remove(walls.get(firstCarPosition));
        for(Wall* wall in wallWithLine){
            [wall removeFromParent];
        }
        wallWithLine = nil;
    }
    gameFlag = !isCollision;
    
    if(isCollision){
        [player removeAllActions];
        GameCenterUtil * gameCenterUtil = [GameCenterUtil sharedInstance];
        [gameCenterUtil reportScore:gameScoreForDistance forCategory:@"com.irons.HappySpeedUp"];
        [self.gameDelegate showGameOver];
        [myAdView close];
    }
}

-(void)getBackground{
    backgroundNode = [SKSpriteNode spriteNodeWithTexture:nil];
    backgroundNode.anchorPoint = CGPointZero;
    
    SKSpriteNode * bg1 = [SKSpriteNode spriteNodeWithImageNamed:@"bg01_green"];
    bg1.anchorPoint = CGPointZero;
    bg1.size = self.frame.size;
    bg1.position = CGPointMake(0, 0);
    
    [backgroundNode addChild:bg1];
    
    SKSpriteNode * bg2 = [SKSpriteNode spriteNodeWithImageNamed:@"bg01_green"];
    bg2.anchorPoint = CGPointZero;
    bg2.size = self.frame.size;
    bg2.position = CGPointMake(0, bg1.size.height);
    
    [backgroundNode addChild:bg2];
    
    backgroundNode.size = CGSizeMake(bg1.size.width, bg1.size.height + bg2.size.height);
    backgroundNode.name = @"background";
    
    backgroundNode2 = [backgroundNode copy];
    backgroundNode2.position = CGPointMake(0, backgroundNode.size.height);
    [self addChild: backgroundNode2];
}

-(void)moveBg{
    [self enumerateChildNodesWithName:@"background" usingBlock:^(SKNode *node, BOOL *stop) {
        
        if (node.position.y <= -node.frame.size.height) {
            node.position = CGPointMake(node.position.x, node.position.y + node.frame.size.height*2);
        }
        
//        CGPoint backgroundVelocity = CGPointMake(0, -backgroundMovePointsPerSec);
        CGPoint backgroundVelocity = CGPointMake(0, -speedY);
        //        CGPoint amountToMove = backgroundVelocity;
        node.position = CGPointMake(node.position.x + backgroundVelocity.x, node.position.y + backgroundVelocity.y);
        
    }];
}

-(void) draw{
//    Canvas canvas = surfaceHolder.lockCanvas();
//    canvas.drawColor(Color.WHITE);
//    
//    player.draw(canvas);
//    
//    for (ArrayList<Wall> wallLine : walls) {
//        for (Wall wall : wallLine) {
//            wall.draw(canvas);
//        }
//    }
//    surfaceHolder.unlockCanvasAndPost(canvas);
}

-(void)checkEatTool{
    bool isCollision = false;
    Tool* tool;
    for (int wallLinePosition = 0; wallLinePosition < tools.count; wallLinePosition++) {
        
        tool = tools[wallLinePosition];
        isCollision = [self isCollision:player withOeject:tool];
        
        if (isCollision) {
            break;
        }
    }
    
    if(isCollision){
        [tools removeObject:tool];
        [tool removeFromParent];
        [self doToolEffect:tool];
        toolTimeCount = TOOL_TIME;
    }
    
}

-(void)checkRemoveTools{
    NSMutableArray* removeArray = [NSMutableArray array];
    for(Tool* tool in tools){
        if([tool isNeedRemoveInstance]){
            [tool removeFromParent];
            [removeArray addObject:tool];
        }
    }
    
    [tools removeObjectsInArray:removeArray];
}

int TOOL_SPEEDUP = 0;
int TOOL_SPEEDDOWN = 1;
int TOOL_FLY = 2;
int TOOL_TPYE_NUM = 3;

-(void)createToolWithToolX:(int)toolX{
    Tool* tool;
    int type = arc4random_uniform(5);
    if(type <= 1){
        tool = [Tool spriteNodeWithTexture:bitmapUtil.speedup_bitmap];
        tool.size = bitmapUtil.speedup_size;
        tool.type = TOOL_SPEEDUP;
    }else if(type <= 3){
        tool = [Tool spriteNodeWithTexture:bitmapUtil.speeddown_bitmap];
        tool.size = bitmapUtil.speeddown_size;
        tool.type = TOOL_SPEEDDOWN;
    }else{
        tool = [Tool spriteNodeWithTexture:bitmapUtil.fly_bitmap];
        tool.size = bitmapUtil.fly_size;
        tool.type = TOOL_FLY;
    }
    tool.position = CGPointMake(toolX, self.frame.size.height);
    [self addChild:tool];
    [tools addObject:tool];
}

-(void)moveTools:(float)moveDistance{
    NSLog(@"%f",moveDistance);
    for(Tool* tool in tools){
        tool.position = CGPointMake(tool.position.x-moveDistance, tool.position.y - speedY);
    }
}

-(void)doToolEffect:(Tool*)tool{
    int type = tool.type;
    if(type == TOOL_SPEEDUP){
        [self speedUp];
    }else if(type == TOOL_SPEEDDOWN){
        [self speedDown];
    }else{
        [self fly];
    }
}

-(void)speedUp{
    if(speedY > 10){
        return;
    }
    
    if (speedX > 0) {
        speedX += 3.9;
    }else{
        speedX -= 3.9;
    }
    speedY += 3;
    
    toolCounterStart = true;
}

-(void)speedDown{
    if(speedX < 4 && speedY < 42){
        return;
    }
    
    if (speedX > 0) {
        speedX -= 3.9;
    }else{
        speedX += 3.9;
    }

    speedY -= 3;
    
    toolCounterStart = true;
}

-(void)fly{
    flyFlag = true;
    speedX = 0;
    toolCounterStart = true;
//    player.xScale = 2;
//    player.yScale = 2;
    SKAction* fly = [SKAction scaleTo:2 duration:2.0f];
    [player runAction:fly];
    checkEatToolable = false;
    
    SKSpriteNode* wing = [SKSpriteNode spriteNodeWithImageNamed:@"wing"];
    wing.size = CGSizeMake(75, 35);
    wing.position = CGPointMake(0, 10);
    wing.zPosition = 3;
    [player addChild:wing];
}

-(void)resetSpeed{
    if(speedX>0){
        speedX = BASE_SPEEDX;
    }else{
        speedX = -BASE_SPEEDX;
    }
    speedY = BASE_SPEEDY;
    
    if (flyFlag) {
        SKAction* leftDown = [SKAction scaleTo:1 duration:2.0f];
        [player runAction:[SKAction sequence:@[leftDown, [SKAction runBlock:^{
            flyFlag = false;
            checkEatToolable = true;
            [player removeAllChildren];
        }]]]];
    }
    
}

-(int)gameScoreForDistance{
    return gameScoreForDistance;
}

@end
