// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "CGSetCard.h"

@interface CGSetCard ()


@end

@implementation CGSetCard

+ (NSArray<NSAttributedStringKey> *)validColors {
  return @[@"black", @"red", @"blue"];
}

+ (NSArray<NSString *> *)validShapes {
  return @[@"▲", @"●", @"■"];
}

+ (NSInteger)maxAmountOfShapesInCard {
  return 3;
}

+ (BOOL)checkIfStringValuessAreLegalMatch:(NSString *)stringA
                                  StringB:(NSString *)StringB
                                  StringC:(NSString *)StringC {
  return ([stringA isEqualToString:StringB] && [StringB isEqualToString:StringC]) ||
  (![stringA isEqualToString:StringB] &&
   ![stringA isEqualToString:StringC] &&
   ![StringB isEqualToString:StringC]);
}

+ (BOOL)checkIfAmountValuessAreLegalMatch:(NSInteger)amountA
                                     amountB:(NSInteger)amountB
                                  amountC:(NSInteger)amountC {
  return (amountA == amountB && amountB == amountC) ||
  (amountA != amountB &&
   amountB != amountC &&
   amountA != amountC);
 }

- (void)setShape:(NSString *)shape {
  if ([[CGSetCard validShapes] containsObject:shape]) {
    _shape = shape;
  }
}

- (void)setColorName:(NSAttributedStringKey)colorName {
  if ([[CGSetCard validColors] containsObject:colorName]) {
    _colorName = colorName;
  }
}

- (void)setAmount:(NSInteger)amount {
  if (amount <= [CGSetCard maxAmountOfShapesInCard]) {
    _amount = amount;
  }
}


- (BOOL)isLegalMatch:(NSArray<CGSetCard *> *)otherCards {
  return
    [CGSetCard checkIfStringValuessAreLegalMatch:_shape
                                              StringB:otherCards[0].shape
                                              StringC:otherCards[1].shape] &&
    [CGSetCard checkIfStringValuessAreLegalMatch:_colorName
                                            StringB:otherCards[0].colorName
                                            StringC:otherCards[1].colorName] &&
    [CGSetCard checkIfAmountValuessAreLegalMatch:_amount
                                         amountB:otherCards[0].amount
                                         amountC:otherCards[1].amount];
}

- (int)match:(NSArray *)otherCards {
  if ([otherCards count] != 2) {
    return 0;
  } else {
    return [self isLegalMatch:otherCards] ? 10 : 0;
  }
}

@end

