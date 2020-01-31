//
//  VotingTableViewCell.h
//  RevisedApp
//
//  Created by admin on 28/09/2017.
//  Copyright © 2017 dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VotingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellvotingQuestion;
@property (weak, nonatomic) IBOutlet UILabel *cellvotingDescription;
@property (weak, nonatomic) IBOutlet UIButton *cellvoting1;
@property (weak, nonatomic) IBOutlet UIButton *cellvoting2;
@property (weak, nonatomic) IBOutlet UIButton *cellvoting3;
@property (weak, nonatomic) IBOutlet UIButton *cellvoting4;

@end
