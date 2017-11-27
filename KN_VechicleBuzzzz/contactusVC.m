//
//  contactusVC.m
//  KN_VechicleBuzzzz
//
//  Created by kunchal on 22/11/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import "contactusVC.h"

@interface contactusVC ()

@end

@implementation contactusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userNameTFT.delegate =self;
    self.mobileTFT.delegate =self;

    self.EmailTFT.delegate =self;

    
}

-(void)alertMessage:(NSString*)message
{
    UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"warning" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        // Ok action example
    }];
    [alert1 addAction:okAction];
    [self presentViewController:alert1 animated:YES completion:nil];
    
}

-(BOOL)textfieldshouldreturn:(UITextField*)textfield
{
    [textfield resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    
    if (textField==self.EmailTFT)
    {
        if (self.userNameTFT.text.length>0)
        {
            return YES;
        }
        else
        {
            [self alertMessage:@"Enter Name First !"];
            return NO;
        }
        
    }
    
    if (textField==self.mobileTFT)
    {
        if (self.userNameTFT.text.length>0 && self.EmailTFT.text.length>0)
        {
            return YES;
        }
        else
        {
            [self alertMessage:@"Enter Name & Email !"];
            return NO;
        }
        
    }
    
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField==self.userNameTFT)
    {
        if (self.userNameTFT.text.length>3 && self.userNameTFT.text.length<=10)
        {
            return YES;
        }
        else
            
        {
            [self alertMessage:@"user Must be greater than 3 char"];
            return  NO;
        }
    }
    
    if (textField==self.EmailTFT)
    {
        if (self.EmailTFT.text.length>3 && self.EmailTFT.text.length<=25)
        {
            return YES;
        }
        else
        {
            [self alertMessage:@"Email Must be greater than 3 char"];
            return  NO;
        }
    }
    
    
    
    if (textField==self.mobileTFT)
    {
        if (self.mobileTFT.text.length==10)
        {
            return YES;
        }
        else
        {
            [self alertMessage:@"Enter 10 digits Phone Number !"];
            
            return NO;
        }
    }
    
    
    return YES;
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    if (textField==self.userNameTFT)
    {
        if ([@"0123456789@!#$%^&*_+/*-=" containsString:string])
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    if (textField==self.mobileTFT)
    {
        
        if (self.mobileTFT.text.length==1||self.mobileTFT.text.length==10)
        {
            if (!([self.mobileTFT.text isEqualToString:@"7"]||[self.mobileTFT.text isEqualToString:@"8"]||[self.mobileTFT.text isEqualToString:@"9"]))
            {
                self.mobileTFT.text=@"";
                
                [self alertMessage:@"Mobile Number Should Start With 7/8/9"];
                return YES;
            }
            
        }
    }
    
    
    if (textField==self.EmailTFT)
    {
        
        if ([@"{}?><!#$%^&*()_+-=/*" containsString:string])
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else{
        return YES;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
}


- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult: (MFMailComposeResult)result error:(NSError *)error
{
    
    NSString *msg1;
    switch (result)
    {
        case MFMailComposeResultCancelled:
            msg1 =@"Sending Mail is cancelled";
            break;
        case MFMailComposeResultSaved:
            msg1=@"Sending Mail is Saved";
            break;
        case MFMailComposeResultSent:
            msg1 =@"Your Mail has been sent successfully";
            break;
        case MFMailComposeResultFailed:
            msg1 =@"Mail sending failed";
            break;
        default:
            msg1 =@"Your Mail is not Sent";
            break;
    }
    
    UIAlertView *mailResuletAlert = [[UIAlertView alloc]initWithFrame:CGRectMake(10, 170, 300, 120)];
    mailResuletAlert.message=msg1;
    mailResuletAlert.title=@"Message";
    [mailResuletAlert addButtonWithTitle:@"OK"];
    [mailResuletAlert show];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)mailComposer
{
    
        NSString *HiStr = @"Hi VehicleBuzzzz";
        NSString *usernameStr = @"UserName :";
        NSString *userName = self.userNameTFT.text;
        NSString *customerName = [usernameStr stringByAppendingString:userName];
        
        NSString *userEmailIDStr = @"EmailID :";
        NSString *userEmailID = self.EmailTFT.text;
        NSString *customerEmailid = [userEmailIDStr stringByAppendingString:userEmailID];
        
        NSString *userMobileNoStr = @"Mobile NO :";
        NSString *mobileNo = self.mobileTFT.text;
        NSString *customerMobileNO = [userMobileNoStr stringByAppendingString:mobileNo];
        NSString *messageReviewStr = @"Message :";
        NSString *reviewStr = self.textviewTFT.text;
        NSString *customerMessage = [messageReviewStr stringByAppendingString:reviewStr];
        
        NSString *thanqyoustr = @"Thank you";
        
        NSString *emailTitle = @"Contact to VehicleBuzzzzz";
        NSArray *myStrings = [[NSArray alloc] initWithObjects:HiStr, customerName, customerEmailid, customerMobileNO,customerMessage,thanqyoustr, nil];
        NSString *joinedString = [myStrings componentsJoinedByString:@"\n\n"];
        NSString *messageBody = joinedString;
        NSArray *toRecipents = [NSArray arrayWithObject:@"naveen.ios9700@gmail.com"];
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    
}



- (IBAction)sendBTN:(UIButton *)sender
{
    if (self.userNameTFT.text.length>0 && self.EmailTFT.text.length>0 && self.mobileTFT.text.length>0 )
    {
        
        [self mailComposer];
        
        
    }
    else
    {
        [self alertMessage:@"Enter All Fields !"];
    }
    
    
}

-(IBAction)contactBTN:(UIButton *)sender
{
    
}
@end
