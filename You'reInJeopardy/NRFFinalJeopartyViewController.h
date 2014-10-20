//
//  NRFFinalJeopartyViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 9/19/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFFinalJeopartyQuestion.h"
#import "NRFWagerScoreViewController.h"
#import "NRFWagerRewardScoreViewController.h"

@interface NRFFinalJeopartyViewController : UIViewController

- (id)initWithFinalJeopartyQuestion:(NRFFinalJeopartyQuestion *)question andGame:(NRFJeopardyGamePlayable *)game;

@end
