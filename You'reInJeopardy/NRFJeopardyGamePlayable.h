//
//  NRFJeopardyGamePlayable.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 8/4/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFJeopardyGame.h"
#import "NRFJeopardyGameEditable.h"
#import "NRFJeopartyContestant.h"

@interface NRFJeopardyGamePlayable : NRFJeopardyGame

@property (strong, nonatomic) NRFJeopartyContestant *contestantOne;
@property (strong, nonatomic) NRFJeopartyContestant *contestantTwo;
@property (strong, nonatomic) NRFJeopartyContestant *contestantThree;

-(id)initWithEditableGame:(NRFJeopardyGameEditable *)editableGame;
-(void)incrementQuestionsAnswered;
-(void)incrementDoubleQuestionsAnswered;
-(void)setDailyDoubles;
-(BOOL)dailyDoublesAreSet;
-(BOOL)questionIsDailyDouble:(int)questionIndex forMode:(int)mode;
+(NRFJeopardyGamePlayable *)makeCopyOfGame:(NRFJeopardyGameEditable *)gameToCopy;

@end
