//
//  ViewController.m
//  RevisedApp
//
//  Created by admin on 27/09/2017.
//  Copyright © 2017 dev. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadLoginUserdata];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadLoginUserdata{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *savedEmail = [userDefaults stringForKey:@"email"];
    NSString *savedPassword = [userDefaults stringForKey:@"password"];
    if([savedEmail isEqualToString:@""] || [savedPassword isEqualToString:@""]){
        return;
    }
    [self loginRequest:savedEmail password:savedPassword];
}
-(void)loginRequest:email password:pass{
    [JSWaiter ShowWaiter:self.view title:nil type:0];
    NSString *url = [NSString stringWithFormat:@"%@%@?email=%@&password=%@",SERVER_URL,@"user/login", email, pass];
    //    NSString *url = [NSString stringWithFormat:@"%@%@",SERVER_URL,@"user/login"];
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    //    [paramDic setObject:_inputEmail.text forKey:@"email"];
    //    [paramDic setObject:_inputPassword.text forKey:@"password"];
    
    [[DatabaseController sharedManager] postData:paramDic url:url onSuccess:^(id response){
        [JSWaiter HideWaiter];
        
        NSDictionary *data = response;
        NSString *status = [data objectForKey:@"status"];
        if([status isEqualToString:@"ok"]){
            HomeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
           // [commonUtils showAlert:@"Login Failed" withMessage:@"Email or Password not matching"];
        }
        
    }onFailure:^(id error){
        [JSWaiter HideWaiter];
      //  [commonUtils showAlert:@"Login Failed" withMessage:@"Please check your internet connection"];
        NSLog(@"login error:%@", error);
    }];
}

@end
