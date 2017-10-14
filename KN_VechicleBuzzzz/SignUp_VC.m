//
//  SignUp_VC.m
//  KN_VechicleBuzzzz
//
//  Created by VNSoftech on 13/09/17.
//  Copyright © 2017 VNSoftech. All rights reserved.

#import "SignUp_VC.h"
#import "Afnetwork_VC.h"

@interface SignUp_VC ()<UITextFieldDelegate,UIPickerViewDelegate>

@property UIPickerView * statePickerView;

@property NSMutableArray * StatesNamesArr;
@property NSString *stateNameId;
@end

@implementation SignUp_VC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.manager = [AFHTTPSessionManager manager];
    
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    self.statePickerView = [[UIPickerView alloc] init];
    //[self.statePickerView setDataSource:self ];
    [self.statePickerView setDelegate:self];
    self.statePickerView.showsSelectionIndicator = YES;
    self.stateName.inputView = self.statePickerView;
    //
    
    [self gettingStatesNames];
    
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

// Picker View Delegates Methods ........
#pragma mark -
#pragma Picker View Delegate methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //Return the number of components
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //Return the number of rows in the component
    return self.StatesNamesArr.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    
    return [[self.StatesNamesArr objectAtIndex:row]valueForKey:@"state"];
    //return @"Nil";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   
    self.stateName.text = [[self.StatesNamesArr objectAtIndex:row]valueForKey:@"state"];
    self.stateNameId = [[self.StatesNamesArr objectAtIndex:row]valueForKey:@"id"];
    
    NSLog(@"%@",self.stateNameId);
    
    [[self view] endEditing:YES];

}




-(BOOL)textfieldshouldreturn:(UITextField*)textfield
{
    [textfield resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    
    if (textField==self.eMailTFT)
    {
        if (self.userTFT.text.length>0)
        {
            return YES;
        }
        else
        {
            [self alertMessage:@"Enter Name First !"];
            return NO;
        }
        
    }
    
    if (textField==self.phoneTFT)
    {
        if (self.userTFT.text.length>0 && self.eMailTFT.text.length>0)
        {
            return YES;
        }
        else
        {
            [self alertMessage:@"Enter Name & Email !"];
            return NO;
        }
        
    }
    if (textField==self.passwordTFT)
    {
        if (self.userTFT.text.length>0 && self.eMailTFT.text.length>0 && self.phoneTFT.text.length>0)
        {
            return YES;
        }
        else
        {
            [self alertMessage:@"Enter Name & email & phoneNumber !"];
            return NO;
        }
        
    }
    if (textField==self.cnfPasswordTFT)
    {
        if (self.passwordTFT.text.length>3)
        {
            return YES;
        }
        else
        {
            [self alertMessage:@"Enter Password First !"];
            return NO;
        }
        
    }
    if (textField==self.cityNameTFT)
    {
        if (self.userTFT.text.length>0 && self.eMailTFT.text.length>0 && self.phoneTFT.text.length>0 && self.passwordTFT.text.length >0)
        {
            return YES;
        }
        else
        {
            [self alertMessage:@"Enter Name & email & phoneNumber !"];
            return NO;
        }
        
    }
    if (textField==self.stateName)
    {
        if (self.userTFT.text.length>0 && self.eMailTFT.text.length>0 && self.phoneTFT.text.length>0 && self.passwordTFT.text.length >0)
        {
            return YES;
        }
        else
        {
            [self alertMessage:@"Enter Name & email & phoneNumber !"];
            return NO;
        }
        
    }

    
    
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField==self.userTFT)
    {
        if (self.userTFT.text.length>3 && self.userTFT.text.length<=10)
        {
            return YES;
        }
        else
            
        {
            [self alertMessage:@"user Must be greater than 3 char"];
            return  NO;
        }
    }
    
    if (textField==self.eMailTFT)
    {
        if (self.eMailTFT.text.length>3 && self.eMailTFT.text.length<=25)
        {
            return YES;
        }
        else
        {
            [self alertMessage:@"Email Must be greater than 3 char"];
            return  NO;
        }
    }
    
    if (textField==self.cityNameTFT)
    {
        if (self.cityNameTFT.text.length>3 && self.cityNameTFT.text.length<=10)
        {
            return YES;
        }
        else
        {
            [self alertMessage:@"City Must be greater than 3 char"];

            return  NO;
        }
    }
    
    if (textField==self.phoneTFT)
    {
        if (self.phoneTFT.text.length==10)
        {
            return YES;
        }
        else
        {
            [self alertMessage:@"Enter 10 digits Phone Number !"];

            return NO;
        }
    }
    
    if (textField==self.passwordTFT)
    {
        if(self.passwordTFT.text.length>3)
        {
            return YES;
        }
        else
        {
            [self alertMessage:@"Password Must be greater than 3 char"];

            return NO;
        }
    }
    
    if (textField==self.cnfPasswordTFT)
    {
        if(self.cnfPasswordTFT.text==self.passwordTFT.text)
        {
            return YES;
        }
        else
        {
            [self alertMessage:@"Password Not Matching !"];

            return NO;
        }
    }
    
    else
    {
        return YES;
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    if (textField==self.userTFT||textField==self.cityNameTFT)
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
    
    if (textField==self.phoneTFT)
    {
        
        if (self.phoneTFT.text.length==1||self.phoneTFT.text.length==10)
        {
            if (!([self.phoneTFT.text isEqualToString:@"7"]||[self.phoneTFT.text isEqualToString:@"8"]||[self.phoneTFT.text isEqualToString:@"9"]))
            {
                self.phoneTFT.text=@"";
                
                [self alertMessage:@"Mobile Number Should Start With 7/8/9"];
                return YES;
            }
            
        }
    }
    
    
    if (textField==self.eMailTFT)
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


-(void)gettingStatesNames
{
    
   [self.manager POST:@"http://www.vehiclebuzzzz.com/index.php/JsonController/state" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        
        self.StatesNamesArr = [responseObject valueForKey:@"server_stateresponse"];
        NSLog(@"%@",self.StatesNamesArr );
    
    }
    
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
              }];
    
}

-(void)registration
{
    
    NSString * signUpURL = @"http://www.vehiclebuzzzz.com/index.php/JsonController/signup";
    
    
    NSDictionary * paramaDict = @{@"first_name":self.userTFT.text,
                                  @"email":self.eMailTFT.text,
                                  @"phone":self.phoneTFT.text,
                                  @"state":self.stateNameId,
                                  @"city":self.cityNameTFT.text,
                                  @"password":self.passwordTFT.text,
                                  @"cnfpassword":self.cnfPasswordTFT.text};
    
    [self.manager POST:signUpURL parameters:paramaDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
        
         NSLog(@"%@",responseObject);
     
     }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
        
    }];
    
    
    

}


- (IBAction)createAccountButton:(id)sender
{
    if (self.userTFT.text>0 && self.eMailTFT.text>0 && self.phoneTFT.text>0 && self.passwordTFT.text>0 && self.cnfPasswordTFT.text>0 && self.cityNameTFT.text >0 && self.stateName.text>0 )
    {
        
        [self registration];
        
        
    }
    else
    {
        [self alertMessage:@"Enter All Fields !"];
    }
   
    
    
}




@end
