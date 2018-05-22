//
//  AYAudioTimer.m
//  AYAudioTool
//
//  Created by shanbay410 on 2018/5/21.
//  Copyright © 2018年 shanbay410. All rights reserved.
//

#import "AYAudioTimer.h"
#import "NSTimer+AvoidCycle.h"

@implementation AYAudioTimer
//初始化定时器
+ (NSTimer *)ayAudioTimerInitialize:(NSTimeInterval)timeElapsed  andIsRepeat:(BOOL)isRepeat andBlock:(void (^)(void))block {
    NSTimer * timer = [NSTimer ay_scheduledTimerWithTimeInterval:timeElapsed block:block repeats:isRepeat];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer setFireDate:[NSDate distantFuture]];
    return timer;
}

+ (void)ayAudioStartTimer:(NSTimer *)timer{
    [timer setFireDate:[NSDate distantPast]];
}
+ (void)ayAudioStopTimer:(NSTimer *)timer{
    [timer setFireDate:[NSDate distantFuture]];
}
+ (NSTimer *)ayAudioKillTimer:(NSTimer *)timer{
    if([timer isValid]){
        [timer invalidate];
    }
    timer = nil;
    return timer;
}
@end
