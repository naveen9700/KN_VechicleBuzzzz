//
//  AppDelegate.h
//  KN_VechicleBuzzzz
//
//  Created by VNSoftech on 11/09/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Google/SignIn.h>
#import "homeScreen_VC.h"
#import "ViewAllProductsScreen.h"
#import "vehicleOffersVC.h"
#import "contactusVC.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

