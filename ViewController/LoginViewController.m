//
//  LoginViewController.m
//  RevisedApp
//
//  Created by admin on 27/09/2017.
//  Copyright © 2017 dev. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputEmail;
@property (weak, nonatomic) IBOutlet UITextField *inputPassword;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadLoginUserdata];
    _inputPassword.delegate = self;
    _inputEmail.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backFunction:(id)sender {
    [_inputEmail resignFirstResponder];
    [_inputPassword resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)loginFunction:(id)sender {
    [_inputEmail resignFirstResponder];
    [_inputPassword resignFirstResponder];
    if(![commonUtils validateEmail:_inputEmail.text]){
        
        [commonUtils showAlert:@"Error!" withMessage:@"Email format is not correct"];
        return;
    }else if([commonUtils isEmptyString:_inputPassword.text]){
        [commonUtils showAlert:@"Error!" withMessage:@"Please insert Password!"];
        return;
    }
    //for test
    
//    HomeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//    [self.navigationController pushViewController:vc animated:YES];
    //not test
    [self loginRequest];
}

-(void)loginRequest{
    [JSWaiter ShowWaiter:self.view title:nil type:0];
    NSString *url = [NSString stringWithFormat:@"%@%@?email=%@&password=%@",SERVER_URL,@"user/login", _inputEmail.text, _inputPassword.text];
//    NSString *url = [NSString stringWithFormat:@"%@%@",SERVER_URL,@"user/login"];
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
//    [paramDic setObject:_inputEmail.text forKey:@"email"];
//    [paramDic setObject:_inputPassword.text forKey:@"password"];
    
    [[DatabaseController sharedManager] postData:paramDic url:url onSuccess:^(id response){
        [JSWaiter HideWaiter];
        
        NSDictionary *data = response;
        NSString *status = [data objectForKey:@"status"];
        if([status isEqualToString:@"ok"]){
            [self saveLoginUserdata];
            HomeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [commonUtils showAlert:@"Login Failed" withMessage:@"Email or Password not matching"];
        }
        
    }onFailure:^(id error){
        [JSWaiter HideWaiter];
        [commonUtils showAlert:@"Login Failed" withMessage:@"Please check your internet connection"];
         NSLog(@"login error:%@", error);
    }];
}
- (void)saveLoginUserdata{
    [[NSUserDefaults standardUserDefaults] setValue:_inputEmail.text forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setValue:_inputPassword.text forKey:@"password"];
}
-(void)loadLoginUserdata{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *savedEmail = [userDefaults stringForKey:@"email"];
    NSString *savedPassword = [userDefaults stringForKey:@"password"];
    if([savedEmail isEqualToString:@""] || [savedPassword isEqualToString:@""]){
        return;
    }
    [_inputEmail setText:savedEmail];
    [_inputPassword setText:savedPassword];
}


- (void)showAlert:(NSString *)title withMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}


//pragma mark - keyboard
-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if (textField.returnKeyType == UIReturnKeyGo) {
        [self loginFunction:nil];
    }
    [textField resignFirstResponder];
    return YES;
}



@end
