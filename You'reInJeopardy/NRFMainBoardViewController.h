//
//  NRFMainBoardViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/10/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFJeopardyGame.h"
#import "NRFQuestionEditViewController.h"
#import "NRFCategoryEditViewController.h"
#import "NRFQuestionViewController.h"

@interface NRFMainBoardViewController : UIViewController <NRFQuestionEditViewControllerDelegate, NRFCategoryEditViewControllerDelegate, NRFQuestionViewControllerDelegate, NRFScoreViewControllerDelegate>

@property (strong, nonatomic)NRFJeopardyGame *game;

-(id)initWithGame:(NRFJeopardyGame *)game inMode:(NSString *)mode;

- (IBAction)choseQuestionPanel:(UIButton *)sender;

- (IBAction)choseCategoryPanel:(UIButton *)sender;

@end
