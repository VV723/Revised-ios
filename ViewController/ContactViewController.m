//
//  ContactViewController.m
//  RevisedApp
//
//  Created by admin on 05/10/2017.
//  Copyright © 2017 dev. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *contactWebView;
@property (weak, nonatomic) IBOutlet UIButton *scrollButton;
@property (weak, nonatomic) IBOutlet UIView *scrollView;

@end

int contactsliderY, contactsliderX, contactsliderHeight;

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _contactWebView.scrollView.delegate = self;
    [self loadData];
    [self getInitialPosition];
    [self getScrollButtonMovement];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backFunction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadData{
    _contactWebView.scrollView.showsVerticalScrollIndicator = NO;
    _contactWebView.scrollView.showsHorizontalScrollIndicator = NO;
    NSURL *rtfUrl = [[NSBundle mainBundle] URLForResource:@"contact" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:rtfUrl];
    [_contactWebView loadRequest:request];
}

- (void)getInitialPosition{
    contactsliderX = _scrollView.frame.origin.x-6;
    contactsliderY = _scrollView.frame.origin.y;
    contactsliderHeight = _scrollView.frame.size.height;
    [_scrollButton setFrame:CGRectMake(contactsliderX, contactsliderY, _scrollButton.frame.size.width, _scrollButton.frame.size.height)];
}

- (void)getScrollButtonMovement {
    UIPanGestureRecognizer *singleFingerTap =
    [[UIPanGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.scrollButton addGestureRecognizer:singleFingerTap];
    
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    CGFloat locationY = location.y;
    if(location.y > contactsliderY + contactsliderHeight-10) locationY = contactsliderY + contactsliderHeight-10;
    if(location.y < contactsliderY) locationY = contactsliderY;
    [self.scrollButton setFrame:CGRectMake(self.scrollButton.frame.origin.x, locationY, self.scrollButton.frame.size.width, self.scrollButton.frame.size.height)];
    
    //
    [self.contactWebView.scrollView setContentOffset:CGPointMake(0, (locationY - contactsliderY)/contactsliderHeight * (self.contactWebView.scrollView.frame.size.height - self.contactWebView.frame.size.height)) animated:YES];
}
#pragma UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"Finished scrolling");
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int y = scrollView.contentOffset.y * (scrollView.frame.size.height / (scrollView.contentSize.height - scrollView.frame.size.height)) + scrollView.frame.origin.y;
    if(y > contactsliderY + contactsliderHeight) y = contactsliderY + contactsliderHeight;
    if(y < contactsliderY) y = contactsliderY;
    [self.scrollButton setFrame:CGRectMake(contactsliderX, y, self.scrollButton.frame.size.width, self.scrollButton.frame.size.height)];
}

@end
