//
//  TestDownloadController.m
//  WBFramework
//
//  Created by wayneking on 2019/4/22.
//  Copyright © 2019 wayneking. All rights reserved.
//

#import "TestDownloadController.h"

@interface TestDownloadController ()<NSURLSessionDownloadDelegate>

@property(nonatomic,strong) NSURLSessionDownloadTask *downloadTask;
@property(nonatomic,strong) NSData *resumeData;
@property(nonatomic,strong) NSURLSession *session;

@end

@implementation TestDownloadController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI{
    @weakify(self);
    UIButton *startDownloadBtn = [WBUtil createButton:@"开始下载" TextSize:15 TextColor:[UIColor whiteColor] BackgroundColor:[UIColor magentaColor]];
    [self.view addSubview:startDownloadBtn];
    startDownloadBtn.frame = CGRectMake(20, 100, 100, 40);
    [[startDownloadBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        WBLog(@"开始下载");
        [self sessionDownloadFile];
    }];
    
    UIButton *cancelBtn = [WBUtil createButton:@"取消下载" TextSize:15 TextColor:[UIColor whiteColor] BackgroundColor:[UIColor magentaColor]];
    cancelBtn.frame = CGRectMake(140, 100, 100, 40);
    [self.view addSubview:cancelBtn];
    [[cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        WBLog(@"取消下载");
        //calcel :不可恢复   cancelByProducingResumeData: 可恢复
        //恢复下载数据 != 文件数据
        [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            self.resumeData = resumeData;
        }];
    }];
    
    UIButton *suspendBtn = [WBUtil createButton:@"暂停下载" TextSize:15 TextColor:[UIColor whiteColor] BackgroundColor:[UIColor magentaColor]];
    suspendBtn.frame = CGRectMake(260, 100, 100, 40);
    [self.view addSubview:suspendBtn];
    [[suspendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        WBLog(@"暂停下载");
        [self.downloadTask suspend];
    }];
    
    UIButton *resumeBtn = [WBUtil createButton:@"继续下载" TextSize:15 TextColor:[UIColor whiteColor] BackgroundColor:[UIColor magentaColor]];
    resumeBtn.frame = CGRectMake(20, 160, 100, 40);
    [self.view addSubview:resumeBtn];
    [[resumeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        WBLog(@"继续下载");
        if (self.downloadTask.state == NSURLSessionTaskStateCompleted) {
            if (self.resumeData) {
                //resumeData有值表示取消下载
                self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
            }
        }
        [self.downloadTask resume];
    }];
    
    
    
}

- (void)sessionDownloadFile{
    NSString *url = @"http://vod.jiankao.wang/sv/2e93f080-16776eafd53/2e93f080-16776eafd53.mp4";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithRequest:request];
    [downloadTask resume];
    self.downloadTask = downloadTask;
}

#pragma mark - NSURLSessionDownTaskDelegate
/**
 写入数据
 
 @param session session
 @param downloadTask task
 @param bytesWritten 本次写入的数据大小
 @param totalBytesWritten 下载数据总大小
 @param totalBytesExpectedToWrite 文件总大小
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    //文件下载进度
    WBLog(@"--%.2f%%", 100.0*totalBytesWritten/totalBytesExpectedToWrite);
}


/**
 恢复下载
 
 @param session session
 @param downloadTask task
 @param fileOffset 恢复从哪个位置下载
 @param expectedTotalBytes 文件总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}



/**
 下载完成
 
 @param session session
 @param downloadTask task
 @param location 文件临时存储路径
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
    WBLog(@"%@",fullPath);
}


/**
 请求结束
 
 @param session session
 @param task task
 @param error error
 */
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    WBLog(@"下载完成Identifer:%ld",task.taskIdentifier);
}

@end
