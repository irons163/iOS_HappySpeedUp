//
//  BitmapUtil.m
//  Try_downStage
//
//  Created by irons on 2015/5/20.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "BitmapUtil.h"

@implementation BitmapUtil

static BitmapUtil* instance;

-(id)init{
    if(self = [super init]){
        self.PLAYER_WIDTH_PERSENT = 2.5;
        self.TOOL_WIDTH_PERSENT = 4;
        self.FIREBALL_WIDTH_PERSENT = 3;
        
        self.sreenWidth = 300.0;
        self.sreenHeight = 600.0;
        
        int footbarWidth = self.sreenWidth / 4;
        int playerWidth = footbarWidth / self.PLAYER_WIDTH_PERSENT;
        int toolWidth = footbarWidth / self.TOOL_WIDTH_PERSENT;
        int fireballWidth = footbarWidth / self.FIREBALL_WIDTH_PERSENT;
        
        self.wall_bitmap = [SKTexture textureWithImageNamed:@"f1-hd"];
        self.wall_size = CGSizeMake(playerWidth, (int)((float)self.wall_bitmap.size.height/ self.wall_bitmap.size.width * playerWidth));
        
        self.speedup_bitmap = [SKTexture textureWithImageNamed:@"boots"];
        self.speedup_size = CGSizeMake(playerWidth, (int)((float)self.speedup_bitmap.size.height/ self.speedup_bitmap.size.width * playerWidth));
        self.speeddown_bitmap = [SKTexture textureWithImageNamed:@"bubble_1"];
        self.speeddown_size = CGSizeMake(playerWidth, (int)((float)self.speeddown_bitmap.size.height/ self.speeddown_bitmap.size.width * playerWidth));
        self.fly_bitmap = [SKTexture textureWithImageNamed:@"wing"];
        self.fly_size = CGSizeMake(playerWidth, (int)((float)self.fly_bitmap.size.height/ self.fly_bitmap.size.width * playerWidth));
    
        
        self.numberImageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"s0"], [UIImage imageNamed:@"s1"], [UIImage imageNamed:@"s2"], [UIImage imageNamed:@"s3"], [UIImage imageNamed:@"s4"], [UIImage imageNamed:@"s5"], [UIImage imageNamed:@"s6"], [UIImage imageNamed:@"s7"], [UIImage imageNamed:@"s8"], [UIImage imageNamed:@"s9"], nil];
        
    }
    return self;
}

-(UIImage*)getNumberImage:(int)number{
    UIImage* numberImage;
    switch (number) {
        case 0:
            numberImage = self.numberImageArray[0];
            break;
        case 1:
            numberImage = self.numberImageArray[1];
            break;
        case 2:
            numberImage = self.numberImageArray[2];
            break;
        case 3:
            numberImage = self.numberImageArray[3];
            break;
        case 4:
            numberImage = self.numberImageArray[4];
            break;
        case 5:
            numberImage = self.numberImageArray[5];
            break;
        case 6:
            numberImage = self.numberImageArray[6];
            break;
        case 7:
            numberImage = self.numberImageArray[7];
            break;
        case 8:
            numberImage = self.numberImageArray[8];
            break;
        case 9:
            numberImage = self.numberImageArray[9];
            break;
    }
    return numberImage;
}

+ (id)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}



@end
