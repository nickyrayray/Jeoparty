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

-(id)init;
-(void)addQuestionWithValue:(int)value atIndex:(int)index;
-(void)addCategoryAtIndex:(int)index;
-(void)updateCategory:(NSString *)category atIndex:(int)index;
-(void)addDoubleQuestionWithValue:(int)value atIndex:(int)index;
-(void)addDoubleCategoryAtIndex:(int)index;
-(void)updateDoubleCategory:(NSString *)category atIndex:(int)index;
-(BOOL)isDoneWithReg;
-(BOOL)isDoneWithRegRound;
-(BOOL)isDoneWithDouble;
-(BOOL)isDoneWithDoubleRound;
-(NRFQuestion *)getDoubleQuestionAtIndex:(int)index;
-(NRFQuestion *)getQuestionAtIndex:(int)index;
-(NSString *)getCatAtIndex:(int)index;
-(NSString *)getDoubleCatAtIndex:(int)index;

@end
