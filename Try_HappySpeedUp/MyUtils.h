//
//  MyUtils.h
//  Try_Cat_Shoot
//
//  Created by irons on 2015/4/21.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyUtils : NSObject

+(void)preparePlayBackgroundMusic:(NSString*)filename;
+(void)playBackgroundMusic:(NSString*)filename;
+(void)backgroundMusicPlayerStop;
+(BOOL)isBackgroundMusicPlayerPlaying;
+(void)backgroundMusicPlayerPause;
+(void)backgroundMusicPlayerPlay;

@end
