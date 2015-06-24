//
//  main_fun.m
//  temp_game
//
//  Created by 海野 竜也 on 2014/09/10.
//  Copyright (c) 2014年 海野 竜也. All rights reserved.
//

#import "main_fun.h"

@implementation main_fun

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if([self.delegate respondsToSelector:@selector(mosTouched:)]){
        [self.delegate mosTouched:self];
    }
}

- (void)move:(CFTimeInterval)timeSinceLastUpdate {
    const float speed = 100.0f;
    float angularAmount = self.angSpeed * timeSinceLastUpdate;
    self.zRotation = self.zRotation + angularAmount;
    // 向いている方向に移動させる
    float moveAmount = speed * timeSinceLastUpdate;
    float theta = self.zRotation + 1.57f;
    float moveAmountX = cos(theta) * moveAmount;
    float moveAmountY = sin(theta) * moveAmount;
    CGPoint positionBefore = self.position;
    self.position = CGPointMake(positionBefore.x + moveAmountX,
                                positionBefore.y + moveAmountY);
}

@end
