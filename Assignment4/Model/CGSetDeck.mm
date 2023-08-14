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
  
  for (NSUInteger amount = 1; amount <= [CGSetCard maxIdentifier]; amount++) {
    for (NSUInteger colorIdentifier = 1; colorIdentifier <= [CGSetCard maxIdentifier]; colorIdentifier++) {
      for (NSUInteger shapeIdentifier = 1; shapeIdentifier <= [CGSetCard maxIdentifier]; shapeIdentifier++) {
        for (NSUInteger fillIdentifier = 1; fillIdentifier <= [CGSetCard maxIdentifier]; fillIdentifier++) {

          CGSetCard *card = [[CGSetCard alloc] init];
          [card setShapeIdentifier:shapeIdentifier];
          [card setColorIdentifier:colorIdentifier];
          [card setAmount:amount];
          [card setFillIdentifier:fillIdentifier];
          [self addCard:card];
          
        }

      }
    }
  }

  return self;
}

@end

