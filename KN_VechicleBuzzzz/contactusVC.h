//
//  contactusVC.h
//  KN_VechicleBuzzzz
//
//  Created by kunchal on 22/11/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface contactusVC : UIViewController<MFMailComposeViewControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTFT;
@property (weak, nonatomic) IBOutlet UITextView *textviewTFT;
@property (weak, nonatomic) IBOutlet UITextField *EmailTFT;
@property (weak, nonatomic) IBOutlet UITextField *mobileTFT;
- (IBAction)sendBTN:(UIButton *)sender;
- (IBAction)contactBTN:(UIButton *)sender;

@end
