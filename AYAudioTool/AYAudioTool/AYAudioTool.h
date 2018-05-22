//
//  AYAudioTool.h
//  AYAudioTool
//
//  Created by shanbay410 on 2018/5/21.
//  Copyright © 2018年 shanbay410. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AYAudioTool : NSObject
// 单例对象
+ (instancetype)shareAudio;
//开始录音
- (void)startAudioRecorderWithFilePath:(NSString *)filePath;
//停止录音
- (void)stopAudioRecorder;
//根据文件获得录音时长
- (NSTimeInterval)durationAudioRecorderWithFilePath:(NSString *)filePath;
//音频开始播放 或 停止
- (void)audioPlayWithFilePath:(NSString *)filePath;
//音频播放停止
- (void)audioStop;

@end
