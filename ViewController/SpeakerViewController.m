//
//  SpeakerViewController.m
//  RevisedApp
//
//  Created by admin on 28/09/2017.
//  Copyright © 2017 dev. All rights reserved.
//

#import "SpeakerViewController.h"
#import "SpeakerCollectionViewCell.h"
#import "SpeakerModel.h"
#import "SpeakerDetailViewController.h"

@interface SpeakerViewController ()
@property (weak, nonatomic) IBOutlet UIView *speakerSliderView;
@property (weak, nonatomic) IBOutlet UIButton *speakerSliderButton;
//@property (weak, nonatomic) IBOutlet UITableView *speakerTableView;
@property (weak, nonatomic) IBOutlet UIView *tableViewContainer;
@property (nonatomic) NSMutableArray *speakerData;
@end
UITableView *scrollTableView;
int speakersliderY, speakersliderX, speakersliderHeight;
@implementation SpeakerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getInitialPosition];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backFunction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getInitialPosition{
    speakersliderX = _speakerSliderView.frame.origin.x-6;
    speakersliderY = _speakerSliderView.frame.origin.y;
    speakersliderHeight = _speakerSliderView.frame.size.height;
    [_speakerSliderButton setFrame:CGRectMake(speakersliderX, speakersliderY, _speakerSliderButton.frame.size.width, _speakerSliderButton.frame.size.height)];
}


#pragma UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"Finished scrolling");
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int y = scrollView.contentOffset.y * (scrollView.frame.size.height / (scrollView.contentSize.height - scrollView.frame.size.height)) + scrollView.frame.origin.y;
    if(y > speakersliderY + speakersliderHeight-15) y = speakersliderY + speakersliderHeight-15;
    if(y < speakersliderY) y = speakersliderY;
    [_speakerSliderButton setFrame:CGRectMake(speakersliderX, y, _speakerSliderButton.frame.size.width, _speakerSliderButton.frame.size.height)];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString: @"embed_tableview"]) {
        UITableViewController * childViewController = (UITableViewController *) [segue destinationViewController];
 //       scrollTableView = childViewController.view;
 //       tableView.delegate = self;
        // do something with the AlertView's subviews here...
    }
}
@end
