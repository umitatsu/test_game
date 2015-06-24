//
//  main_fun.h
//  temp_game
//
//  Created by 海野 竜也 on 2014/09/10.
//  Copyright (c) 2014年 海野 竜也. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class main_fun;
@protocol main_funDelegate
-(void)mosTouched:(main_fun *)mos;
@end

@interface main_fun : SKSpriteNode
@property(weak) id delegate;
@property(assign)float angSpeed;
@property(assign)int dengue;
-(void)move:(CFTimeInterval)timeSinceLastUpdate;
@end
