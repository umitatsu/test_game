//
//  MySceneTop.m
//  temp_game
//
//  Created by 海野 竜也 on 2014/09/11.
//  Copyright (c) 2014年 海野 竜也. All rights reserved.
//

#import "MySceneTop.h"
#import "main_fun.h"


@interface MySceneTop(){
    NSArray *targets;
    dispatch_once_t lastUpdatedAtInitToken;
    CFTimeInterval lastUpdatedAt;
}

@end

@implementation MySceneTop

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor=[SKColor whiteColor];
        NSMutableArray *targets_ = @[].mutableCopy;
        for (int i = 0; i < 3; i++) {
            main_fun *sprite = [main_fun spriteNodeWithImageNamed:@"Mosquito"];
            /*sprite.position = CGPointMake((float)arc4random() / (float)ULONG_MAX * size.width,
                                          (float)arc4random() / (float)ULONG_MAX * size.height);*/
            sprite.position = CGPointMake((float)arc4random() / (float)UINT_MAX * size.width,
                                          (float)arc4random() / (float)UINT_MAX * size.height);
            sprite.angSpeed=(float)arc4random() / (float)UINT_MAX * 6.28f - 3.14f;
            NSLog(@"%f",sprite.angSpeed);
            sprite.xScale = 1.0f / 10.0f;
            sprite.yScale = 1.0f / 10.0f;
            sprite.zRotation = -1.57f;
            sprite.userInteractionEnabled=YES;
            [self addChild:sprite];
            [targets_ addObject:sprite];
        }
        targets = targets_;
    }
    return self;
}

-(void)update:(CFTimeInterval)currentTime {
    dispatch_once(&lastUpdatedAtInitToken, ^{
        lastUpdatedAt = currentTime;
    });
    CFTimeInterval timeSinceLastUpdate = currentTime - lastUpdatedAt;
    lastUpdatedAt = currentTime;
    const float outerMargin = 30.0f;
    const float leftEnd = -outerMargin;
    const float rightEnd = self.size.width + outerMargin;
    const float topEnd = self.size.height + outerMargin;
    const float bottomEnd = -outerMargin;
    for(main_fun *target in targets){
        if ((float)arc4random() / (float)UINT_MAX < 0.1f) {
            target.angSpeed = (float)arc4random() / (float)UINT_MAX * 6.28f - 3.14f;
        }
        [target move:timeSinceLastUpdate];
        if (target.position.x < leftEnd) { // 左端
            target.position = CGPointMake(rightEnd, target.position.y);
        }
        if (target.position.x > rightEnd) { // 右端
            target.position = CGPointMake(leftEnd, target.position.y);
        }
        if (target.position.y < bottomEnd) { // 下端
            target.position = CGPointMake(target.position.x, topEnd);
        }
        if (target.position.y > topEnd) { // 上端
            target.position = CGPointMake(target.position.x, bottomEnd);
        }
    }
}

@end


