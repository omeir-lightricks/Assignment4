// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "CGCard.h"

@interface CGSetCard : CGCard

@property (strong, nonatomic)NSString *shape;

@property (strong, nonatomic)NSAttributedStringKey colorName;

@property (nonatomic) NSInteger amount;

- (void)setAmount:(NSInteger)amount;

- (void)setColorName:(NSAttributedStringKey)colorName;

- (void)setShape:(NSString *)shape;

+ (NSArray<NSAttributedStringKey> *)validColors;

+ (NSArray<NSString *> *)validShapes;

+ (NSInteger)maxAmountOfShapesInCard;

@end

