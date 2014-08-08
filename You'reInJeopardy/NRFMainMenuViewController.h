//
//  NRFMainMenuViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 7/8/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFMainBoardViewController.h"
#import "NRFOldGamesTableViewController.h"
#import "NRFTabBarViewController.h"
#import "NRFJeopardyGameEditable.h"
#import "NRFJeopardyGamePlayable.h"

@interface NRFMainMenuViewController : UIViewController<NSCoding, NRFTabBarViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *games;

-(id)init;

@end
