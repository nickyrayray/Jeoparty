//
//  NRFQuestion.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/10/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFQuestion.h"

@implementation NRFQuestion

- (id)initQuestion:(NSString *)question withValue:(int)value andAnswer:(NSString *)answer;
{
    self = [super init];
    if(self){
        
        self.question = question;
        self.value = value;
        self.answer = answer;
        self.chosen = NO;
        
    }
    
    return self;
    
}

@end
