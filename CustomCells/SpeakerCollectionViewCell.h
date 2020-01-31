//
//  SpeakerCollectionViewCell.h
//  RevisedApp
//
//  Created by admin on 28/09/2017.
//  Copyright © 2017 dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeakerCollectionViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *speakerImg;
@property (weak, nonatomic) IBOutlet UILabel *speakerTxt1;
@property (weak, nonatomic) IBOutlet UILabel *speakerTxt2;
@property (weak, nonatomic) IBOutlet UILabel *speakerTxt3;
@property (weak, nonatomic) IBOutlet UILabel *speakerTxt4;

@end
