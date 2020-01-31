//
//  VotingViewController.m
//  RevisedApp
//
//  Created by admin on 28/09/2017.
//  Copyright © 2017 dev. All rights reserved.
//

#import "VotingViewController.h"
#import "VotingModel.h"
#import "VotingTableViewCell.h"

@interface VotingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *votingTable;
@property (weak, nonatomic) IBOutlet UIView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *scrollButton;
@property (nonatomic) NSMutableArray *votingData;
@end

int votingsliderY, votingsliderX, votingsliderHeight;

@implementation VotingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _votingData = [NSMutableArray new];
    [self getInitialPosition];
    [self getTableData];
    [self getScrollButtonMovement];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backFunction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getInitialPosition{
    votingsliderX = _scrollView.frame.origin.x-6;
    votingsliderY = _scrollView.frame.origin.y;
    votingsliderHeight = _scrollView.frame.size.height;
    [_scrollButton setFrame:CGRectMake(votingsliderX, votingsliderY, _scrollButton.frame.size.width, _scrollButton.frame.size.height)];
}
- (void)getTableData{
    for(int i = 0; i < 20; i++){
        VotingModel *model = [VotingModel new];
        model.votingQuestion = @"Question";
        model.votingDescription = @"Dr. Paul Dorian is the Department Director?";
        [_votingData addObject:model];
    }
    [self.votingTable reloadData];
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
    if(location.y > votingsliderY + votingsliderHeight-10) locationY = votingsliderY + votingsliderHeight-10;
    if(location.y < votingsliderY) locationY = votingsliderY;
    [self.scrollButton setFrame:CGRectMake(self.scrollButton.frame.origin.x, locationY, self.scrollButton.frame.size.width, self.scrollButton.frame.size.height)];
    
    //
    [self.votingTable setContentOffset:CGPointMake(0, (locationY - votingsliderY)/votingsliderHeight * (self.votingTable.contentSize.height - self.votingTable.frame.size.height)) animated:YES];
}
#pragma UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"Finished scrolling");
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int y = scrollView.contentOffset.y * (scrollView.frame.size.height / (scrollView.contentSize.height - scrollView.frame.size.height)) + scrollView.frame.origin.y;
    if(y > votingsliderY + votingsliderHeight-15) y = votingsliderY + votingsliderHeight-15;
    if(y < votingsliderY) y = votingsliderY;
    [_scrollButton setFrame:CGRectMake(votingsliderX, y, _scrollButton.frame.size.width, _scrollButton.frame.size.height)];
}


#pragma mark - TableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _votingData.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VotingTableViewCell* cell = (VotingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"VotingTableViewCell"];
    VotingModel *model = [_votingData objectAtIndex:indexPath.row];
    cell.cellvotingQuestion.text = model.votingQuestion;
    cell.cellvotingDescription.text = model.votingDescription;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{    
}

@end
