//
//  BitmapUtil.h
//  Try_downStage
//
//  Created by irons on 2015/5/20.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface BitmapUtil : NSObject

@property int sreenWidth, sreenHeight;
@property const float PLAYER_WIDTH_PERSENT;
@property const int TOOL_WIDTH_PERSENT;
@property const int FIREBALL_WIDTH_PERSENT;

@property SKTexture * wall_bitmap;
@property CGSize wall_size;
@property SKTexture * speedup_bitmap;
@property CGSize speedup_size;
@property SKTexture * speeddown_bitmap;
@property CGSize speeddown_size;
@property SKTexture * fly_bitmap;
@property CGSize fly_size;

@property SKTexture * player_girl_left01_bitmap;
@property SKTexture * player_girl_left02_bitmap;
@property SKTexture * player_girl_left03_bitmap;
@property SKTexture * player_girl_right01_bitmap;
@property SKTexture * player_girl_right02_bitmap;
@property SKTexture * player_girl_right03_bitmap;
@property SKTexture * player_girl_injure_left_bitmap;
@property SKTexture * player_girl_injure_right_bitmap;
@property SKTexture * player_girl_down_left_bitmap;
@property SKTexture * player_girl_down_right_bitmap;

@property SKTexture * player_boy_left01_bitmap;
@property SKTexture * player_boy_left02_bitmap;
@property SKTexture * player_boy_left03_bitmap;
@property SKTexture * player_boy_right01_bitmap;
@property SKTexture * player_boy_right02_bitmap;
@property SKTexture * player_boy_right03_bitmap;
@property SKTexture * player_boy_injure_left_bitmap;
@property SKTexture * player_boy_injure_right_bitmap;
@property SKTexture * player_boy_down_left_bitmap;
@property SKTexture * player_boy_down_right_bitmap;

@property SKTexture * footboard_normal_bitmap;
@property SKTexture * footboard_moving_left1_bitmap;
@property SKTexture * footboard_moving_left2_bitmap;
@property SKTexture * footboard_moving_left3_bitmap;
@property SKTexture * footboard_moving_right1_bitmap;
@property SKTexture * footboard_moving_right2_bitmap;
@property SKTexture * footboard_moving_right3_bitmap;
@property SKTexture * footboard_unstable1_bitmap;
@property SKTexture * footboard_unstable2_bitmap;
@property SKTexture * footboard_unstable3_bitmap;
@property SKTexture * footboard_spring_bitmap;
@property SKTexture * footboard_spiked_bitmap;
@property SKTexture * footboard_wood_bitmap;
@property SKTexture * footboard_wood2_bitmap;
@property SKTexture * footboard_wood3_bitmap;

@property SKTexture * tool_bomb_bitmap;
@property SKTexture * toll_cure_bitmap;
@property SKTexture * tool_bomb_explosion_bitmap;
@property SKTexture * toll_eat_man_tree_bitmap;
@property SKTexture * toll_eat_man_tree2_bitmap;
@property SKTexture * toll_eat_man_tree3_bitmap;
@property SKTexture * fire_ball;

@property CGSize player_girl_left01_size;
@property CGSize player_girl_left02_size;
@property CGSize player_girl_left03_size;
@property CGSize player_girl_right01_size;
@property CGSize player_girl_right02_size;
@property CGSize player_girl_right03_size;
@property CGSize player_girl_injure_left_size;
@property CGSize player_girl_injure_right_size;
@property CGSize player_girl_down_left_size;
@property CGSize player_girl_down_right_size;
@property CGSize player_boy_left01_size;
@property CGSize player_boy_left03_size;
@property CGSize player_boy_left02_size;
@property CGSize player_boy_right01_size;
@property CGSize player_boy_right02_size;
@property CGSize player_boy_right03_size;
@property CGSize player_boy_injure_left_size;
@property CGSize player_boy_down_left_size;
@property CGSize player_boy_down_right_size;
@property CGSize player_boy_injure_right_size;
@property CGSize fire_ball_size;

@property NSArray* numberImageArray;

-(UIImage*)getNumberImage:(int)number;

+(id)sharedInstance;

@end
