//
//  AYAudioFileManager.h
//  AYAudioTool
//
//  Created by shanbay410 on 2018/5/21.
//  Copyright © 2018年 shanbay410. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AYAudioFileManager : NSObject
/// 录音文件保存路径
+ (NSString *)AYAudioGetFilePathWithDate;

/// 获取包含后缀文件名
+ (NSString *)AYAudioGetFileNameWithFilePath:(NSString *)filePath type:(BOOL)hasFileType;

/// 获取文件大小
+ (long long)AYAudioGetFileSizeWithFilePath:(NSString *)filePath;

/// 删除文件
+ (void)AYAudioDeleteFileWithFilePath:(NSString *)filePath;
@end
