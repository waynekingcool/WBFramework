//
//  TestGCDController.m
//  WBFramework
//
//  Created by apple on 2018/10/23.
//  Copyright © 2018年 wayneking. All rights reserved.
//  https://javbuff.men/cn/hot/

#import "TestGCDController.h"

@interface TestGCDController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *dataArray;

@end

@implementation TestGCDController

/*
 DISPATCH_QUEUE_SERIAL 串行队列
 DISPATCH_QUEUE_CONCURRENT 并行队列
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [WBUtil createTableView:self SeparatorStyle:UITableViewCellSeparatorStyleNone rowHeight:0 CellClass:[UITableViewCell class]];
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    
}

#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            [self testGroup];
        }
            break;
        case 1:
        {
            [self testGroup2];
        }
            break;
        case 2:
        {
            [self testNo2];
        }
            break;
        case 3:
        {
            [self testNo22];
        }
            break;
        case 4:
        {
            [self testSema];
        }
            break;
        default:
            break;
    }
}


#pragma mark - NO1.
//同步任务
- (void)testGroup{
    //并行队列
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t group1 = dispatch_group_create();
    
    dispatch_group_async(group1, queue1, ^{
       
        dispatch_sync(queue1, ^{
            for (NSInteger i = 0; i < 3; i++) {
                sleep(1);
                WBLog(@"同步任务执行-:%ld    任务1",(long)i);
            }
        });
        
    });
    
    
    dispatch_group_async(group1, queue1, ^{
       
        dispatch_sync(queue1, ^{
            for (NSInteger i = 0; i < 3; i++) {
                sleep(1);
                WBLog(@"同步任务执行-:%ld  任务2",(long)i);
            }
        });
        
    });
    
    
    dispatch_group_notify(group1, queue1, ^{
        WBLog(@"全部任务执行完成===========================");
    });
}

//异步任务
- (void)testGroup2{
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group1 = dispatch_group_create();
    
    dispatch_group_async(group1, queue1, ^{
        
        dispatch_async(queue1, ^{
            for (NSInteger i = 0 ; i < 3; i++) {
                sleep(1);
                WBLog(@"异步任务执行-: %ld 任务1",(long)i);
            }
        });
        
    });
    
    
    dispatch_group_async(group1, queue1, ^{
       
        dispatch_async(queue1, ^{
            for (NSInteger i = 0; i < 3; i++) {
                sleep(1);
                WBLog(@"异步任务执行-:%ld 任务2",(long)i);
            }
        });
        
    });
    
    dispatch_group_notify(group1, queue1, ^{
        WBLog(@"全部任务执行完成===========================");
    });
}

#pragma mark - NO2.  优先选择此方法
- (void)testNo2{
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group1 = dispatch_group_create();
    
    dispatch_group_enter(group1);
    dispatch_sync(queue1, ^{
        for (NSInteger i = 0; i < 3; i++) {
            sleep(1);
            WBLog(@"同步任务执行-:%ld  任务1",(long)i);
        }
        dispatch_group_leave(group1);
    });
    
    dispatch_group_enter(group1);
    dispatch_sync(queue1, ^{
        for (NSInteger i = 0; i < 3; i++) {
            sleep(1);
            WBLog(@"同步任务执行-: %ld  任务2",(long)i);
        }
        dispatch_group_leave(group1);
    });
    
    dispatch_group_notify(group1, queue1, ^{
         WBLog(@"全部任务执行完成===========================");
    });
    
}

- (void)testNo22{
    dispatch_queue_t queue = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            sleep(1);
            WBLog(@"异步任务-: %ld  任务1",(long)i);
        }
        dispatch_group_leave(group);
    });
    
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            sleep(1);
            WBLog(@"异步任务-: %ld  任务2",(long)i);
        }
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, queue, ^{
        WBLog(@"全部任务执行完成===========================");
    });
    
    
}

#pragma mark - 信号量
/*
 信号量: 信号量是一种可用来控制访问资源的数量的标识,设定了一个信号量,在线程访问之前,加上信号量的处理,则可告知系统按照我们制定的信号数量来指定
            多个线程.类似锁机制,只不过信号量都是系统帮我们处理了,我们只需要在执行线程之前,设定一个信号量值,并且在使用时,加上信号量处理方法就行了.
 
            1.创建信号量,参数: 信号量的初值,如果小于0则会返回null. dispatch_semaphore_create(5);
            2.等待降低信号量:dispatch_semaphore_wait(信号量, 等待时间).
            3.提高信号量: dispatch_semaphore_signal(信号量)
 
 多图片上传可以用到!
 */

- (void)testSema{
    //最多两个资源可以访问
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //任务1
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        WBLog(@"run task 1");
        sleep(1);
        WBLog(@"complete task 1");
        dispatch_semaphore_signal(semaphore);
    });
    
    //任务2
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        WBLog(@"run task 2");
        sleep(1);
        WBLog(@"complete task 2");
        dispatch_semaphore_signal(semaphore);
    });
    
    //任务3
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        WBLog(@"run task 3");
        sleep(1);
        WBLog(@"complete task 3");
        dispatch_semaphore_signal(semaphore);
    });
    
}


#pragma mark - Getter And Setter
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"同步任务",@"异步任务",@"同步任务2",@"异步任务2",@"信号量"];
    }
    return _dataArray;
}


@end

/*
 
 */
