//
//  NRFJeopardyGame.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/10/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NRFQuestion.h"
#import "NRFFinalJeopartyQuestion.h"
#import "Constants.h"

@interface NRFJeopardyGame : NSObject<NSCoding>

@property (strong, nonatomic) NSMutableArray *categories;
@property (strong, nonatomic) NSMutableArray *doubleCategories;
@property (strong, nonatomic) NSMutableArray *questions;
@property (strong, nonatomic) NSMutableArray *doubleQuestions;
@property (strong, nonatomic) NRFFinalJeopartyQuestion *finalJeopartyQuestion;
@property (strong, nonatomic) NSString *gameTitle;
@property (strong, nonatomic) NSString *gameDescription;
@property int maxQuestionCount;
@property int maxCategoryCount;


-(id)init;
-(NRFQuestion *)getDoubleQuestionAtIndex:(int)index;
-(NRFQuestion *)getQuestionAtIndex:(int)index;
-(NSString *)getCatAtIndex:(int)index;
-(NSString *)getDoubleCatAtIndex:(int)index;
-(void)createQuestionArrayWithSize:(NSUInteger)size;
-(void)createDoubleQuestionArrayWithSize:(NSUInteger)size;
-(void)createCategoryArrayWithSize:(NSUInteger)size;
-(void)createDoubleCategoryArrayWithSize:(NSUInteger)size;
-(BOOL)gameTitleCreated;
-(BOOL)gameDescriptionCreated;

@end
