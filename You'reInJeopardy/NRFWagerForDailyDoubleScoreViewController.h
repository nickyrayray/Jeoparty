//
//  NRFWagerForDailyDoubleScoreViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 9/3/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFWagerScoreViewController.h"

@protocol NRFWagerForDailyDoubleScoreViewControllerDelegate <NSObject>

-(void)wagerForDailyDoubleScoreViewControllerDidFinish;

@end


@interface NRFWagerForDailyDoubleScoreViewController : NRFWagerScoreViewController

@property (strong, nonatomic) id<NRFWagerForDailyDoubleScoreViewControllerDelegate> delegate;

-(id)initWithGame:(NRFJeopardyGamePlayable *)game;

@end
