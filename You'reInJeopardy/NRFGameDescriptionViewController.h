//
//  NRFGameDescriptionViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 8/26/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFJeopardyGameEditable.h"
#import "NRFTabBarViewController.h"

@interface NRFGameDescriptionViewController : UIViewController

-(id)initWithGame:(NRFJeopardyGameEditable *)game;

@end
