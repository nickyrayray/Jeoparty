//
//  NRFQuestionScoreViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 9/1/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFScoreViewController.h"

@interface NRFQuestionScoreViewController : NRFScoreViewController

@property int questionValue;

@property (strong, nonatomic) UIButton *contestantOnePlus;
@property (strong, nonatomic) UIButton *contestantOneMinus;

@property (strong, nonatomic) UIButton *contestantTwoPlus;
@property (strong, nonatomic) UIButton *contestantTwoMinus;

@property (strong, nonatomic) UIButton *contestantThreePlus;
@property (strong, nonatomic) UIButton *contestantThreeMinus;

-(id)initWithGame:(NRFJeopardyGamePlayable *)game andQuestion:(NRFQuestion *)question;

@end
