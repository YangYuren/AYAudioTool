//
//  NSTimer+AvoidCycle.h
//  AYAudioTool
//
//  Created by shanbay410 on 2018/5/21.
//  Copyright © 2018年 shanbay410. All rights reserved.
//

#import <Foundation/Foundation.h>
//解决NSTimer与runLoop循环引用问题
typedef void (^AYTimerHandler)(void);

@interface NSTimer (AvoidCycle)

+ (NSTimer *)ay_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(void))inBlock repeats:(BOOL)inRepeats;

@end
