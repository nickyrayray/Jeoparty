//
//  NRFMainBoardViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/10/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFJeopardyGamePlayable.h"
#import "NRFJeopardyGameEditable.h"
#import "NRFQuestionEditViewController.h"
#import "NRFCategoryEditViewController.h"
#import "NRFQuestionViewController.h"
#import "NRFMainMenuViewController.h"
#import "NRFEditScoreViewController.h"
#import "NRFTransitionDisplayViewController.h"
#import "NRFFinalJeopartyViewController.h"
#import "Constants.h"

#define TOTAL_QUESTION_PANELS 30
#define TOTAL_CATEGORY_PANELS 6


@interface NRFMainBoardViewController : UIViewController 

@property (strong, nonatomic)NRFJeopardyGame *game;

@property (strong, nonatomic) NSMutableArray *questionPanels;
@property (strong, nonatomic) NSMutableArray *categoryPanels;

-(id)initWithPlayableGame:(NRFJeopardyGamePlayable *)game inMode:(int)mode;
-(id)initWithEditableGame:(NRFJeopardyGameEditable *)game inMode:(int)mode;
-(id)initWithPlayableGameFromEditableGame:(NRFJeopardyGameEditable *)game inMode:(int)mode;
-(id)initWithResumedPlayableGame:(NRFJeopardyGamePlayable *)game;

@end
