

#import "loginScreen.h"
#import "Afnetwork_VC.h"
#import "AFNETWORK_model.h"
#import "homeScreen_VC.h"


@interface loginScreen ()<UITextFieldDelegate>

 

@end

@implementation loginScreen

- (void)viewDidLoad
{
   
    [super viewDidLoad];
    
    self.manager = [AFHTTPSessionManager manager];
    
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
   
    
    self.userViewObject.layer.borderColor = [UIColor grayColor].CGColor;
    self.userViewObject.layer.borderWidth = 1;
    
    self.pswrdViewObject.layer.borderColor = [UIColor grayColor].CGColor;
    self.pswrdViewObject.layer.borderWidth = 1;
    
    UIColor *color1 = [UIColor blackColor];
    self.userTFObject.attributedPlaceholder =[[NSAttributedString alloc]
     initWithString:@"User Name"attributes:@{NSForegroundColorAttributeName:color1}];
    
    
    
    UIColor *color2= [UIColor blackColor];
    self.pswrdTFObject.attributedPlaceholder =[[NSAttributedString alloc]
     initWithString:@"password"attributes:@{NSForegroundColorAttributeName:color2}];

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
    
//    if (textField==self.pswrdTFObject)
//    {
//        if (self.userTFObject.text.length==0)
//        {
//            [self alertMessage:@"Enter UserName First !"];
//            return YES;
//        }
//    }
//    else{
//        return YES;
//    }
    return YES;
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField==self.userTFObject)
    {
        if (self.userTFObject.text.length>3)
        {
            return YES;
        }
        else
        {
            [self alertMessage:@"UserName Must be Greater than 3 char "];

            return  NO;
        }
    }
    
    
    
    if (textField==self.pswrdTFObject )
        
    {
          if (self.pswrdTFObject.text.length>3 && self.pswrdTFObject.text.length<10)
           {
            return YES;
           }
          else
          {
            [self alertMessage:@"Password Must be greater than 3 char! "];
            return  YES;
           }
            
       }
    
    
    
    return YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    if (textField==self.userTFObject)
    {
        if ([@"!#$%^&*_+/*-=" containsString:string])
        {
            return NO;
        }
        
    }
    
    
    return YES;
    

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
}

-(IBAction)loginButton:(id)sender
{
    
    NSString * loginURL = @"http://www.vehiclebuzzzz.com/index.php/JsonController/login";
    
    NSDictionary * dict = @{@"action":@"user_account",@"username":self.userTFObject.text,@"password":self.pswrdTFObject.text};
    if (self.userTFObject.text.length >3 && self.pswrdTFObject.text.length>3 )
    {
       
      // Connecting to server With Login API
        
    [self.manager POST:loginURL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"%@",[[responseObject valueForKey:@"server_response"]valueForKey:@"state"]);
        
        NSMutableArray * response = [responseObject valueForKey:@"server_response"];

        if ([[[response objectAtIndex:0]valueForKey:@"state"] isEqualToString:@"0"] || [[[response objectAtIndex:0]valueForKey:@"state"] isEqualToString:@"1"])
        {
            NSString * storyboardName = @"Main";
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
             homeScreen_VC * vc = [storyboard instantiateViewControllerWithIdentifier:@"homeScreen_VC"];
            [self presentViewController:vc animated:YES completion:nil];
            
            
        }
        
        else{
            
            self.userTFObject.text = @"";
            self.pswrdTFObject.text = @"";
            [self.userTFObject becomeFirstResponder];
            [self alertMessage:@"Login Failed !"];
        }
        }
    
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
        {
            
            
        }];
        
        
        
    }
    else
    {
        self.userTFObject.text=@"";
        self.pswrdTFObject.text=@"";
        [self.userTFObject becomeFirstResponder];
        
        [self alertMessage:@"Enter Valid UserName & Password !"];
    }
  
}

@end
