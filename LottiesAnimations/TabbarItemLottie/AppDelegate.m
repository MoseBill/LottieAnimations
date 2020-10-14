//
//  AppDelegate.m
//  TabbarItemLottie
//
//  Created by 叶晓倩 on 2017/9/27.
//  Copyright © 2017年 xa. All rights reserved.
//

#import "AppDelegate.h"
#import "TabbarVC.h"

@interface AppDelegate ()

@property(nonatomic,strong)TabbarVC *tabbarVC;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = self.tabbarVC;
    
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
#pragma mark —— lazyLoad
-(TabbarVC *)tabbarVC{
    if (!_tabbarVC) {
        _tabbarVC = TabbarVC.new;
        _tabbarVC.myTabBar.offsetHeight = 5;
        
        [_tabbarVC.humpIndex addObject:@(1)];
        [_tabbarVC.humpIndex addObject:@(2)];
        
        [_tabbarVC.childMutArr addObject:VC_1.new];
        [_tabbarVC.childMutArr addObject:VC_2.new];
        [_tabbarVC.childMutArr addObject:VC_3.new];
    //    [_tabbarVC.childMutArr addObject:VC_4.new];
    //    [_tabbarVC.childMutArr addObject:VC_5.new];
    //    [_tabbarVC.childMutArr addObject:VC_6.new];
    //    [_tabbarVC.childMutArr addObject:VC_7.new];
    //    [_tabbarVC.childMutArr addObject:VC_8.new];
    //    [_tabbarVC.childMutArr addObject:VC_9.new];
    }return _tabbarVC;
}


@end
