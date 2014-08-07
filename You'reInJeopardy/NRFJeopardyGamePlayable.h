//
//  NRFJeopardyGamePlayable.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 8/4/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFJeopardyGame.h"
#import "NRFJeopardyGameEditable.h"

@interface NRFJeopardyGamePlayable : NRFJeopardyGame

@property int contestantOneScore;
@property int contestantTwoScore;
@property int contestantThreeScore;
@property NSString *contestantOneName;
@property NSString *contestantTwoName;
@property NSString *contestantThreeName;

-(id)initWithEditableGame:(NRFJeopardyGameEditable *)editableGame;
-(void)incrementQuestionsAnswered;
-(void)incrementDoubleQuestionsAnswered;
-(void)setDailyDoubles;
-(BOOL)dailyDoublesAreSet;
-(BOOL)questionIsDailyDouble:(int)questionIndex forMode:(NSString *)mode;
-(void)addToContestantScore:(int)contestantScore thisAmount:(int)amount;
-(void)subtractFromContestantScore:(int)contestantScore thisAmount:(int)amount;
+(NRFJeopardyGamePlayable *)makeCopyOfGame:(NRFJeopardyGameEditable *)gameToCopy;

@end
