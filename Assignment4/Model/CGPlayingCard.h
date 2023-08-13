// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "CGCard.h"

@interface CGPlayingCard : CGCard

@property (strong ,nonatomic)NSString *suit;
@property (nonatomic)NSUInteger rank;

+ (NSArray *)validSuits;

+ (NSInteger)maxRank;

@end


