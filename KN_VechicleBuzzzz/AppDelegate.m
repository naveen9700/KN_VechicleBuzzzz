//
//  AppDelegate.m
//  KN_VechicleBuzzzz
//
//  Created by VNSoftech on 11/09/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import "AppDelegate.h"
#import "homeScreen_VC.h"
#import "contactusVC.h"
#import "loginScreen.h"
#import "ViewProfile.h"
#import "Brands.h"

@interface AppDelegate ()
@property homeScreen_VC * homeVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [NSThread sleepForTimeInterval:2.0];
    NSError* configureError;
    [[GGLContext sharedInstance] configureWithError: &configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    [GIDSignIn sharedInstance].delegate = self;
    UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
   //[[NSUserDefaults standardUserDefaults]removeObjectForKey:@"used_ID"];
    
    
    if (    [[NSUserDefaults standardUserDefaults]valueForKey:@"used_ID"]> 0)
    {
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Google_Token"]);
        UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController * tab = [[UITabBarController alloc]init];
        
        
        UIViewController * home = (homeScreen_VC*)[mainStoryBoard instantiateViewControllerWithIdentifier:@"homeScreen_VC"]  ;
        home.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Home" image:[UIImage imageNamed:@"Home.png"] tag:0];
        
        
        UIViewController * brands = (Brands*)[mainStoryBoard instantiateViewControllerWithIdentifier:@"Brands"];
        brands.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Brands" image:[UIImage imageNamed:@"Menu.png"] tag:1];
        
        UIViewController * vehicleOffers = (vehicleOffersVC*)[mainStoryBoard instantiateViewControllerWithIdentifier:@"vehicleOffersVC"];
        vehicleOffers.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Offers" image:[UIImage imageNamed:@"Vehcile.png"] tag:2];
        
        UIViewController * viewProfile = (ViewProfile*)[mainStoryBoard instantiateViewControllerWithIdentifier:@"ViewProfile"];
        viewProfile.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"ViewProfile" image:[UIImage imageNamed:@"Profile.png"] tag:3];
        
        UIViewController * contact = (contactusVC*)[mainStoryBoard instantiateViewControllerWithIdentifier:@"contactusVC"];
        contact.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"contact" image:[UIImage imageNamed:@"Phone.png"] tag:4];
        
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                            NSFontAttributeName:[UIFont boldSystemFontOfSize:16]
                                                            } forState:UIControlStateNormal];
        
        
        
        [[UITabBar appearance]setTintColor:[UIColor greenColor]];
        [[UITabBar appearance]setBarTintColor:[UIColor blueColor]];
        [[UITabBar appearance]setUnselectedItemTintColor:[UIColor whiteColor]];
        
        tab.viewControllers = [NSArray arrayWithObjects:home,brands,vehicleOffers,contact,viewProfile, nil];
        UINavigationController * navigation = [[UINavigationController alloc]initWithRootViewController:tab];
        navigation.navigationBar.hidden = YES;
        self.window.rootViewController = navigation;
        [self.window makeKeyAndVisible];
        
        
    
    }
    else
    {
        
        UINavigationController * navi = (UINavigationController *)self.window.rootViewController;
        
        UIViewController * login = (loginScreen*)[mainStoryBoard instantiateViewControllerWithIdentifier:@"loginScreen"];
        navi.navigationBar.hidden = YES;
        self.window.rootViewController = navi;
        [navi pushViewController:login animated:YES];
        
        
    }
    
    
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    
    
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
   // return handled;
}


- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}




#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"KN_VechicleBuzzzz"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}



@end
