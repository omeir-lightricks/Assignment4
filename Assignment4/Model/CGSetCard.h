// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "CGCard.h"

@interface CGSetCard : CGCard

@property (nonatomic)NSInteger shapeIdentifier;

@property (nonatomic)NSInteger colorIdentifier;

@property (nonatomic)NSInteger fillIdentifier;

@property (nonatomic)NSInteger amount;

+ (NSInteger)maxIdentifier;

@end

