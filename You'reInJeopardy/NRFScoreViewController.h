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

@end

@interface NRFScoreViewController : UIViewController

-(id)initWithGame:(NRFJeopardyGame *)game andQuestion:(NRFQuestion *)question;
-(id)initWithGame:(NRFJeopardyGame *)game;

@end
