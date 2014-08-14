//
//  NRFFinalJeopartyQuestion.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 8/11/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFFinalJeopartyQuestion.h"

@implementation NRFFinalJeopartyQuestion

-(id)init
{
    self = [super init];
    return self;
}

-(BOOL)finalJeopartyQuestionIsFinished
{
    if([super isFinished] && self.category && ![self.category isEqualToString:@""])
        return YES;
    else
        return NO;
}

@end
