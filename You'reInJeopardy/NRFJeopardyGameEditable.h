//
//  NRFJeopardyGameEditable.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 8/4/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFJeopardyGame.h"

@interface NRFJeopardyGameEditable : NRFJeopardyGame

-(id)init;
-(void)addQuestion:(NRFQuestion *)question atIndex:(int)index;
-(void)addDoubleQuestion:(NRFQuestion *)question atIndex:(int)index;
-(void)addCategory:(NSString *)category atIndex:(int)index;
-(void)addDoubleCategory:(NSString *)category atIndex:(int)index;
-(void)incrementQuestionsEdited;
-(void)decrementQuestionsEdited;
-(void)incrementDoubleQuestionsEdited;
-(void)decrementDoubleQuestionsEdited;
-(void)incrementCategoriesCompleted;
-(void)decrementCategoriesCompleted;
-(void)incrementDoubleCategoriesCompleted;
-(void)decrementDoubleCategoriesCompleted;
-(BOOL)checkForJeopartyGameCompletelyEdited;

@end
