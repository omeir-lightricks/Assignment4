// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "CGDeck.h"

@interface CGDeck()

@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation CGDeck

- (NSMutableArray<CGCard *> *)cards {
  if (!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (void)addCard:(CGCard *)card atTop:(BOOL)atTop {
  if (atTop) {
    [self.cards insertObject:card atIndex:0];
  }
  else {
    [self.cards addObject:card];
  }
}

- (void)addCard:(CGCard *)card {
  [self addCard:card atTop:NO];
}

- (CGCard *)drawRandomCard {
  CGCard *randomCard = nil;

  if ([self.cards count]) {
    unsigned index = arc4random() % [self.cards count];
    randomCard = self.cards[index];
    [self.cards removeObject:randomCard];
  }

  return randomCard;
}


@end


