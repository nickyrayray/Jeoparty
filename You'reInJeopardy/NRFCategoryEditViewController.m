//
//  NRFCategoryEditViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/12/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFCategoryEditViewController.h"

@interface NRFCategoryEditViewController ()
@property (weak, nonatomic) IBOutlet UITextView *categoryTextView;
@property (strong, nonatomic) NSString *category;
@property (nonatomic) int index;

@end

@implementation NRFCategoryEditViewController

- (id)initWithCat:(NSString *)category atIndex:(int)index;
{
    self = [super initWithNibName:@"NRFCategoryEditViewController" bundle:nil];
    if (self) {
        self.category = category;
        self.index = index;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(![self.category isEqualToString:@""] && self.category != nil){
        self.categoryTextView.text = self.category;
    }
}

- (IBAction)doneButtonPressed:(UIButton *)sender {
    
    self.category = self.categoryTextView.text;
    [self.delegate catEditViewController:self didFinishWithCat:self.category forIndex:self.index];
    
}

@end