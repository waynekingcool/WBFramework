//
//  AppDelegate.m
//  WBFramework
//
//  Created by wayneking on 2018/7/11.
//  Copyright © 2018年 wayneking. All rights reserved.
//  别人觉得好的不一定是适合自己的,只有适合自己才是最好的(#^.^#)

#import "AppDelegate.h"
#import <JLRoutes.h>
#import "ViewController.h"
#import <WRNavigationBar/WRNavigationBar.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //注册普通路由
    [self registerCommRoute];
    
    //注册http路由
    [self registerSchemeRoute];
    
    ViewController *vc = [[ViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self setNavBarAppearence];
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)app openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    //当从外面跳转进app则执行该方法
    return YES;
}

#pragma mark - 注册PUSH PRESENT路由方式
- (void)registerCommRoute{
    //push
    [[JLRoutes globalRoutes] addRoute:PushRoute handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        UIViewController *currentVC = [self currentViewController];
        UIViewController *v = [[NSClassFromString(parameters[@"viewController"]) alloc] init];
        [self paramToVc:v param:parameters];
        [currentVC.navigationController pushViewController:v animated:YES];
        return YES;
    }];
    
    //present
    [[JLRoutes globalRoutes] addRoute:PresentRoute handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        UIViewController *currentVC = [self currentViewController];
        UIViewController *v = [[NSClassFromString(parameters[@"viewController"]) alloc] init];
        [self paramToVc:v param:parameters];
        [currentVC.navigationController presentViewController:v animated:YES completion:nil];
        return YES;
    }];
}

- (void)registerSchemeRoute{
    //路由
    [JLRoutes setVerboseLoggingEnabled:YES];
    [JLRoutes setAlwaysTreatsHostAsPathComponent:YES];
    
    [[JLRoutes routesForScheme:@"http"] addRoute:@"/:host/" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        WBLog(@"Http路由");
        return NO;
    }];
    
    [[JLRoutes routesForScheme:@"https"] addRoute:@"/:host" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        WBLog(@"Https路由");
        return NO;
    }];
}

-(UIViewController *)currentViewController{
    
    UIViewController * currVC = nil;
    UIViewController * Rootvc = self.window.rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}

-(void)paramToVc:(UIViewController *) v param:(NSDictionary<NSString *,NSString *> *)parameters{
    //        runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(v.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [v setValue:param forKey:key];
        }
    }
}

#pragma mark - 设置Navi
- (void)setNavBarAppearence{
    [WRNavigationBar wr_widely];
    
    // 设置导航栏默认的背景颜色
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:MainNavBarColor];
    // 设置导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
    // 设置导航栏标题默认颜色
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    // 统一设置状态栏样式
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];
}

@end
