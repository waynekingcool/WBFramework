//
//  TestOfflineDownloadController.m
//  WBFramework
//
//  Created by wayneking on 2019/4/22.
//  Copyright © 2019 wayneking. All rights reserved.
/**
    断点下载是从内存中取出当前下载数据的size, 然后设置请求头的Range
    离线断点下载是从沙盒中取出已下载的数据的size, 然后设置请求头的Range
 */

#import "TestOfflineDownloadController.h"

@interface TestOfflineDownloadController ()<NSURLSessionDataDelegate>

@property(nonatomic,strong) NSString *fullPath;
@property(nonatomic, assign) NSInteger totalSize;
@property(nonatomic, assign) NSInteger currentSize;
@property(nonatomic,strong) NSFileHandle *fileHandle;
@property(nonatomic,strong) NSURLSessionDataTask *dataTask;

@end

@implementation TestOfflineDownloadController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)dealloc{
    
}

- (void)createUI{
    @weakify(self);
    UIButton *startDownloadBtn = [WBUtil createButton:@"开始下载" TextSize:15 TextColor:[UIColor whiteColor] BackgroundColor:[UIColor magentaColor]];
    [self.view addSubview:startDownloadBtn];
    startDownloadBtn.frame = CGRectMake(20, 100, 100, 40);
    [[startDownloadBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        WBLog(@"开始下载");
        [self.dataTask resume];
    }];
    
    UIButton *cancelBtn = [WBUtil createButton:@"取消下载" TextSize:15 TextColor:[UIColor whiteColor] BackgroundColor:[UIColor magentaColor]];
    cancelBtn.frame = CGRectMake(140, 100, 100, 40);
    [self.view addSubview:cancelBtn];
    [[cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        WBLog(@"取消下载");
        [self.dataTask cancel];
        self.dataTask = nil;
    }];
    
    UIButton *suspendBtn = [WBUtil createButton:@"暂停下载" TextSize:15 TextColor:[UIColor whiteColor] BackgroundColor:[UIColor magentaColor]];
    suspendBtn.frame = CGRectMake(260, 100, 100, 40);
    [self.view addSubview:suspendBtn];
    [[suspendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        WBLog(@"暂停下载");
        [self.dataTask suspend];
    }];
    
    UIButton *resumeBtn = [WBUtil createButton:@"继续下载" TextSize:15 TextColor:[UIColor whiteColor] BackgroundColor:[UIColor magentaColor]];
    resumeBtn.frame = CGRectMake(20, 160, 100, 40);
    [self.view addSubview:resumeBtn];
    [[resumeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        WBLog(@"继续下载");
        [self.dataTask resume];
    }];
    
}

#pragma mark - DataDelegate
//1.接收服务器的响应, 默认取消该请求
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    // NSURLSessionResponseCancel = 0 取消
    // NSURLSessionResponseAllow = 1 接收
    // NSURLSessionResponseBecomeDownload = 2, 下载任务
    if (self.currentSize == 0) {
        [[NSFileManager defaultManager] createFileAtPath:self.fullPath contents:nil attributes:nil];
    }
    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:self.fullPath];
    self.totalSize = response.expectedContentLength + self.currentSize;
    completionHandler(NSURLSessionResponseAllow);
}

//2.收到返回数据, 多次调用
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    [self.fileHandle seekToEndOfFile];
    [self.fileHandle writeData:data];
    self.currentSize += data.length;
    WBLog(@"下载进度: %.2f", 100.0*self.currentSize/self.totalSize);
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    [self.fileHandle closeFile];
    self.fileHandle = nil;
    WBLog(@"DidCompleteWithError: %@", self.fullPath);
}


#pragma mark - Getter And Setter
-(NSString *)fullPath{
    if (!_fullPath) {
        _fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"1234.mp4"];
    }
    return _fullPath;
}

- (NSURLSessionDataTask *)dataTask{
    if (!_dataTask) {
        NSString *url = @"http://vod.jiankao.wang/sv/2e93f080-16776eafd53/2e93f080-16776eafd53.mp4";
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:self.fullPath error:nil];
        self.currentSize = [[fileDict valueForKey:@"NSFileSize"] integerValue];
        NSString *range = [NSString stringWithFormat:@"bytes=%zd-",self.currentSize];
        [request setValue:range forHTTPHeaderField:@"Range"];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                              delegate:self
                                                         delegateQueue:[NSOperationQueue mainQueue]];
        _dataTask = [session dataTaskWithRequest:request];
    }
    return _dataTask;
}
@end
