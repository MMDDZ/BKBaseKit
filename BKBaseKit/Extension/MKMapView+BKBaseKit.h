//
//  MKMapView+BKBaseKit.h
//  BKUIKit
//
//  Created by zhaolin on 2019/10/28.
//  Copyright © 2019 BIKE. All rights reserved.
//

#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMapView (BKBaseKit)

/**
 设置中心

 @param centerCoordinate 中心
 @param zoomLevel 缩放级别
 @param animated 是否动画
 */
-(void)BK_setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate zoomLevel:(NSUInteger)zoomLevel animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
