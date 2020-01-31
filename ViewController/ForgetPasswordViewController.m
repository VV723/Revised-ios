//
//  ForgetPasswordViewController.m
//  RevisedApp
//
//  Created by admin on 27/09/2017.
//  Copyright © 2017 dev. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputEmail;
@property (weak, nonatomic) IBOutlet UIView *requestView;
@property (weak, nonatomic) IBOutlet UIView *loginView;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.requestView setHidden:NO];
    [self.loginView setHidden:YES];
    _inputEmail.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backFunction:(id)sender {
    [_inputEmail resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)sendEmailFunction:(id)sender {
    [_inputEmail resignFirstResponder];
    
    if(![commonUtils validateEmail:_inputEmail.text]){
        
        [commonUtils showAlert:@"Error!" withMessage:@"Email format is not correct"];
        return;
    }
    [self.requestView setHidden:YES];
    [self.loginView setHidden:NO];
//    HomeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//    [self.navigationController presentViewController:vc animated:YES completion:nil];
}
- (IBAction)goToLogin:(id)sender {
    [_inputEmail resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}


//pragma mark - keyboard
-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if (textField.returnKeyType == UIReturnKeyGo) {
        [textField resignFirstResponder];
        [self sendEmailFunction:nil];
    }
    return YES;
}

@end
