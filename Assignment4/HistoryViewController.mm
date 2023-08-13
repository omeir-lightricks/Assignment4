// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "HistoryViewController.h"

@interface HistoryViewController ()

@property (weak, nonatomic) IBOutlet UITextView *historyLabel;

@end

@implementation HistoryViewController

- (void)setHistoryTextArray:(NSMutableArray<NSAttributedString *> *)historyTextArray {
  _historyTextArray = historyTextArray;
  if (self.view.window) {
    [self updateUI];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateUI];
}

- (void)updateUI {
  NSMutableAttributedString *newHistoryText =
  [[NSMutableAttributedString alloc] initWithString:@"History:\n" attributes:@{}];
  for (NSAttributedString *message in _historyTextArray) {
    [newHistoryText appendAttributedString:message];
    [newHistoryText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
  }

  UIFont *font = [UIFont fontWithName:@"Palatino-Roman" size:24.0];

  [newHistoryText addAttributes:@{NSFontAttributeName : font}
                          range:NSMakeRange(0, [newHistoryText length])];

  self.historyLabel.attributedText = newHistoryText;
}

@end


