//
//  NRFTabBarViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 7/31/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFMainMenuViewController.h"
#import "NRFJeopardyGame.h"
#import "NRFMainBoardViewController.h"

@protocol NRFTabBarViewControllerDelegate <NSObject>

-(void)tabBarViewControllerDidFinishWithEditedGame:(NRFJeopardyGameEditable *)game;

@end

@interface NRFTabBarViewController : UITabBarController

@property (strong, nonatomic) id<NRFTabBarViewControllerDelegate> myDelegate;

-(id)init;
-(void)gameIsCompletelyEdited;
-(void)gameIsNoLongerCompletelyEdited;

@end
