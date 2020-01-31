//
//  MapViewController.m
//  RevisedApp
//
//  Created by admin on 02/10/2017.
//  Copyright © 2017 dev. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
//@property (nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIWebView *mapWebView;
@property (weak, nonatomic) IBOutlet UIView *mapScrollView;
@property (weak, nonatomic) IBOutlet UIButton *mapScrollButton;

@end

int mapsliderY, mapsliderX, mapsliderHeight;
@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapWebView.scrollView.delegate = self;
    [self loadData];
    [self getInitialPosition];
    [self getScrollButtonMovement];
//    [self getMyLocation];
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
    _mapWebView.scrollView.showsVerticalScrollIndicator = NO;
    _mapWebView.scrollView.showsHorizontalScrollIndicator = NO;
    NSURL *rtfUrl = [[NSBundle mainBundle] URLForResource:@"logistics" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:rtfUrl];
    [_mapWebView loadRequest:request];
}

- (void)getInitialPosition{
    mapsliderX = _mapScrollView.frame.origin.x-6;
    mapsliderY = _mapScrollView.frame.origin.y;
    mapsliderHeight = _mapScrollView.frame.size.height;
    [_mapScrollButton setFrame:CGRectMake(mapsliderX, mapsliderY, _mapScrollButton.frame.size.width, _mapScrollButton.frame.size.height)];
}

- (void)getScrollButtonMovement {
    UIPanGestureRecognizer *singleFingerTap =
    [[UIPanGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.mapScrollButton addGestureRecognizer:singleFingerTap];
    
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    CGFloat locationY = location.y;
    if(location.y > mapsliderY + mapsliderHeight-10) locationY = mapsliderY + mapsliderHeight-10;
    if(location.y < mapsliderY) locationY = mapsliderY;
    [self.mapScrollButton setFrame:CGRectMake(self.mapScrollButton.frame.origin.x, locationY, self.mapScrollButton.frame.size.width, self.mapScrollButton.frame.size.height)];
    
    //
    [self.mapWebView.scrollView setContentOffset:CGPointMake(0, (locationY - mapsliderY)/mapsliderHeight * (self.mapWebView.scrollView.frame.size.height - self.mapWebView.frame.size.height)) animated:YES];
}
#pragma UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"Finished scrolling");
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int y = scrollView.contentOffset.y * (scrollView.frame.size.height / (scrollView.contentSize.height - scrollView.frame.size.height)) + scrollView.frame.origin.y;
    if(y > mapsliderY + mapsliderHeight) y = mapsliderY + mapsliderHeight;
    if(y < mapsliderY) y = mapsliderY;
    [self.mapScrollButton setFrame:CGRectMake(mapsliderX, y, self.mapScrollButton.frame.size.width, self.mapScrollButton.frame.size.height)];
}
@end
