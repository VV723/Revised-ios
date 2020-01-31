//
//  SpeakerDetailViewController.m
//  RevisedApp
//
//  Created by admin on 28/09/2017.
//  Copyright © 2017 dev. All rights reserved.
//

#import "SpeakerDetailViewController.h"

@interface SpeakerDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *txtSpeaker;
@property (weak, nonatomic) IBOutlet UIView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *scrollButton;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;

@end

int speakersliderY1, speakersliderX1, speakersliderHeight1;

@implementation SpeakerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _descriptionView.delegate = self;
    [self getInitialPosition];
    [self setViewDatas];
    [self getScrollButtonMovement];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setViewDatas{
    [_txtSpeaker setText:_speakerModel.speakerName];
    [_descriptionView setText:_speakerModel.speakerPosition];
//    _txtSpeakerDescript.numberOfLines = 0; //will wrap text in new line
//    [_txtSpeakerDescript sizeToFit];
    
   //CGRect scrollFrame = CGRectMake(_contentScrollView.frame.origin.x, _contentScrollView.frame.origin.y, _contentScrollView.frame.size.width, _txtSpeakerDescript.frame.size.height);

//    [_contentScrollView setScrollEnabled:YES];
}


- (IBAction)backFunction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getInitialPosition{
    speakersliderX1 = _scrollView.frame.origin.x-6;
    speakersliderY1 = _scrollView.frame.origin.y;
    speakersliderHeight1 = _scrollView.frame.size.height;
    [_scrollButton setFrame:CGRectMake(speakersliderX1, speakersliderY1, _scrollButton.frame.size.width, _scrollButton.frame.size.height)];
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
    if(location.y > speakersliderY1 + speakersliderHeight1-10) locationY = speakersliderY1 + speakersliderHeight1-10;
    if(location.y < speakersliderY1) locationY = speakersliderY1;
    [self.scrollButton setFrame:CGRectMake(self.scrollButton.frame.origin.x, locationY, self.scrollButton.frame.size.width, self.scrollButton.frame.size.height)];
    
    //
    [self.descriptionView setContentOffset:CGPointMake(0, (locationY - speakersliderY1)/speakersliderHeight1 * (self.descriptionView.contentSize.height - self.descriptionView.frame.size.height)) animated:YES];
}

#pragma UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"Finished scrolling");
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int y = scrollView.contentOffset.y * (scrollView.frame.size.height / (scrollView.contentSize.height - scrollView.frame.size.height)) + speakersliderY1;
    if(y > speakersliderY1 + speakersliderHeight1-15) y = speakersliderY1 + speakersliderHeight1-15;
    if(y < speakersliderY1) y = speakersliderY1;
    [_scrollButton setFrame:CGRectMake(speakersliderX1, y, _scrollButton.frame.size.width, _scrollButton.frame.size.height)];
}

@end
