//
//  AYAudioFileManager.m
//  AYAudioTool
//
//  Created by shanbay410 on 2018/5/21.
//  Copyright © 2018年 shanbay410. All rights reserved.
//

#import "AYAudioFileManager.h"

@implementation AYAudioFileManager
/// 录音文件保存路径
+ (NSString *)AYAudioGetFilePathWithDate{
    NSDate * currentDate = [NSDate date];
    NSDateFormatter * formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString * filePath = [formatter stringFromDate:currentDate];
    filePath = [NSString stringWithFormat:@"%@.aac", filePath];
    NSString *tmpPath = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    filePath = [tmpPath stringByAppendingFormat:@"/%@",filePath];
    return filePath;
}
/// 获取包含后缀文件名
+ (NSString *)AYAudioGetFileNameWithFilePath:(NSString *)filePath type:(BOOL)hasFileType{
    NSString *fileName = [filePath stringByDeletingLastPathComponent];
    if (hasFileType)
    {
        fileName = [filePath lastPathComponent];
    }
    return fileName;
}
/// 获得音频文件大小
+ (long long)AYAudioGetFileSizeWithFilePath:(NSString *)filePath{
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (isExist){
        NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        long long fileSize = fileDict.fileSize;
        return fileSize;
    }
    return 0.0;
}
/// 删除文件
+ (void)AYAudioDeleteFileWithFilePath:(NSString *)filePath{
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (isExist){
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}

@end
