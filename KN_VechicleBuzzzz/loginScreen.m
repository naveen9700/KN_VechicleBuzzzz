

#import "loginScreen.h"
#import "Afnetwork_VC.h"
#import "AFNETWORK_model.h"
#import "homeScreen_VC.h"
#import "ViewAllProductsScreen.h"
#import "contactusVC.h"
#import "vehicleOffersVC.h"
#import "ViewProfile.h"
#import "Brands.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#define GoogleClientID @"395662728779-vl3vi60mbpm2hrstc8ef9bij4d99ou1i.apps.googleusercontent.com"
@interface loginScreen ()<UITextFieldDelegate  ,GIDSignInUIDelegate,GIDSignInDelegate>



 @property (nonatomic, strong) GIDSignIn *signIn;

@end

@implementation loginScreen

- (void)viewDidLoad
{
   
    [super viewDidLoad];
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    
    _signIn = [GIDSignIn sharedInstance];
    
    //  _signIn.shouldFetchGooglePlusUser = YES;
    
    _signIn.shouldFetchBasicProfile = YES;
    // Uncomment to get the user's email
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    _signIn.clientID = GoogleClientID;
    
    // "https://www.googleapis.com/auth/plus.login" scope
    
    _signIn.scopes = @[@"profile",@"https://www.googleapis.com/auth/plus.login"];
    // "profile" scope
    
    // Optional: declare signIn.actions, see "app activities"
    _signIn.delegate = self;
    
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
            [self .navigationController pushViewController:vc animated:YES];
            
            
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
- (IBAction)faceBookLogin:(UIButton *)sender
{
    
    
}
- (IBAction)skipButton:(UIButton *)sender
{
    
    [self tabBarFUNC];
}
- (IBAction)googleLogin:(UIButton *)sender
{
    
    
    [self.signIn signInSilently];
    [self.signIn signIn];
}
- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error
{
    
}
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error
{
    // Perform any operations on signed in user here.
    NSString *userId = user.userID;
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"used_ID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString *idToken = user.authentication.idToken;
   // [[NSUserDefaults standardUserDefaults] setObject:idToken forKey:@"Google_Token"];
   // [[NSUserDefaults standardUserDefaults] synchronize];
    NSString *fullName = user.profile.name;
    NSString *email = user.profile.email;
    
    NSLog(@"%@  .... %@  ... %@ ...  %@",userId,idToken,fullName,email);
    
    
    

    
        if (userId.length>0)
        {
            
            
            NSDictionary *params  = @{@"action":@"google_account",@"name":fullName,@"email":email ,@"social_id":userId};
            
            
            [self loginWebServiceCall:@"user_account" andParams:params];

            
        }
    
    
}

-(void)loginWebServiceCall:(NSString*)action andParams:(NSDictionary*)params
{
    NSString * googleURL = @"http://www.vehiclebuzzzz.com/index.php/JsonController/login";
    [self.manager POST:googleURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     
     {
         NSLog(@"%@",responseObject);
         
         [self tabBarFUNC];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
     }];
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController
{
    
    [self.navigationController pushViewController:viewController animated:YES];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)tabBarFUNC
{
    
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
//    UINavigationController * navigation = [[UINavigationController alloc]initWithRootViewController:tab];
//    navigation.navigationBar.hidden = YES;
//    
    [self.window makeKeyAndVisible];
    
    [self.navigationController pushViewController:tab animated:YES];
    
}



@end
