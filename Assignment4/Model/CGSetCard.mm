// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "CGSetCard.h"

@interface CGSetCard ()


@end

@implementation CGSetCard

+ (NSInteger)maxIdentifier {
  return 3;
}

+ (BOOL)checkIfValuessAreLegalMatch:(NSInteger)valueA
                             valueB:(NSInteger)valueB
                             valueC:(NSInteger)valueC {
  return (valueA == valueB && valueB == valueC) ||
  (valueA != valueB &&
   valueB != valueC &&
   valueA != valueC);
 }

- (void)setFillIdentifier:(NSInteger)fillIdentifier {
  if (fillIdentifier <= [CGSetCard maxIdentifier]) {
    _fillIdentifier = fillIdentifier;
  }
}

- (void)setShapeIdentifier:(NSInteger)shapeIdentifier {
  if (shapeIdentifier <= [CGSetCard maxIdentifier]) {
    _shapeIdentifier = shapeIdentifier;
  }
}

- (void)setColorIdentifier:(NSInteger)colorIdentifier {
  if (colorIdentifier <= [CGSetCard maxIdentifier]) {
    _colorIdentifier = colorIdentifier;
  }
}

- (void)setAmount:(NSInteger)amount {
  if (amount <= [CGSetCard maxIdentifier]) {
    _amount = amount;
  }
}

- (BOOL)isLegalMatch:(NSArray<CGSetCard *> *)otherCards {
  return
    [CGSetCard checkIfValuessAreLegalMatch:otherCards[0].colorIdentifier
                                    valueB:otherCards[1].colorIdentifier
                                    valueC:otherCards[2].colorIdentifier] &&
    [CGSetCard checkIfValuessAreLegalMatch:otherCards[0].amount
                                    valueB:otherCards[1].amount
                                    valueC:otherCards[2].amount] &&
    [CGSetCard checkIfValuessAreLegalMatch:otherCards[0].shapeIdentifier
                                    valueB:otherCards[1].shapeIdentifier
                                    valueC:otherCards[2].shapeIdentifier] &&
    [CGSetCard checkIfValuessAreLegalMatch:otherCards[0].fillIdentifier
                                    valueB:otherCards[1].fillIdentifier
                                    valueC:otherCards[2].fillIdentifier];

}

- (int)match:(NSArray *)otherCards {
  if ([otherCards count] != 2) {
    return 0;
  } else {
    return [self isLegalMatch:otherCards] ? 10 : 0;
  }
}

@end

