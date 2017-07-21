//
//  NSTimer+MTAddition.m
//  Micro.tools
//
//  Created by microtown on 16/8/10.
//  Copyright © 2016年 Microtown  微镇商票宝. All rights reserved.
//

#import "NSTimer+MTAddition.h"

@implementation NSTimer (MTAddition)

- (void)pause {
    if (!self.isValid) return;
    [self setFireDate:[NSDate distantFuture]];
}

- (void)resume {
    if (!self.isValid) return;
    [self setFireDate:[NSDate date]];
}

- (void)resumeWithTimeInterval:(NSTimeInterval)time {
    if (!self.isValid) return;
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}

@end
