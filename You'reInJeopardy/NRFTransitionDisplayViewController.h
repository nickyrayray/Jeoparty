//
//  NRFTransitionDisplayViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 10/19/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@protocol NRFTransitionDisplayViewControllerDelegate <NSObject>

-(void)transitionDisplayViewControllerDidFinishDisplayingWithType:(int)transitionType;

@end

@interface NRFTransitionDisplayViewController : UIViewController

@property (strong, nonatomic) id<NRFTransitionDisplayViewControllerDelegate> delegate;

-(id)initWithTransitionType:(int)transitionType andMessage:(NSString *)transitionMessage;

@end
