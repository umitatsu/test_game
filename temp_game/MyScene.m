//
//  MyScene.m
//  temp_game
//
//  Created by 海野 竜也 on 2014/09/09.
//  Copyright (c) 2014年 海野 竜也. All rights reserved.
//

#import "MyScene.h"
#import "main_fun.h"
#import "RetryButton.h"
#import "rootViewController.h"


static const CFTimeInterval GameInterval = 30.0;

@interface MyScene(){
    NSArray *targets;
    int point;
    dispatch_once_t lastUpdatedAtInitToken;
    CFTimeInterval lastUpdatedAt;
    SKLabelNode *pointLabel;
    SKLabelNode *timeLabel;
    CFTimeInterval gameTime;
    RetryButton *retryButton;
    BOOL isTimeRemaining;
}

@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        point=0;
        self.backgroundColor=[UIColor whiteColor];
        NSMutableArray *targets_ = @[].mutableCopy;
        //スプライト作成・設定
        for (int i = 0; i < 7; i++) {
            main_fun *sprite;
            if(i==0||i==6){
                sprite=[main_fun spriteNodeWithImageNamed:@"Mosquito"];
                sprite.dengue=1;
            }else{
                sprite = [main_fun spriteNodeWithImageNamed:@"Mosquito_clip_art_hight"];
                sprite.dengue=0;
            }
            sprite.angSpeed=(float)arc4random()/(float)UINT_MAX*6.28f-3.14f;
            sprite.position = CGPointMake((float)arc4random() / (float)UINT_MAX * size.width,
                                          (float)arc4random() / (float)UINT_MAX * size.height);
            sprite.xScale = 1.0f / 10.0f;
            sprite.yScale = 1.0f / 10.0f;
            sprite.zRotation = -1.57f;
            sprite.userInteractionEnabled=YES;
            sprite.delegate=self;

            [self addChild:sprite];
            [targets_ addObject:sprite];
        }
        //ポイントのラベル
        targets = targets_;
        pointLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        pointLabel.fontColor=[UIColor blackColor];
        pointLabel.text = @"scoer 0";
        pointLabel.fontSize = 30;
        pointLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                          CGRectGetMidY(self.frame));
        [self addChild:pointLabel];
        
        //
        timeLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        timeLabel.fontColor=[UIColor blackColor];
        timeLabel.text = @"time";
        timeLabel.fontSize = 30;
        timeLabel.position = CGPointMake(CGRectGetMidX(self.frame), 30.0f);
        [self addChild:timeLabel];
        
        retryButton = [RetryButton labelNodeWithFontNamed:@"Chalkduster"];
        retryButton.fontColor=[UIColor blackColor];
        retryButton.text = @"Retry";
        retryButton.fontSize = 30;
        retryButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 50);
        retryButton.userInteractionEnabled = YES;
        retryButton.delegate = self;
        
        }
    return self;
}

-(void)mosTouched:(main_fun *)mos{
    CFTimeInterval timeRemaining = GameInterval - gameTime;
    if (timeRemaining < 0) return;
    if(mos.dengue){
        point += 200;
    }else{
        point += 100;
    }
    if(flg){
        [self runAction:[SKAction playSoundFileNamed:@"sen_ge_harisen01.mp3" waitForCompletion:NO]];
    }
    pointLabel.text = [NSString stringWithFormat:@"score %d", point];
    //CGPoint positionBefore=mos.position;
    CGPoint moveToPoint=CGPointMake(mos.position.x, -30);
    SKAction *move=[SKAction moveTo:moveToPoint duration:0.5];
    [mos runAction:move];
    //mos.position=CGPointMake(-(float)(arc4random()%30), -(float)(arc4random()%30));
    /*float rand1 = (float)arc4random() / (float)ULONG_MAX;
    float rand2 = (float)arc4random() / (float)ULONG_MAX;
    mos.position = CGPointMake(rand1 * self.size.width,
                               rand2 * self.size.height);*/
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    /*for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}*/

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    dispatch_once(&lastUpdatedAtInitToken, ^{
        lastUpdatedAt = currentTime;
    });
    CFTimeInterval timeSinceLastUpdate = currentTime - lastUpdatedAt;
    lastUpdatedAt = currentTime;
    
    gameTime += timeSinceLastUpdate;
    CFTimeInterval timeRemaining = GameInterval - gameTime;
    if (timeRemaining >= 0) {
        timeLabel.text = [NSString stringWithFormat:@"time %d", (int)ceil(timeRemaining)];
        isTimeRemaining = YES;
    } else {
        if (isTimeRemaining) {
            [self addChild:retryButton];
            isTimeRemaining = NO;
        }
        timeLabel.text = @"Time over!";
    }
    const float outerMargin = 50.0f;
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

- (void)retry {
    isTimeRemaining = YES;
    gameTime = 0.0;
    point = 0;
    [retryButton removeFromParent];
}

@end
