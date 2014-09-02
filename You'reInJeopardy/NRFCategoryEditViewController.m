//
//  NRFCategoryEditViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/12/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFCategoryEditViewController.h"

@interface NRFCategoryEditViewController () <UITextViewDelegate>

@property (strong, nonatomic) UITextView *categoryTextView;
@property (strong, nonatomic) NSString *category;
@property (nonatomic) int index;
@property BOOL mightNeedIncrement;

@end

@implementation NRFCategoryEditViewController

- (id)initWithCat:(NSString *)category atIndex:(int)index;
{
    self = [super init];
    if (self) {
        self.category = category;
        self.index = index;
        if(category && ![category isEqualToString:@""])
            self.mightNeedIncrement = NO;
        else
            self.mightNeedIncrement = YES;
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.categoryTextView = [[UITextView alloc] initWithFrame:CGRectMake(107, 108, 810, 512)];
    self.categoryTextView.textAlignment = NSTextAlignmentCenter;
    self.categoryTextView.font = [UIFont fontWithName:@"Hoefler Text" size:70];
    self.categoryTextView.backgroundColor = [UIColor blueColor];
    self.categoryTextView.textColor = [UIColor whiteColor];
    self.categoryTextView.text = @"Tap to Enter a Category Title";
    self.categoryTextView.delegate = self;
    [self.view addSubview:self.categoryTextView];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    if(![self.category isEqualToString:@""] && self.category){
        self.categoryTextView.text = self.category;
    }
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.title = @"Enter Category Below";
}

- (void)doneButtonPressed:(id)sender {
    
    self.category = self.categoryTextView.text;
    [self.delegate catEditViewController:self didFinishWithCat:self.category forIndex:self.index andMightNeedIncrement:self.mightNeedIncrement];
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"Tap to Enter a Category Title"])
        textView.text = @"";
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@""] || textView.text != nil)
        textView.text = @"Tap to Enter a Category Title";
}

@end
