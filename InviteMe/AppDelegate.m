//
//  AppDelegate.m
//  InviteMe
//
//  Created by Sifon on 12/11/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import "ViewController.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>






@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Override point for customization after application launch.
    
    
    [Parse setApplicationId:@"r4qnMLf8S1gDTHRLWrQtLz068ZNTuU2G68C3mDTb"
                  clientKey:@"G4KQME1E0NKHkqZYN1oAwW4pMA45lupdjdM3d48S"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [ PFFacebookUtils initializeFacebook];

    
    
    [FBProfilePictureView class];

    

   
   
  
    return YES;
    
}

// FBSample logic
// If we have a valid session at the time of openURL call, we handle Facebook transitions
// by passing the url argument to handleOpenURL; see the "Just Login" sample application for
// a more detailed discussion of handleOpenURL
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    
    // You can add your app-specific url handling code here if needed
    
    return [ PFFacebookUtils handleOpenURL:url];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
