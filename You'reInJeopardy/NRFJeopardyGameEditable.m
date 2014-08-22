//
//  NRFJeopardyGameEditable.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 8/4/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFJeopardyGameEditable.h"

@interface NRFJeopardyGameEditable ()

@property int questionsEdited;
@property int doubleQuestionsEdited;
@property int categoriesCreated;
@property int doubleCategoriesCreated;
@property BOOL regularJeopartyCompletelyEdited;
@property BOOL doubleJeopartyCompletelyEdited;
@property BOOL finalJeopartyCompletelyEdited;

@end

@implementation NRFJeopardyGameEditable

-(id)init
{
    self = [super init];
    if(self){
        
        self.questionsEdited = 0;
        self.doubleQuestionsEdited = 0;
        self.categoriesCreated = 0;
        self.doubleCategoriesCreated = 0;
        self.regularJeopartyCompletelyEdited = NO;
        self.doubleJeopartyCompletelyEdited = NO;

    }
    
    return self;
}

-(void)addQuestion:(NRFQuestion *)question atIndex:(int)index
{
    self.questions[index] = question;
}

-(void)addDoubleQuestion:(NRFQuestion *)question atIndex:(int)index
{
    self.doubleQuestions[index] = question;
}

-(void)incrementQuestionsEdited
{
    self.questionsEdited++;
    if(self.questionsEdited == self.maxQuestionCount && self.categoriesCreated == self.maxCategoryCount)
        self.regularJeopartyCompletelyEdited = YES;
}

-(void)decrementQuestionsEdited
{
    if(self.questionsEdited == self.maxQuestionCount && self.categoriesCreated == self.maxCategoryCount)
        self.regularJeopartyCompletelyEdited = NO;
    self.questionsEdited--;
}


-(void)incrementDoubleQuestionsEdited
{
    self.doubleQuestionsEdited++;
    if(self.doubleQuestionsEdited == self.maxQuestionCount && self.doubleCategoriesCreated == self.maxCategoryCount)
        self.doubleJeopartyCompletelyEdited = YES;
}

-(void)decrementDoubleQuestionsEdited
{
    if(self.doubleQuestionsEdited == self.maxQuestionCount && self.doubleCategoriesCreated == self.maxCategoryCount)
        self.doubleJeopartyCompletelyEdited = NO;
    self.doubleQuestionsEdited--;
}


-(void)incrementCategoriesCompleted
{
    self.categoriesCreated++;
    if(self.categoriesCreated == self.maxCategoryCount && self.questionsEdited == self.maxQuestionCount)
        self.regularJeopartyCompletelyEdited = YES;
    
}

-(void)decrementCategoriesCompleted
{
    if(self.categoriesCreated == self.maxCategoryCount && self.questionsEdited == self.maxQuestionCount)
        self.regularJeopartyCompletelyEdited = YES;
    self.categoriesCreated--;
}

-(void)incrementDoubleCategoriesCompleted
{
    self.doubleCategoriesCreated++;
    if(self.doubleCategoriesCreated == self.maxCategoryCount && self.doubleQuestionsEdited == self.maxQuestionCount)
        self.doubleJeopartyCompletelyEdited = YES;
}

-(void)decrementDoubleCategoriesCompleted
{
    if(self.doubleCategoriesCreated == self.maxCategoryCount && self.doubleQuestionsEdited == self.maxQuestionCount)
        self.doubleJeopartyCompletelyEdited = YES;
    self.doubleCategoriesCreated--;
}

-(void)addCategory:(NSString *)category atIndex:(int)index
{
    self.categories[index] = category;
}

-(void)addDoubleCategory:(NSString *)category atIndex:(int)index
{
    self.doubleCategories[index] = category;
}

-(BOOL)checkForJeopartyGameCompletelyEdited
{
    if(self.regularJeopartyCompletelyEdited && self.doubleJeopartyCompletelyEdited && [[super finalJeopartyQuestion] finalJeopartyQuestionIsFinished])
        return YES;
    else
        return NO;
}



@end
