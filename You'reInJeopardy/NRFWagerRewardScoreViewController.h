//
//  NRFWagerRewardScoreViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 9/3/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFScoreViewController.h"
#import "NRFQuestionScoreViewController.h"

@interface NRFWagerRewardScoreViewController : NRFScoreViewController

@property (strong, nonatomic) id<NRFQuestionScoreViewControllerDelegate> delegate;
@property (strong, nonatomic) UIButton *contestantOnePlus;
@property (strong, nonatomic) UIButton *contestantOneMinus;
@property (strong, nonatomic)UILabel *contestantOneWagerLabel;

@property (strong, nonatomic) UIButton *contestantTwoPlus;
@property (strong, nonatomic) UIButton *contestantTwoMinus;
@property (strong, nonatomic)UILabel *contestantTwoWagerLabel;

@property (strong, nonatomic) UIButton *contestantThreePlus;
@property (strong, nonatomic) UIButton *contestantThreeMinus;
@property (strong, nonatomic)UILabel *contestantThreeWagerLabel;


@end
