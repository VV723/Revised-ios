//
//  WelcomeViewController.m
//  RevisedApp
//
//  Created by admin on 28/09/2017.
//  Copyright © 2017 dev. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *welcomeTextView;
@property (weak, nonatomic) IBOutlet UIView *sliderView;
@property (weak, nonatomic) IBOutlet UIButton *sliderButton;
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;

@end

int sliderY, sliderX, sliderHeight;


@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //_welcomeTextView.delegate = self;
    _contentWebView.scrollView.delegate = self;
    // Do any additional setup after loading the view.
    [self loadData];
    [self getInitialPosition];
    [self getScrollButtonMovement];
}

-(void)loadData1{
    NSURL *htmlString = [[NSBundle mainBundle] URLForResource: @"welcome1" withExtension:@"rtf"];
    NSAttributedString *stringWithHTMLAttributes = [[NSAttributedString alloc]   initWithFileURL:htmlString options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    _welcomeTextView.attributedText=stringWithHTMLAttributes;
}

-(void)loadData{
    _contentWebView.scrollView.showsVerticalScrollIndicator = NO;
    _contentWebView.scrollView.showsHorizontalScrollIndicator = NO;
    NSURL *rtfUrl = [[NSBundle mainBundle] URLForResource:@"welcome" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:rtfUrl];
    [_contentWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getInitialPosition{
    sliderX = _sliderView.frame.origin.x-6;
    sliderY = _sliderView.frame.origin.y;
    sliderHeight = _sliderView.frame.size.height;
    [_sliderButton setFrame:CGRectMake(sliderX, sliderY, _sliderButton.frame.size.width, _sliderButton.frame.size.height)];
}
- (IBAction)backFunction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)getScrollButtonMovement {
    UIPanGestureRecognizer *singleFingerTap =
    [[UIPanGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.sliderButton addGestureRecognizer:singleFingerTap];
    
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    CGFloat locationY = location.y;
    if(location.y > sliderY + sliderHeight-10) locationY = sliderY + sliderHeight-10;
    if(location.y < sliderY) locationY = sliderY;
    [self.sliderButton setFrame:CGRectMake(self.sliderButton.frame.origin.x, locationY, self.sliderButton.frame.size.width, self.sliderButton.frame.size.height)];
    
    //
    [self.contentWebView.scrollView setContentOffset:CGPointMake(0, (locationY - sliderY)/sliderHeight * (self.contentWebView.scrollView.frame.size.height - self.contentWebView.frame.size.height)) animated:YES];
}
#pragma UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"Finished scrolling");
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int y = scrollView.contentOffset.y * (scrollView.frame.size.height / (scrollView.contentSize.height - scrollView.frame.size.height)) + scrollView.frame.origin.y;
    if(y > sliderY + sliderHeight-15) y = sliderY + sliderHeight-15;
    if(y < sliderY) y = sliderY;
    [_sliderButton setFrame:CGRectMake(sliderX, y, _sliderButton.frame.size.width, _sliderButton.frame.size.height)];
}

@end
