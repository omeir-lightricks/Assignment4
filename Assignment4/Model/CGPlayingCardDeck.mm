//
//  PlayingCardDeck.m
//
//
//  Created by Ori Meir on 09/08/2023.
//

#import <Foundation/Foundation.h>
#import "CGPlayingCardDeck.h"
#import "CGPlayingCard.h"

@implementation CGPlayingCardDeck : CGDeck

- (instancetype)init {

  self = [super init];
  if (self) {
    for (NSString *suit in [CGPlayingCard validSuits]) {
      for (NSUInteger rank = 1; rank <= [CGPlayingCard maxRank]; rank++) {
        CGPlayingCard *card = [[CGPlayingCard alloc] init];
        card.rank = rank;
        card.suit = suit;
        [self addCard:card];
      }
    }
  }
  return self;
}

@end

