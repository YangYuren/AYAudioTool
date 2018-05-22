//
//  AYAudioTimer.h
//  AYAudioTool
//
//  Created by shanbay410 on 2018/5/21.
//  Copyright © 2018年 shanbay410. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AYAudioTimer : NSObject
//初始化定时器
+ (NSTimer *)ayAudioTimerInitialize:(NSTimeInterval)timeElapsed  andIsRepeat:(BOOL)isRepeat andBlock:(void (^)(void))block;
//启动定时器
+ (void)ayAudioStartTimer:(NSTimer *)timer;
//停止定时器
+ (void)ayAudioStopTimer:(NSTimer *)timer;
//杀掉定时器
+ (NSTimer *)ayAudioKillTimer:(NSTimer *)timer;

@end
