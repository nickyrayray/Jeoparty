//
//  NRFQuestionViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/13/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFQuestion.h"
#import "NRFScoreViewController.h"

@class NRFQuestionViewController;

@protocol NRFQuestionViewControllerDelegate <NSObject>

-(void)questionViewController:(NRFQuestionViewController *)questionVC didFinishWithQuestion:(NRFQuestion *)question;
-(void)questionViewControllerDidFinishTransition;

@end

@interface NRFQuestionViewController : UIViewController<NRFScoreViewControllerDelegate>

@property (nonatomic) id<NRFQuestionViewControllerDelegate> delegate;

-(id)initWithQuestion:(NRFQuestion *)question andGame:(NRFJeopardyGame *)game isDailyDouble:(BOOL)isDailyDouble;
-(id)initWithTransition:(NSString *)transitionMessage;

@end
