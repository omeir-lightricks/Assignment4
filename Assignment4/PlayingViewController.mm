// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "PlayingViewController.h"
#import "CGPlayingCardDeck.h"
#import "CGPlayingCard.h"
#import "PlayingCardView.h"


@interface PlayingViewController ()

@end

@implementation PlayingViewController : ViewController

- (cardView *)getNewCardView:(CGPlayingCard *)card {
  PlayingCardView *newView = [[PlayingCardView alloc] init];
  newView.rank = card.rank;
  newView.suit = card.suit;
  newView.chosen = NO;
  return newView;
}

- (void)updateCardState:(CGPlayingCard *)card
                   view:(PlayingCardView *)view {
  view.chosen = card.chosen;
  if (view.faceUp != card.chosen) {
    view.faceUp = !view.faceUp;
    if (view.faceUp) {
      [UIView animateWithDuration:2.0
                       animations:^{[view flip];}];
    }
  }
}

- (CGDeck *)resetDeck {
  return [[CGPlayingCardDeck alloc] init];
}

- (BOOL)isThreeModeOn {
  return NO;
}

- (UIImage *)backgroundImageForCard:(CGCard *)card {
  return [UIImage imageNamed:card.isChosen || card.isMatched  ? @"cardfront" : @"cardback"];
}

@end

