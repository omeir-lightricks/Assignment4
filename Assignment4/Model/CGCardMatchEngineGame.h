// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import <Foundation/Foundation.h>
#import "CGDeck.h"
#import "CGCard.h"

@interface CGCardMatchEngineGame : NSObject

@property (nonatomic, readonly)NSInteger score;

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(CGDeck *)deck;

- (CGCard *)cardAtIndex:(NSUInteger)index;

- (void)setThreeMode:(BOOL)threeMode;

- (NSMutableArray<CGCard *> *)lastCardsChosen;

- (NSInteger)lastPointsChange;
//  Executes user choise of any card
- (void)chooseCardAtIndex:(NSUInteger)index;




@end


