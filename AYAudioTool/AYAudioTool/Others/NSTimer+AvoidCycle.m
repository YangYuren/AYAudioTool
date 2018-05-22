//
//  NSTimer+AvoidCycle.m
//  AYAudioTool
//
//  Created by shanbay410 on 2018/5/21.
//  Copyright © 2018年 shanbay410. All rights reserved.
//

#import "NSTimer+AvoidCycle.h"

@implementation NSTimer (AvoidCycle)

+ (NSTimer *)ay_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(void))inBlock repeats:(BOOL)inRepeats{
    void (^block)(void) = [inBlock copy];
    NSTimer * timer = [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(executeTimerBlock:) userInfo:block repeats:inRepeats];
    return timer;
}


+ (void)executeTimerBlock:(NSTimer *)inTimer;{
    if([inTimer userInfo]){
        void (^block)(void) = (void (^)(void))[inTimer userInfo];
        block();
    }
}






@end
