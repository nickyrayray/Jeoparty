//
//  NRFJeopardyGamePlayable.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 8/4/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFJeopardyGamePlayable.h"

@interface NRFJeopardyGamePlayable ()

@property int questionsAnswered;
@property int doubleQuestionsAnswered;
@property BOOL regularJeopartyCompletelyPlayed;
@property BOOL doubleJeopartyCompletelyPlayed;
@property int regDailyDouble;
@property int doubleDailyDouble1;
@property int doubleDailyDouble2;


@end

@implementation NRFJeopardyGamePlayable

-(id)initWithEditableGame:(NRFJeopardyGameEditable *)editableGame
{
    self = [super init];
    if(self){
        
        self.questionsAnswered = 0;
        self.doubleQuestionsAnswered = 0;
        self.regularJeopartyCompletelyPlayed = NO;
        self.doubleJeopartyCompletelyPlayed = NO;
        self.regDailyDouble = -1;
        self.doubleDailyDouble1 = -1;
        self.doubleDailyDouble2 = -1;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)decoder
{
    
    self = [super initWithCoder:decoder];
    if(self){
        
        self.regDailyDouble = [[decoder decodeObjectForKey:@"regDailyDouble"] intValue];
        self.doubleDailyDouble1 = [[decoder decodeObjectForKey:@"doubleDailyDouble1"] intValue];
        self.doubleDailyDouble2 = [[decoder decodeObjectForKey:@"doubleDailyDouble2"] intValue];
        self.contestantOne = [decoder decodeObjectForKey:@"contestantOne"];
        self.contestantTwo = [decoder decodeObjectForKey:@"contestantTwo"];
        self.contestantThree = [decoder decodeObjectForKey:@"contestantThree"];
    }
        
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder:coder];
    [coder encodeObject:[NSNumber numberWithInt:self.regDailyDouble] forKey:@"regDailyDouble"];
    [coder encodeObject:[NSNumber numberWithInt:self.doubleDailyDouble1] forKey:@"doubleDailyDouble1"];
    [coder encodeObject:[NSNumber numberWithInt:self.doubleDailyDouble2] forKey:@"doubleDailyDouble2"];
    [coder encodeObject:self.contestantOne forKey:@"contestantOne"];
    [coder encodeObject:self.contestantTwo forKey:@"contestantTwo"];
    [coder encodeObject:self.contestantThree forKey:@"contestantThree"];
}

-(void)incrementQuestionsAnswered
{
    self.questionsAnswered++;
    if(self.questionsAnswered == self.maxQuestionCount)
        self.regularJeopartyCompletelyPlayed = YES;
}

-(void)incrementDoubleQuestionsAnswered
{
    self.doubleQuestionsAnswered++;
    if(self.doubleQuestionsAnswered == self.maxQuestionCount)
        self.doubleJeopartyCompletelyPlayed = YES;
}

-(void)setDailyDoubles{
    
    self.regDailyDouble = arc4random() % [self.questions count];
    self.doubleDailyDouble1 = arc4random() % [self.doubleQuestions count];
    do {
        
        self.doubleDailyDouble2 = arc4random() % [self.doubleQuestions count];
        
    } while(self.doubleDailyDouble2 == self.doubleDailyDouble1);
    
}

-(BOOL) dailyDoublesAreSet{
    if(self.regDailyDouble != -1 && self.doubleDailyDouble1 != -1 && self.doubleDailyDouble2 != -1)
        return YES;
    else
        return NO;
}

-(BOOL)questionIsDailyDouble:(int)questionIndex forMode:(int)mode
{
    
    if(mode == REGULAR_JEOPARDY_PLAY){
        if(questionIndex == self.regDailyDouble)
            return YES;
        else
            return NO;
    } else {
        if(questionIndex == self.doubleDailyDouble1 || questionIndex == self.doubleDailyDouble2)
            return YES;
        else
            return NO;
    }
}

-(BOOL)regularJeopartyIsCompletelyPlayed{
    if(self.regularJeopartyCompletelyPlayed)
        return YES;
    else
        return NO;
}

-(BOOL)doubleJeopartyIsCompletelyPlayed{
    if(self.doubleJeopartyCompletelyPlayed)
        return YES;
    else
        return NO;
}

+(NRFJeopardyGamePlayable *)makeCopyOfGame:(NRFJeopardyGameEditable *)gameToCopy
{
    NRFJeopardyGamePlayable *playableGame = [[NRFJeopardyGamePlayable alloc] init];
    playableGame.categories = [[NSMutableArray alloc] initWithArray:gameToCopy.categories copyItems:YES];
    playableGame.doubleCategories = [[NSMutableArray alloc] initWithArray:gameToCopy.doubleCategories copyItems:YES];
    playableGame.questions = [[NSMutableArray alloc] initWithArray:gameToCopy.questions copyItems:YES];
    playableGame.doubleQuestions = [[NSMutableArray alloc] initWithArray:gameToCopy.doubleQuestions copyItems:YES];
    playableGame.gameDescription = [NSString stringWithString:gameToCopy.gameDescription];
    playableGame.gameTitle = [NSString stringWithString:gameToCopy.gameTitle];
    playableGame.maxQuestionCount = gameToCopy.maxQuestionCount;
    playableGame.maxCategoryCount = gameToCopy.maxCategoryCount;
    return playableGame;
}



@end
