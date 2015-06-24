//
//  RetryButton.m
//  temp_game
//
//  Created by 海野 竜也 on 2014/09/11.
//  Copyright (c) 2014年 海野 竜也. All rights reserved.
//

#import "RetryButton.h"

@implementation RetryButton
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(retry)]) {
        [self.delegate retry];
    }
}
@end
