//
//  NRFEditScoreViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 9/1/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFQuestionScoreViewController.h"

@interface NRFEditScoreViewController : NRFQuestionScoreViewController

@property (strong, nonatomic) UISegmentedControl *contestantOneIncrementValueSegment;
@property (strong, nonatomic) UISegmentedControl *contestantTwoIncrementValueSegment;
@property (strong, nonatomic) UISegmentedControl *contestantThreeIncrementValueSegment;

-(id)initWithGame:(NRFJeopardyGamePlayable *)game;

@end
