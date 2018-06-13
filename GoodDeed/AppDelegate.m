//
//  AppDelegate.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/4.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "AppDelegate.h"
#import "GDHomeViewController.h"
#import "GDLeftViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    GDHomeViewController *home = [[GDHomeViewController alloc] init];
    GDLeftViewController *leftVC = [[GDLeftViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    UINavigationController *leftNav = [[UINavigationController alloc] initWithRootViewController:leftVC];
//    [home.navigationController setNavigationBarHidden:YES];
//    [leftNav.navigationController setNavigationBarHidden:YES];
    MMDrawerController *mmdc = [[MMDrawerController alloc] initWithCenterViewController:homeNav leftDrawerViewController:leftNav];
    [mmdc setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [mmdc setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    self.window.rootViewController = mmdc;
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


@end
