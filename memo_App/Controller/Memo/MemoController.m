//
//  MemoController.m
//  memo_App
//
//  Created by kawaharadai on 2017/11/12.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "MemoController.h"
#import "Memo.h"
#import "DatabaseClient.h"

@interface MemoController ()
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

@end

@implementation MemoController

#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    NSString *homeDirectory = NSHomeDirectory();
    NSLog(@"%@", homeDirectory);
}

#pragma mark - SetUp Methods
- (void)setup {
    [self setupBarButton];
    [self setupTextView];
}

- (void)setupBarButton {
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]  initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                     target:self
                                                                                     action:@selector(saveMemo)];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)setupTextView {
    [self.inputTextView becomeFirstResponder];
    if (self.memoData) {
        self.inputTextView.text = self.memoData.text;
    } else {
        self.inputTextView.text = @"";
    }
}

#pragma mark - Private Methods
- (void)saveMemo {
    if ([self isEmptyInputText]) {
        [self.navigationController popViewControllerAnimated:true];
        return;
    }
    
    if (self.memoData) {
        self.memoData.text = self.inputTextView.text;
        self.memoData.updateDate = [NSDate date];
        [DatabaseClient update:self.memoData];
    } else {
        Memo *saveData = [Memo new];
        saveData.text = self.inputTextView.text;
        saveData.updateDate = [NSDate date];
        [DatabaseClient insert:saveData];
    }
    
    [self.navigationController popViewControllerAnimated:true];
}

- (BOOL)isEmptyInputText {
    if (self.inputTextView.text.length <= 0) {
        return YES;
    } else {
        return NO;
    }
}
@end
