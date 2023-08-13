// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "CGPlayingCard.h"

@interface CGPlayingCard()

@end

@implementation CGPlayingCard

@synthesize suit = _suit;

- (NSString *)contents {
  NSArray *rankStrings = @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
  return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSInteger)maxRank {
  return 13;
}


+ (NSArray *)validSuits {
  return @[@"♥" ,@"♦", @"♠" ,@"♣"];
}

- (void)setSuit:(NSString *)suit
{
  if ([[CGPlayingCard validSuits] containsObject:suit]) {
    _suit = suit;
  }
}

- (NSString *)suit
{
  return _suit ? _suit : @"?";
}

- (int)match:(NSArray *)otherCards {

  int score = 0;

  if ([otherCards count] != 1) {
    return score;
  }

  CGPlayingCard *otherCard = otherCards[0];

  if (otherCard.rank == self.rank) {
    score = 9;
  }
  if ([otherCard.suit isEqualToString:self.suit])
  {
    score = 3;
  }

  return score;
}

@end



