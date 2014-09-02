//
//  NRFOldGamesTableViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/25/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFInitializerScoreViewController.h"
#import "NRFMainMenuViewController.h"
#import "NRFJeopardyGamePlayable.h"
#import "NRFJeopardyGame.h"
#import "NRFMainBoardViewController.h"
#import "Constants.h"

@interface NRFOldGamesTableViewController : UITableViewController

@property (strong, nonatomic)NRFScoreViewController *delegate;

-(id)initWithGames:(NSMutableArray *)games inMode:(int)mode;

@end
