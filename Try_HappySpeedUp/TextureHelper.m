//
//  TextureHelper.m
//  Try_Cat_Shoot
//
//  Created by irons on 2015/3/23.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "TextureHelper.h"

@implementation TextureHelper

+(id) getTexturesWithSpriteSheetNamed: (NSString *) spriteSheet withinNode: (SKSpriteNode *) scene sourceRect: (CGRect) source andRowNumberOfSprites: (int) rowNumberOfSprites andColNumberOfSprites: (int) colNumberOfSprites{
    
    // @param numberOfSprites - the number of sprite images to the left
    // @param scene - I add my sprite to a map node. Change it to a SKScene
    // if [self addChild:] is used.
    
    NSMutableArray *mAnimatingFrames = [NSMutableArray array];
    
        SKTexture  *ssTexture = [SKTexture textureWithImageNamed:spriteSheet];
    
    // Makes the sprite (ssTexture) stay pixelated:
    ssTexture.filteringMode = SKTextureFilteringNearest;
    
    float sx = source.origin.x;
    float sy = source.origin.y;
    float sWidth = source.size.width;
    float sHeight = source.size.height;
    
    // IMPORTANT: textureWithRect: uses 1 as 100% of the sprite.
    // This is why division from the original sprite is necessary.
    // Also why sx is incremented by a fraction.
    
    for (int i = 0; i < rowNumberOfSprites*colNumberOfSprites; i++) {
        CGRect cutter = CGRectMake(sx, sy, sWidth/ssTexture.size.width, sHeight/ssTexture.size.height);
        SKTexture* temp = [SKTexture textureWithRect:cutter inTexture:ssTexture];
        [mAnimatingFrames addObject:temp];
        
//        if(i < colNumberOfSprites){
            sx+=sWidth/ssTexture.size.width;
//        }else{
        if ((i+1)%colNumberOfSprites == 0) {
            sx=source.origin.x;
            sy+=sHeight/ssTexture.size.height;
        }
        
    }
    
//    self = [Monster spriteNodeWithTexture:mAnimatingFrames[0]];
    
//    animatingFrames = mAnimatingFrames;
    
//    [scene addChild:self];
    
    return mAnimatingFrames;
}

+(id) getTexturesWithSpriteSheetNamed: (NSString *) spriteSheet withinNode: (SKSpriteNode *) scene sourceRect: (CGRect) source andRowNumberOfSprites: (int) rowNumberOfSprites andColNumberOfSprites: (int) colNumberOfSprites sequence: (NSArray*) positions{
    
    // @param numberOfSprites - the number of sprite images to the left
    // @param scene - I add my sprite to a map node. Change it to a SKScene
    // if [self addChild:] is used.
    
    NSMutableArray *mAnimatingFrames = [NSMutableArray array];
    
//    SKTexture  *ssTexture = [SKTexture textureWithImageNamed:spriteSheet];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:spriteSheet
                                                     ofType:@"png"];
    UIImage *myImage = [UIImage imageWithContentsOfFile:path];
    
    SKTexture  *ssTexture = [SKTexture textureWithImage:myImage];
    
    // Makes the sprite (ssTexture) stay pixelated:
    ssTexture.filteringMode = SKTextureFilteringNearest;
    
    float sx = source.origin.x;
    float sy = source.origin.y;
    float sWidth = source.size.width;
    float sHeight = source.size.height;
    
    // IMPORTANT: textureWithRect: uses 1 as 100% of the sprite.
    // This is why division from the original sprite is necessary.
    // Also why sx is incremented by a fraction.
    
    for (int i = 0; i < rowNumberOfSprites*colNumberOfSprites; i++) {
        CGRect cutter = CGRectMake(sx, sy, sWidth/ssTexture.size.width, sHeight/ssTexture.size.height);
        SKTexture *temp = [SKTexture textureWithRect:cutter inTexture:ssTexture];
        [mAnimatingFrames addObject:temp];
        
        //        if(i < colNumberOfSprites){
        sx+=sWidth/ssTexture.size.width;
        //        }else{
        if ((i+1)%colNumberOfSprites == 0) {
            sx=source.origin.x;
            sy+=sHeight/ssTexture.size.height;
        }
        
    }
    
    //    self = [Monster spriteNodeWithTexture:mAnimatingFrames[0]];
    
    //    animatingFrames = mAnimatingFrames;
    
    //    [scene addChild:self];
    
    NSMutableArray * array = [NSMutableArray array];
    
    for (int i = 0; i < positions.count; i++) {
        int sequencePosition = [positions[i] intValue];
        [array addObject: mAnimatingFrames[sequencePosition]];
    }
    
    return array;
}

@end
