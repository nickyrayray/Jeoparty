//
//  NRFJeopardyGame.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/10/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFJeopardyGame.h"

@implementation NRFJeopardyGame

-(id) init
{
    self = [super init];
    if(self){
        
        self.questions = [[NSMutableArray alloc] init];
        self.doubleQuestions = [[NSMutableArray alloc] init];
        self.categories = [[NSMutableArray alloc] initWithCapacity:6];
        self.doubleCategories = [[NSMutableArray alloc] initWithCapacity:6];
        
    }
    return self;
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




@end
