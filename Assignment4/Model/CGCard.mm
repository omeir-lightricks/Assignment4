// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "CGCard.h"

@interface CGCard ()

@end

@implementation CGCard

- (int)match:(NSArray *)otherCards {

  int score = 0;

  for (CGCard *card in otherCards) {
    if ([card.contents isEqualToString:self.contents]) {
      score = 1;
    }
  }
  return score;
}

- (void)setIsChosen:(BOOL)isChosen {
  _chosen = isChosen;
}

@end

