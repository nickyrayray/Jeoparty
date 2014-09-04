//
//  NRFAppDelegate.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/10/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFAppDelegate.h"
#import "NRFMainBoardViewController.h"
#import "NRFCategoryEditViewController.h"
#import "NRFMainMenuViewController.h"

@implementation NRFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    NRFMainMenuViewController *rootMVC = [[NRFMainMenuViewController alloc] init];
    self.mainMenu = rootMVC;
    [self loadData];
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:rootMVC];
    naviVC.navigationBar.barStyle = UIBarStyleBlack;
    naviVC.navigationBar.tintColor = [UIColor yellowColor];
    [naviVC.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor yellowColor],NSForegroundColorAttributeName, nil]];
    self.window.rootViewController = naviVC;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)saveData
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *myDataPath = [documentsPath stringByAppendingString:@"JeopartyData"];
    NSURL *documentsURL = [NSURL fileURLWithPath:myDataPath];
    NSData *appData = [NSKeyedArchiver archivedDataWithRootObject:self.mainMenu];
    [appData writeToURL:documentsURL atomically:YES];
}

-(void)loadData
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *myDataPath = [documentsPath stringByAppendingString:@"JeopartyData"];
    NSURL *documentsURL = [NSURL fileURLWithPath:myDataPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:myDataPath]){
        NSData *appData = [[NSData alloc] initWithContentsOfURL:documentsURL];
        NRFMainMenuViewController *mainMenu = [NSKeyedUnarchiver unarchiveObjectWithData:appData];
        self.mainMenu = mainMenu;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
