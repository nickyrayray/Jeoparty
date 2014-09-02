//
//  NRFMainMenuViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 8/8/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFTabBarViewController.h"
#import "NRFOldGamesTableViewController.h"
#import "Constants.h"


@interface NRFMainMenuViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *games;
@property (strong, nonatomic) NRFJeopardyGamePlayable *currentGame;

-(id)init;

@end
