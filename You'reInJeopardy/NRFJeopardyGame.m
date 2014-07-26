//
//  NRFJeopardyGame.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/10/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFJeopardyGame.h"

@interface NRFJeopardyGame ()

@property int regDailyDouble;
@property int doubleDailyDouble1;
@property int doubleDailyDouble2;

@end

@implementation NRFJeopardyGame

-(id) init
{
    self = [super init];
    if(self){
        
        self.questions = [[NSMutableArray alloc] init];
        self.doubleQuestions = [[NSMutableArray alloc] init];
        self.categories = [[NSMutableArray alloc] initWithCapacity:6];
        self.doubleCategories = [[NSMutableArray alloc] initWithCapacity:6];
        self.regDailyDouble = -1;
        self.doubleDailyDouble1 = -1;
        self.doubleDailyDouble2 = -1;
        self.contestantOneScore = 0;
        self.contestantTwoScore = 0;
        self.contestantThreeScore = 0;
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    
    if(self){
        
        self.questions = [[NSMutableArray alloc] initWithArray:[decoder decodeObjectForKey:@"questions"] copyItems:YES];
        self.doubleQuestions = [[NSMutableArray alloc] initWithArray:[decoder decodeObjectForKey:@"doubleQuestions"] copyItems:YES];
        self.categories = [[NSMutableArray alloc] initWithArray:[decoder decodeObjectForKey:@"categories"] copyItems:YES];
        self.doubleCategories = [[NSMutableArray alloc] initWithArray:[decoder decodeObjectForKey:@"doubleCategories"] copyItems:YES];
        self.regDailyDouble = [[decoder decodeObjectForKey:@"regDailyDouble"] intValue];
        self.doubleDailyDouble1 = [[decoder decodeObjectForKey:@"doubleDailyDouble1"] intValue];
        self.doubleDailyDouble2 = [[decoder decodeObjectForKey:@"doubleDailyDouble2"] intValue];
        self.contestantOneScore = [[decoder decodeObjectForKey:@"contestantOneScore"] intValue];
        self.contestantTwoScore = [[decoder decodeObjectForKey:@"contestantTwoScore"] intValue];
        self.contestantThreeScore = [[decoder decodeObjectForKey:@"contestantThreeScore"] intValue];
        self.contestantOneName = [decoder decodeObjectForKey:@"contestantOneName"];
        self.contestantTwoName = [decoder decodeObjectForKey:@"contestantTwoName"];
        self.contestantThreeName = [decoder decodeObjectForKey:@"contestantThreeName"];
        self.gameTitle = [decoder decodeObjectForKey:@"gameTitle"];
        self.gameDescription = [decoder decodeObjectForKey:@"gameDescription"];
        
    }
    
    return self;
    
}

-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.questions forKey:@"questions"];
    [coder encodeObject:self.doubleQuestions forKey:@"doubleQuestions"];
    [coder encodeObject:self.categories forKey:@"categories"];
    [coder encodeObject:self.doubleCategories forKey:@"doubleCategories"];
    [coder encodeObject:[NSNumber numberWithInt:self.regDailyDouble] forKey:@"regDailyDouble"];
    [coder encodeObject:[NSNumber numberWithInt:self.doubleDailyDouble1] forKey:@"doubleDailyDouble1"];
    [coder encodeObject:[NSNumber numberWithInt:self.doubleDailyDouble2] forKey:@"doubleDailyDouble2"];
    [coder encodeObject:[NSNumber numberWithInt:self.contestantOneScore] forKey:@"contestantOneScore"];
    [coder encodeObject:[NSNumber numberWithInt:self.contestantTwoScore] forKey:@"contestantTwoScore"];
    [coder encodeObject:[NSNumber numberWithInt:self.contestantThreeScore] forKey:@"contestantThreeScore"];
    [coder encodeObject:self.contestantOneName forKey:@"contestantOneName"];
    [coder encodeObject:self.contestantTwoName forKey:@"contestantTwoName"];
    [coder encodeObject:self.contestantThreeName forKey:@"contestantThreeName"];
    [coder encodeObject:self.gameTitle forKey:@"gameTitle"];
    [coder encodeObject:self.gameDescription forKey:@"gameDescription"];
}

-(void) addQuestionWithValue:(int)value atIndex:(int)index
{
    
    NRFQuestion *questionToAdd = [[NRFQuestion alloc] initWithValue:value];
    [self.questions insertObject:questionToAdd atIndex:index];
    
}

-(void) addCategoryAtIndex:(int)index
{
    NSString *placeHolder = [[NSString alloc] init];
    [self.categories insertObject:placeHolder atIndex:index];
    
}

-(void) updateCategory:(NSString *)category atIndex:(int)index
{
    self.categories[index] = category;
}

-(void) addDoubleQuestionWithValue:(int)value atIndex:(int)index
{
    
    NRFQuestion *questionToAdd = [[NRFQuestion alloc] initWithValue:value];
    [self.doubleQuestions insertObject:questionToAdd atIndex:index];
    
}

-(void) addDoubleCategoryAtIndex:(int)index
{
    NSString *placeHolder = [[NSString alloc] init];
    [self.doubleCategories insertObject:placeHolder atIndex:index];
}

-(void) updateDoubleCategory:(NSString *)category atIndex:(int)index
{
    self.doubleCategories[index] = category;
}

-(NRFQuestion *) getQuestionAtIndex:(int)index
{
    return self.questions[index];
}

-(NRFQuestion *) getDoubleQuestionAtIndex:(int)index
{
    return self.doubleQuestions[index];
}

-(NSString *)getCatAtIndex:(int)index
{
    return self.categories[index];
}

-(NSString *)getDoubleCatAtIndex:(int)index
{
    return self.doubleCategories[index];
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

-(BOOL)questionIsDailyDouble:(int)questionIndex forMode:(NSString *)mode
{
    
    if([mode isEqualToString:@"regJ"]){
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

-(void)addToContestantScore:(int)contestantScore thisAmount:(int)amount
{
    contestantScore += amount;
}

-(void)subtractFromContestantScore:(int)contestantScore thisAmount:(int)amount
{
    contestantScore -= amount;
}

- (BOOL)isDoneWithReg
{
    
    for(NRFQuestion *question in self.questions){
        if(![question isFinished])
            return NO;
    }
    
    for(NSString *category in self.categories){
        if(category == nil || [category isEqualToString:@""])
            return NO;
    }
    
    return YES;
    
}

-(BOOL)isDoneWithRegRound
{
    for(NRFQuestion *question in self.questions){
        if(question.chosen == NO)
            return NO;
    }
    
    return YES;
}

-(BOOL)isDoneWithDouble
{
    
    for(NRFQuestion *question in self.doubleQuestions){
        if(![question isFinished])
            return NO;
    }
    
    for(NSString *category in self.doubleCategories){
        if(category == nil || [category isEqualToString:@""])
            return NO;
    }
    
    return YES;
    
}

-(BOOL)isDoneWithDoubleRound
{
    for(NRFQuestion *question in self.doubleQuestions){
        if(question.chosen == NO)
            return NO;
    }
    
    return YES;
}

+(NRFJeopardyGame *)makeCopyOfGame:(NRFJeopardyGame *)gameToCopy
{
    NRFJeopardyGame *playableGame = [[NRFJeopardyGame alloc] init];
    playableGame.categories = [[NSMutableArray alloc] initWithArray:gameToCopy.categories copyItems:YES];
    playableGame.doubleCategories = [[NSMutableArray alloc] initWithArray:gameToCopy.doubleCategories copyItems:YES];
    playableGame.questions = [[NSMutableArray alloc] initWithArray:gameToCopy.questions copyItems:YES];
    playableGame.doubleQuestions = [[NSMutableArray alloc] initWithArray:gameToCopy.doubleQuestions copyItems:YES];
    playableGame.gameDescription = [NSString stringWithString:gameToCopy.gameDescription];
    playableGame.gameTitle = [NSString stringWithString:gameToCopy.gameTitle];
    return playableGame;
}




@end
