//
//  RetryButton.h
//  temp_game
//
//  Created by 海野 竜也 on 2014/09/11.
//  Copyright (c) 2014年 海野 竜也. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol RetryButtonDelegate
- (void)retry;
@end


@interface RetryButton : SKLabelNode
@property (weak) id delegate;
@end
