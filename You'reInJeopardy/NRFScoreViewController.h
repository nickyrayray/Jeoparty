//
//  NRFScoreViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 7/22/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFJeopardyGamePlayable.h"

@interface NRFScoreViewController : UIViewController

@property (strong, nonatomic)NRFJeopardyGamePlayable *game;

@property (strong, nonatomic) UILabel *contestantOneScore;
@property (strong, nonatomic) UITextView *contestantOneName;

@property (strong, nonatomic) UILabel *contestantTwoScore;
@property (strong, nonatomic) UITextView *contestantTwoName;

@property (strong, nonatomic) UILabel *contestantThreeScore;
@property (strong, nonatomic) UITextView *contestantThreeName;

-(id)initWithGame:(NRFJeopardyGamePlayable *)game;
-(NSString *)stringifyAndAddDollarSignToNumber:(int)number;
-(int)getIntValueFromLabel:(NSString *)labelString;

@end
