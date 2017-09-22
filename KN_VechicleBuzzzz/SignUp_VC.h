//
//  SignUp_VC.h
//  KN_VechicleBuzzzz
//
//  Created by VNSoftech on 13/09/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Afnetwork_VC.h"
#import <AFNetworking/AFNetworking.h>
@interface SignUp_VC : UIViewController

@property AFHTTPSessionManager *manager;



@property (weak, nonatomic) IBOutlet UITextField *passwordTFT;
@property (weak, nonatomic) IBOutlet UITextField *cityNameTFT;

@property (weak, nonatomic) IBOutlet UITextField *cnfPasswordTFT;

@property (weak, nonatomic) IBOutlet UITextField *phoneTFT;

@property (weak, nonatomic) IBOutlet UITextField *userTFT;
@property (weak, nonatomic) IBOutlet UITextField *eMailTFT;
@property (weak, nonatomic) IBOutlet UITextField *stateName;

@end
