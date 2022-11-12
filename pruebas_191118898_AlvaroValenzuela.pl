pixrgb( 0, 0, 10, 10, 10, 10, P1), pixrgb( 0, 1, 20, 20, 20, 20, P2), pixrgb( 1, 0, 30, 30, 30, 30, P3), pixrgb( 1, 1, 40, 40, 40, 40, P4), image( 2, 2, [P1, P2, P3, P4], I).

pixbit( 0, 0, 1, 10, PA), pixbit( 0, 1, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsBitmap( I ).

pixhex( 0, 0, "AAAAAA", 10, PA), pixhex( 0, 1, "AAAAAA", 20, PB), pixhex( 1, 0, "AAAAAA", 30, PC), pixhex( 1, 1, "AAAAAA", 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsHexmap( I ).

pixrgb( 0, 0, 1, 2, 3, 10, PA), pixrgb( 0, 1, 1, 2 ,3 , 20, PB), pixrgb( 1, 0, 1, 2, 3, 30, PC), pixrgb( 1, 1, 1,2 , 3, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsPixmap( I ).

pixbit( 0, 0, 1, 10, PA), pixbit( 0, 1, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageFlipH( I , I2 ).

pixbit( 0, 0, 1, 10, PA), pixbit( 0, 1, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageFlipV( I, I2 ).

pixbit(0, 0, 1, 10, P1), pixbit(0, 1, 1, 20, P2), pixbit( 1, 0, 0, 30, P3), pixbit( 1, 1, 0, 40, P4), image( 2, 2, [P1, P2, P3, P4], I), imageCrop( I, 0, 0, 1, 1, Img2).

pixrgb( 0, 0, 10, 10, 10, 10, P1), pixrgb( 0, 1, 20, 20, 20, 20, P2), pixrgb( 1, 0, 30, 30, 30, 30, P3), pixrgb( 1, 1, 40, 40, 40, 40, P4), image( 2, 2,[ P1, P2, P3, P4], I1), imageRGBToHex( I1, I2).

