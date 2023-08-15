// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import <Foundation/Foundation.h>
#import "CGDeck.h"
#import "CGCard.h"

@interface CGCardMatchEngineGame : NSObject

@property (nonatomic, readonly)NSInteger score;

- (NSMutableArray<CGCard *> *)cards;


- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(CGDeck *)deck;

- (CGCard *)cardAtIndex:(NSUInteger)index;

- (void)setThreeMode:(BOOL)threeMode;

- (NSMutableArray<CGCard *> *)lastCardsChosen;

- (NSInteger)lastPointsChange;

- (void)chooseCardAtIndex:(NSUInteger)index;

- (CGCard *)dealMore:(CGDeck *)deck;



@end


