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

@interface NRFMainBoardViewController : UIViewController <NRFQuestionEditViewControllerDelegate, NRFCategoryEditViewControllerDelegate, NRFQuestionViewControllerDelegate, NRFScoreViewControllerDelegate>

@property (strong, nonatomic)NRFJeopardyGame *game;
@property (strong, nonatomic)NRFMainBoardViewController *delegate;

-(id)initWithPlayableGame:(NRFJeopardyGamePlayable *)game inMode:(NSString *)mode;
-(id)initWithEditableGame:(NRFJeopardyGameEditable *)game inMode:(NSString *)mode;
-(id)initWithPlayableGameFromEditableGame:(NRFJeopardyGameEditable *)game inMode:(NSString *)mode;

- (IBAction)choseQuestionPanel:(UIButton *)sender;

- (IBAction)choseCategoryPanel:(UIButton *)sender;

@end
