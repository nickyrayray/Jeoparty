//
//  NRFJeopardyGame.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/10/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFJeopardyGame.h"

@interface NRFJeopardyGame ()

@end

@implementation NRFJeopardyGame

-(id) init
{
    self = [super init];
    if(self){
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
    [coder encodeObject:self.gameTitle forKey:@"gameTitle"];
    [coder encodeObject:self.gameDescription forKey:@"gameDescription"];
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

-(void)createQuestionArrayWithSize:(NSUInteger)size
{
    NSMutableArray *questions = [[NSMutableArray alloc] initWithCapacity:size];
    NRFQuestion *questionToAdd;
    
    for(int i = 0; i < size; i++){
        questionToAdd = [[NRFQuestion alloc] init];
        [questions addObject:questionToAdd];
    }
    
    self.questions = questions;
}

-(void)createDoubleQuestionArrayWithSize:(NSUInteger)size
{
    NSMutableArray *questions = [[NSMutableArray alloc] initWithCapacity:size];
    NRFQuestion *questionToAdd;
    
    for(int i = 0; i < size; i++){
        questionToAdd = [[NRFQuestion alloc] init];
        [questions addObject:questionToAdd];
    }
    
    self.doubleQuestions = questions;
}

-(void)createCategoryArrayWithSize:(NSUInteger)size
{
    NSMutableArray *cats = [[NSMutableArray alloc] initWithCapacity:size];
    NSString *catToAdd;
    
    for(int i = 0; i < size; i++){
        catToAdd = @"";
        [cats addObject:catToAdd];
    }
    self.categories = cats;
}

-(void)createDoubleCategoryArrayWithSize:(NSUInteger)size
{
    NSMutableArray *cats = [[NSMutableArray alloc] initWithCapacity:size];
    NSString *catToAdd;
    
    for(int i = 0; i < size; i++){
        catToAdd = @"";
        [cats addObject:catToAdd];
    }
    self.doubleCategories = cats;
}

-(BOOL)gameTitleCreated
{
    if(self.gameTitle && ![self.gameTitle isEqualToString:@""])
        return YES;
    else
        return NO;
}

-(BOOL)gameDescriptionCreated
{
    if(self.gameDescription && ![self.gameDescription isEqualToString:@""])
        return YES;
    else
        return NO;
}

@end
