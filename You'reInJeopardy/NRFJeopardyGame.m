//
//  NRFJeopardyGame.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/10/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFJeopardyGame.h"
#import "NRFQuestion.h"

@implementation NRFJeopardyGame

-(id) initWithCategories:(NSArray *)categories forDoubleJ:(BOOL)doubleJ
{
    self = [super init];
    if(self){
        self.categories = categories;
        self.doubleJ = doubleJ;
        
        NSMutableDictionary *questions = [[NSMutableDictionary alloc] init];
        
        for(int i = 0; i < categories.count; i++){
            
            NSMutableArray *category = [[NSMutableArray alloc] initWithCapacity:5];
            [questions setObject:category forKey:categories[i]];
            
        }
        
        self.questions = questions;
    }
    return self;
}

- (void) setQuestion:(NSString *)question withAnswer:(NSString *)answer atIndex:(int)index inCategory:(NSString *)category
{
    
    int value = (index + 1) * 200;
    if(self.doubleJ == YES){
        value *= 2;
    }
    NRFQuestion *questionToAdd = [[NRFQuestion alloc] initQuestion:question withValue:value andAnswer:answer];
    NSMutableArray *qArray = [self.questions objectForKey:category];
    [qArray insertObject:questionToAdd atIndex:index];
    
}

-(void) questionChosenFromCategory:(NSString *)category AtIndex:(int)index
{
    
    NSMutableArray *questions = [self.questions objectForKey:category];
    NRFQuestion *question = questions[index];
    question.chosen = YES;
    
}



@end
