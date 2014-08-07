//
//  NRFOldGamesTableViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/25/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFScoreViewController.h"
#import "NRFMainMenuViewController.h"
#import "NRFJeopardyGamePlayable.h"
#import "NRFJeopardyGame.h"
#import "NRFMainBoardViewController.h"

@interface NRFOldGamesTableViewController : UITableViewController<NRFScoreViewControllerDelegate>

@property (strong, nonatomic)NRFScoreViewController *delegate;

-(id)initWithGames:(NSMutableArray *)games inMode:(NSString *)mode;

@end
