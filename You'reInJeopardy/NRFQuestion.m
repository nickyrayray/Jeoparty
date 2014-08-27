//
//  NRFQuestion.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/10/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFQuestion.h"

@implementation NRFQuestion

-(id)init
{
    self = [super init];
    if(self){
        self.chosen = NO;
        self.value = 0;
    }
    return self;
}

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

- (id)initWithValue:(int)value
{
    self = [super init];
    if(self){
        
        self.value = value;
        
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if(self){
        self.value = [[decoder decodeObjectForKey:@"value"] intValue];
        self.chosen = [[decoder decodeObjectForKey:@"chosen"] boolValue];
        self.answer = [decoder decodeObjectForKey:@"answer"];
        self.question = [decoder decodeObjectForKey:@"question"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.question forKey:@"question"];
    [coder encodeObject:self.answer forKey:@"answer"];
    [coder encodeObject:[NSNumber numberWithInt:self.value] forKey:@"value"];
    [coder encodeObject:[NSNumber numberWithBool:self.chosen] forKey:@"chosen"];
}

- (BOOL)isFinished
{
    if([self.question isEqualToString:@""] || [self.answer isEqualToString:@""])
        return NO;
    else if (self.question == nil || self.answer == nil)
        return NO;
    else
        return YES;
}

-(id)copyWithZone:(NSZone *)zone{
    
    int value = self.value;
    BOOL chosen = self.chosen;
    NSString *question = [NSString stringWithString:self.question];
    NSString *answer = [NSString stringWithString:self.answer];
    NRFQuestion *newQuestion = [[NRFQuestion allocWithZone:zone] initQuestion:question withValue:value andAnswer:answer];
    if(newQuestion)
        newQuestion.chosen = chosen;
    return newQuestion;
    
}

@end
