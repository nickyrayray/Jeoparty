//
//  NRFQuestionEditViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/11/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFQuestion.h"

@class NRFQuestionEditViewController;

@protocol NRFQuestionEditViewControllerDelegate <NSObject>

-(void)questionEditViewController:(NRFQuestionEditViewController *)questionEditVC didFinishWithQuestion:(NRFQuestion *)question;

@end

@interface NRFQuestionEditViewController : UIViewController

@property (nonatomic) id<NRFQuestionEditViewControllerDelegate> delegate;

-(id)initWithQuestion:(NRFQuestion *)question;

@end
