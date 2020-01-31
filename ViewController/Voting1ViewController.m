//
//  Voting1ViewController.m
//  RevisedApp
//
//  Created by admin on 05/10/2017.
//  Copyright © 2017 dev. All rights reserved.
//

#import "Voting1ViewController.h"

@interface Voting1ViewController ()

@end

@implementation Voting1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backFunction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)linkClick:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://geniteam.com"]];
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
