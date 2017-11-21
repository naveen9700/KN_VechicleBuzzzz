//
//  loginScreen.h
//  KN_VechicleBuzzzz
//
//  Created by VNSoftech on 11/09/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Afnetwork_VC.h"
#import <AFNetworking/AFNetworking.h>
#import <Google/SignIn.h>
#import <GoogleSignIn/GoogleSignIn.h>

@interface loginScreen : UIViewController

@property AFHTTPSessionManager *manager;

@property (weak, nonatomic) IBOutlet UIView *userViewObject;

@property (weak, nonatomic) IBOutlet UIView *pswrdViewObject;
@property (weak, nonatomic) IBOutlet UITextField *userTFObject;
@property (weak, nonatomic) IBOutlet UITextField *pswrdTFObject;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;
@property (weak, nonatomic) IBOutlet UIButton *FBlogin;
@property (weak, nonatomic) IBOutlet UIButton *GoogleLogin;




@end
