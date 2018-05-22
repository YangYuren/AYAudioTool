//
//  ViewController.m
//  AYAudioTool
//
//  Created by shanbay410 on 2018/5/21.
//  Copyright © 2018年 shanbay410. All rights reserved.
//

#import "ViewController.h"
#import "AYAudioFileManager.h"
#import "AYAudioTool.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSString * filePath;

@property (nonatomic, strong) UITableView * testTableView;

@property (nonatomic, strong) NSMutableArray * testArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"录音";
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithTitle:@"清理缓存文件" style:UIBarButtonItemStyleDone target:self action:@selector(clearItemClick:)];
    self.navigationItem.rightBarButtonItems = @[clearItem];
    [self setUI];
    self.testTableView.delegate = self;
    self.testTableView.dataSource = self;
}
- (void)setUI{
    [self.view addSubview:self.testTableView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(10.0, (CGRectGetHeight(self.view.bounds) - 10.0 - 40.0), (CGRectGetWidth(self.view.bounds) - 10.0 * 2), 40.0);
    button.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    [button setTitle:@"按下开始录音" forState:UIControlStateNormal];
    [button setTitle:@"正在录音...." forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    // 录音响应
    [button addTarget:self action:@selector(recordStartButtonDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(recordStopButtonUp:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(recordStopButtonExit:) forControlEvents:UIControlEventTouchDragExit];
}
#pragma mark - click Method
- (void)recordStartButtonDown:(UIButton *)button{
    [self startRecorder];
}

- (void)recordStopButtonUp:(UIButton *)button{
    [self saveRecorder];
}

- (void)recordStopButtonExit:(UIButton *)button{
    [self saveRecorder];
}

- (void)clearItemClick:(UIBarButtonItem *)item{
    if (self.testArray){//这里的删除仅仅是testArray数组元素对应的文件，不是清楚缓存文件夹中的文件
        for (NSDictionary *dict in self.testArray){
            NSString *filePath = dict[@"FilePath"];
            [AYAudioFileManager AYAudioDeleteFileWithFilePath:filePath];
        }
        [self.testArray removeAllObjects];
        [self.testTableView reloadData];
    }
}
#pragma mark - 音频处理方法

// 开始录音
- (void)startRecorder{
    self.filePath = [AYAudioFileManager AYAudioGetFilePathWithDate];
    [[AYAudioTool shareAudio] startAudioRecorderWithFilePath:self.filePath];
}

// 停止录音，并保存
- (void)saveRecorder{
    [[AYAudioTool shareAudio] stopAudioRecorder];
    // 保存音频信息
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.filePath forKey:@"FilePath"];
    NSString *fileName = [AYAudioFileManager AYAudioGetFileNameWithFilePath:self.filePath type:YES];
    [dict setValue:fileName forKey:@"FileName"];
    long long fileSize = [AYAudioFileManager AYAudioGetFileSizeWithFilePath:self.filePath];
    [dict setValue:@(fileSize) forKey:@"FileSize"];
    NSTimeInterval fileTime = [[AYAudioTool shareAudio] durationAudioRecorderWithFilePath:self.filePath];
    [dict setValue:@(fileTime) forKey:@"FileTime"];
    [self.testArray addObject:dict];
    // 刷新列表
    [self.testTableView reloadData];
}

// 录音开始播放，或停止
- (void)playRecorder{
    [[AYAudioTool shareAudio] audioPlayWithFilePath:self.filePath];
}

// 录音停止播放
- (void)stopRecorder{
    [[AYAudioTool shareAudio] audioStop];
}

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.testArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.separatorInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
        cell.layoutMargins = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.textColor = [UIColor orangeColor];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    }
    NSDictionary *dict = self.testArray[indexPath.row];
    NSNumber *fileTime = dict[@"FileTime"];
    cell.textLabel.text = [NSString stringWithFormat:@"duration=%.2fs", fileTime.doubleValue];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = self.testArray[indexPath.row];
    NSString *filePath = dict[@"FilePath"];
    [[AYAudioTool shareAudio] audioPlayWithFilePath:filePath];
}

#pragma mark - lazy
- (UITableView *)testTableView{
    if(!_testTableView){
        _testTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 10 - 40 - 10) style:UITableViewStylePlain];
        _testTableView.tableFooterView = [[UIView alloc] init];
        _testTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _testTableView.backgroundColor = [UIColor clearColor];
        _testTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _testTableView.separatorInset = UIEdgeInsetsZero;
        _testTableView.layoutMargins = UIEdgeInsetsZero;
    }
    return _testTableView;
}

- (NSMutableArray *)testArray{
    if (!_testArray){
        _testArray = [[NSMutableArray alloc] init];
    }
    return _testArray;
}


@end
