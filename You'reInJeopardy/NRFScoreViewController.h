//
//  NRFScoreViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 7/22/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFJeopardyGame.h"

@protocol NRFScoreViewControllerDelegate <NSObject>

-(void)scoreVCDidFinish;
-(void)scoreVCDidFinishWithGame:(NRFJeopardyGame *)game;

@end

@interface NRFScoreViewController : UIViewController

@property (strong, nonatomic) id<NRFScoreViewControllerDelegate> delegate;

-(id)initWithGame:(NRFJeopardyGame *)game andQuestion:(NRFQuestion *)question;
-(id)initWithGame:(NRFJeopardyGame *)game inInitializeMode:(BOOL)isInInitializeMode;

@end
