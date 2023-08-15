// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "CGCardMatchEngineGame.h"

@interface CGCardMatchEngineGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray<CGCard *> *cards;
@property (nonatomic) BOOL threeMode;
@property (strong, nonatomic) NSMutableArray<CGCard *> *lastCardsChosen;
@property (nonatomic) NSInteger lastPointsChange;
@end

@implementation CGCardMatchEngineGame

- (NSMutableArray<CGCard *> *)cards {
  if (!_cards) _cards = [[NSMutableArray<CGCard *> alloc] init];
  return _cards;
}

- (void)setThreeMode:(BOOL)threeMode {
  _threeMode = threeMode;
}

- (NSMutableArray<CGCard *> *)lastCardsChosen {
  return _lastCardsChosen;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(CGDeck *)deck {
  self = [super init];

  if (!self) {
    return nil;
  }

  for (int i = 0; i < count; i++) {
    CGCard *card = [deck drawRandomCard];
    if (card) {
      [self.cards addObject:card];
    } else {
      self = nil;
      break;
    }
  }
  return self;
}

- (CGCard *)cardAtIndex:(NSUInteger)index {
  return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)commitChoice:(NSMutableArray<CGCard *> *)chosenCards lastCard:(CGCard *)lastCard {

  self.lastPointsChange = [lastCard match:chosenCards];
  if (self.lastPointsChange >= 0) {
    self.score += self.lastPointsChange;
  }

  _lastCardsChosen = [[NSMutableArray alloc] init];
  [_lastCardsChosen addObject:lastCard];

  for (CGCard * card in chosenCards) {
    card.isChosen = NO;
    card.Matched = self.lastPointsChange > 0;
    [_lastCardsChosen addObject:card];
  }
  lastCard.matched = self.lastPointsChange > 0;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
  CGCard *card = [self cardAtIndex:index];

  if (!card.isMatched) {
    if (card.isChosen) {
      card.chosen = NO;
      return;
    }

    self.score -= 1;
    card.isChosen = YES;

    NSMutableArray<CGCard *> *chosenCards = [[NSMutableArray<CGCard *> alloc] init];
    for (CGCard *otherCard in self.cards) {
      if (otherCard.isChosen && !otherCard.isMatched) {
        [chosenCards addObject:otherCard];
      }
    }
    if ([chosenCards count] == (_threeMode ? 3 : 2)) {
      [chosenCards removeObject:card];
      [self commitChoice:chosenCards lastCard:card];
    }
  }
}

- (CGCard *)dealMore:(CGDeck *)deck {
  CGCard *newCard = [deck drawRandomCard];
  [self.cards addObject:newCard];
  self.score -= 3;
  return newCard;
}

@end


