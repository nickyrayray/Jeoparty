//
//  NRFQuestionViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/13/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFQuestion.h"
#import "NRFQuestionScoreViewController.h"
#import "NRFWagerForDailyDoubleScoreViewController.h"
#import "NRFWagerRewardScoreViewController.h"

@class NRFQuestionViewController;

@protocol NRFQuestionViewControllerDelegate <NSObject>

@optional
-(void)questionViewController:(NRFQuestionViewController *)questionVC didFinishWithQuestion:(NRFQuestion *)question;
-(void)questionViewControllerDidFinishTransition;

@end

@interface NRFQuestionViewController : UIViewController

@property (nonatomic) id<NRFQuestionViewControllerDelegate> delegate;

-(id)initWithQuestion:(NRFQuestion *)question andGame:(NRFJeopardyGame *)game isDailyDouble:(BOOL)isDailyDouble;

@end
