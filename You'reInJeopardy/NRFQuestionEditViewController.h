//
//  NRFQuestionEditViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/11/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFQuestion.h"
#import "NRFFinalJeopartyQuestion.h"

@class NRFQuestionEditViewController;

@protocol NRFQuestionEditViewControllerDelegate <NSObject>

-(void)questionEditViewControllerDidFinishWithQuestion:(NRFQuestion *)question mightNeedIncrement:(BOOL)mightNeedIncrement;

@end

@interface NRFQuestionEditViewController : UIViewController

@property (nonatomic) id<NRFQuestionEditViewControllerDelegate> delegate;

-(id)initWithQuestion:(NRFQuestion *)question;
-(id)initWithFinalJeopartyQuestion:(NRFFinalJeopartyQuestion *)finalJeopartyQuestion;

@end
