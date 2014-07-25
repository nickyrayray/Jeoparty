//
//  NRFJeopardyGame.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/10/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NRFQuestion.h"

@interface NRFJeopardyGame : NSObject

@property (strong, nonatomic) NSMutableArray *categories;
@property (strong, nonatomic) NSMutableArray *doubleCategories;
@property (strong, nonatomic) NSMutableArray *questions;
@property (strong, nonatomic) NSMutableArray *doubleQuestions;
@property (strong, nonatomic) NSString *gameTitle;
@property (strong, nonatomic) NSString *gameDescription;
@property int contestantOneScore;
@property int contestantTwoScore;
@property int contestantThreeScore;

-(id)init;
-(void)addQuestionWithValue:(int)value atIndex:(int)index;
-(void)addCategoryAtIndex:(int)index;
-(void)updateCategory:(NSString *)category atIndex:(int)index;
-(void)addDoubleQuestionWithValue:(int)value atIndex:(int)index;
-(void)addDoubleCategoryAtIndex:(int)index;
-(void)updateDoubleCategory:(NSString *)category atIndex:(int)index;
-(void)setDailyDoubles;
-(BOOL)dailyDoublesAreSet;
-(BOOL)questionIsDailyDouble:(int)questionIndex forMode:(NSString *)mode;
-(void)addToContestantScore:(int)contestantScore thisAmount:(int)amount;
-(void)subtractFromContestantScore:(int)contestantScore thisAmount:(int)amount;
-(BOOL)isDoneWithReg;
-(BOOL)isDoneWithRegRound;
-(BOOL)isDoneWithDouble;
-(BOOL)isDoneWithDoubleRound;
-(NRFQuestion *)getDoubleQuestionAtIndex:(int)index;
-(NRFQuestion *)getQuestionAtIndex:(int)index;
-(NSString *)getCatAtIndex:(int)index;
-(NSString *)getDoubleCatAtIndex:(int)index;

@end
