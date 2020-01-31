//
//  SignupViewController.m
//  RevisedApp
//
//  Created by admin on 27/09/2017.
//  Copyright © 2017 dev. All rights reserved.
//

#import "SignupViewController.h"
#import "RegisterSuccessViewController.h"

@interface SignupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputCode;
@property (weak, nonatomic) IBOutlet UITextField *inputName;
@property (weak, nonatomic) IBOutlet UITextField *inputEmail;
@property (weak, nonatomic) IBOutlet UITextField *inputPassword;

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _inputCode.delegate = self;
    _inputName.delegate = self;
    _inputEmail.delegate = self;
    _inputPassword.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backFunction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)registerFunction:(id)sender {
    if([commonUtils isEmptyString:_inputCode.text]){
        [commonUtils showAlert:@"Error!" withMessage:@"Please insert Code!"];
        return;
    }else if([commonUtils isEmptyString:_inputName.text]){
        
        [commonUtils showAlert:@"Error!" withMessage:@"Please insert Name"];
        return;
    }else if(_inputName.text.length < 5){
        [commonUtils showAlert:@"Error!" withMessage:@"Name should be 5 characters long"];
        return;
    }else if(![commonUtils validateEmail:_inputEmail.text]){
        
        [commonUtils showAlert:@"Error!" withMessage:@"Email format is not correct"];
        return;
    }else if([commonUtils isEmptyString:_inputPassword.text]){
        
        [commonUtils showAlert:@"Error!" withMessage:@"Please insert Password!"];
        return;
    }
    //for test
    
//    RegisterSuccessViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterSuccessViewController"];
//    [self.navigationController pushViewController:vc animated:YES];
    //
    [self signUpRequest];
    
}
-(void)signUpRequest{
    
    [JSWaiter ShowWaiter:self.view title:nil type:0];
    NSString *url = [NSString stringWithFormat:@"%@%@?email=%@&password=%@&code=%@&name=%@",SERVER_URL,@"user/register", _inputEmail.text, _inputPassword.text,_inputCode.text, _inputName.text];
//    NSString *url = [NSString stringWithFormat:@"%@%@",SERVER_URL,@"user/register"];
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
//    [paramDic setObject:_inputEmail.text forKey:@"email"];
//    [paramDic setObject:_inputPassword.text forKey:@"password"];
//    [paramDic setObject:_inputCode.text forKey:@"code"];
//    [paramDic setObject:_inputName.text forKey:@"name"];
    
    [[DatabaseController sharedManager] postData:paramDic url:url onSuccess:^(id response){
        [JSWaiter HideWaiter];
        NSDictionary *data = response;
        NSString *status = [data objectForKey:@"status"];
        if([status isEqualToString:@"ok"]){
            NSString *userID = [data objectForKey:@"user_id"];
            [self saveLoginUserdata];
            RegisterSuccessViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterSuccessViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [commonUtils showAlert:@"Error!" withMessage:@"SignUp Failed!"];
        }
        
    }onFailure:^(id error){
        [JSWaiter HideWaiter];
        [commonUtils showAlert:@"Error!" withMessage:@"SignUp Failed!"];
    }];

}

- (void)saveLoginUserdata{
    [[NSUserDefaults standardUserDefaults] setValue:_inputEmail.text forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setValue:_inputPassword.text forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setValue:_inputName.text forKey:@"name"];
}

//pragma mark - keyboard
-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if (textField.returnKeyType == UIReturnKeyGo) {
        [textField resignFirstResponder];
        [self registerFunction:nil];
    }
    [textField resignFirstResponder];
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
