//
//  SpeakerDetailViewController.h
//  RevisedApp
//
//  Created by admin on 28/09/2017.
//  Copyright © 2017 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpeakerModel.h"

@interface SpeakerDetailViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic) SpeakerModel *speakerModel;

@end
