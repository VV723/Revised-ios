//
//  AgendaViewController.m
//  RevisedApp
//
//  Created by admin on 28/09/2017.
//  Copyright © 2017 dev. All rights reserved.
//

#import "AgendaViewController.h"

@interface AgendaViewController ()
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;

@end
bool isFirst = true;
@implementation AgendaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    _contentWebView.scrollView.showsVerticalScrollIndicator = NO;
    _contentWebView.scrollView.showsHorizontalScrollIndicator = NO;
//    _contentWebView.scrollView.scrollEnabled = NO;
    NSURL *rtfUrl = [[NSBundle mainBundle] URLForResource:@"agenda13" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:rtfUrl];
    [_contentWebView loadRequest:request];
}


- (IBAction)backFunction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)dateClickFunction:(id)sender {
    isFirst = !isFirst;
    NSURL *rtfUrl;
    if(isFirst){
       [_dateButton setTitle:@"Friday, October 13" forState:UIControlStateNormal];
        rtfUrl = [[NSBundle mainBundle] URLForResource:@"agenda13" withExtension:@"html"];
    }
    else{
       [_dateButton setTitle:@"Friday, October 14" forState:UIControlStateNormal];
        rtfUrl = [[NSBundle mainBundle] URLForResource:@"agenda14" withExtension:@"html"];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:rtfUrl];
    [_contentWebView loadRequest:request];
}

@end
