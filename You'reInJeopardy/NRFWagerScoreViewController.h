//
//  NRFWagerScoreViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 9/2/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFEditScoreViewController.h"

@interface NRFWagerScoreViewController : NRFEditScoreViewController

@property (strong, nonatomic)UILabel *contestantOneWagerLabel;
@property (strong, nonatomic)UILabel *contestantTwoWagerLabel;
@property (strong, nonatomic)UILabel *contestantThreeWagerLabel;

-(id)initWithGame:(NRFJeopardyGamePlayable *)game;

@end
