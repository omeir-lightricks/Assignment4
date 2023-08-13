// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "CGSetDeck.h"
#import "CGSetCard.h"

@implementation CGSetDeck

- (instancetype)init {
  self = [super init];

  if (!self) {
    return self;
  }
  
  for (NSAttributedStringKey colorName in [CGSetCard validColors]) {
    for (NSString *shape in [CGSetCard validShapes]) {
      for (NSUInteger amount = 1; amount <= [CGSetCard maxAmountOfShapesInCard]; amount++) {
        CGSetCard *card = [[CGSetCard alloc] init];
        [card setShape:shape];
        [card setColorName:colorName];
        [card setAmount:amount];
        [self addCard:card];

      }
    }
  }

  return self;
}

@end

