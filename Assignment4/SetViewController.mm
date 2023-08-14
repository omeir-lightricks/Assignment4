// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "SetViewController.h"
#import "CGSetDeck.h"
#import "CGSetCard.h"
#import "SetCardView.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (CGDeck *)resetDeck {
  return [[CGSetDeck alloc] init];
}

- (cardView *)getNewCardView:(CGSetCard *)card {
  SetCardView *newView = [[SetCardView alloc] init];
  newView.shapeIdentifier = card.shapeIdentifier;
  newView.colorIdentifier = card.colorIdentifier;
  newView.fillIdentifier = card.fillIdentifier;
  newView.amount = card.amount;
  newView.chosen = NO;
  return newView;
}

- (BOOL)isThreeModeOn {
  return YES;
}

@end

