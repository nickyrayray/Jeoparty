//
//  NRFInitializerScoreViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 9/1/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFScoreViewController.h"

@protocol NRFInitializerScoreViewControllerProtocol <NSObject>

-(void)initializerScoreViewControllerDidFinishWithGame:(NRFJeopardyGamePlayable *)game;

@end

@interface NRFInitializerScoreViewController : NRFScoreViewController

@property (strong, nonatomic) id<NRFInitializerScoreViewControllerProtocol> delegate;

-(id)initWithGame:(NRFJeopardyGamePlayable *)game;

@end
