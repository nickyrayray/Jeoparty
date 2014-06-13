//
//  NRFQuestionViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/13/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFQuestion.h"

@class NRFQuestionViewController;

@protocol NRFQuestionViewControllerDelegate <NSObject>

-(void)questionViewController:(NRFQuestionViewController *)questionVC didFinishWithQuestion:(NRFQuestion *)question;

@end

@interface NRFQuestionViewController : UIViewController

@property (nonatomic) id<NRFQuestionViewControllerDelegate> delegate;

-(id)initWithQuestion:(NRFQuestion *)question;

@end
