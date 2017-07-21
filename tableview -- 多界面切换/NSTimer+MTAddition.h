//
//  NSTimer+MTAddition.h
//  Micro.tools
//
//  Created by microtown on 16/8/10.
//  Copyright © 2016年 Microtown  微镇商票宝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (MTAddition)

- (void)pause;
- (void)resume;
- (void)resumeWithTimeInterval:(NSTimeInterval)time;

@end
