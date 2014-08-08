//
//  NRFCategoryEditViewController.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/12/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NRFCategoryEditViewController;

@protocol NRFCategoryEditViewControllerDelegate <NSObject>

-(void)catEditViewController:(NRFCategoryEditViewController *)catEditVC didFinishWithCat:(NSString *)category forIndex:(int)index andMightNeedIncrement:(BOOL)mightNeedIncrement;

@end

@interface NRFCategoryEditViewController : UIViewController

@property (nonatomic) id<NRFCategoryEditViewControllerDelegate> delegate;

-(id)initWithCat:(NSString *)category atIndex:(int)index;

@end
