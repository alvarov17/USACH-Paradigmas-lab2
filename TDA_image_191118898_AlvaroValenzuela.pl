/* TDA PIXBIT

Dominio:
  X: Int
  T: Int
  Bit: Int {0, 1}
  Depth: Int{0, 1 ... 255}
  pixbit: List

Predicados:
  pixbit(X, Y, Bit, Depth, [X, Y, Bit, Depth]) (Aridad = 5)

*/

% Constructor y Pertenencia
pixbit(X, Y, Bit, Depth, [X, Y, Bit, Depth]) :- Bit >= 0, Bit =< 1.

pixrgb(X, Y, Red, Green, Blue, Depth, [X, Y, Red, Green, Blue, Depth]) :- 
  Red >= 0, Red =< 255, Green >= 0, Green =< 255, Blue >= 0, Blue =< 255.

pixhex(X, Y, Hex, Depth, [X, Y, Hex, Depth]) :- string(Hex).

image(W, H, P, [W, H, P]).

pixelsArePixbits([]).
pixelsArePixbits([Head | Tail]) :- 
  pixbit(_, _, Bit, _, Head),
  (Bit == 1 ; Bit == 0),
  pixelsArePixbits(Tail).

pixelsArePixhexs([]).
pixelsArePixhexs([Head | Tail]) :-
  pixhex(_, _, Hex, _, Head),
  string(Hex),
  pixelsArePixhexs(Tail).

pixelsArePixrgb([]).
pixelsArePixrgb([Head | Tail]) :-
  pixrgb(_, _, Red, Green, Blue, _, Head),
  Red >= 0, Red =< 255, Green >= 0, Green =< 255, Blue >= 0, Blue =< 255,
  pixelsArePixrgb(Tail).

imageIsBitmap(I) :-
  image(_, _, Pixels, I),
  pixelsArePixbits(Pixels).

imageIsPixmap(I) :-
  image(_, _, Pixels, I),
  pixelsArePixhexs(Pixels). 

imageIsHexmap(I) :-
  image(_, _, Pixels, I),
  pixelsArePixrgb(Pixels). 

pixelFlipH(Width, PixelIn, PixelOut) :-
  pixbit(X, Y, Bit, Depth, PixelIn),
  ( Y is Width - 1 -> NewY is Y - 1 ; NewY is Y + 1),
  pixbit(X, NewY, Bit, Depth, PixelOut).

pixelFlipV(Height, PixelIn, PixelOut) :-
  pixbit(X, Y, Bit, Depth, PixelIn),
  ( X is Height - 1 -> NewX is X - 1 ; NewX is X + 1),
  pixbit(Y, NewX, Bit, Depth, PixelOut).


pixelsFlipH(_, [], []).
pixelsFlipH(Width, [PixelIn | PixelsIn], [PixelOut | PixelsOut]) :-
  pixelFlipH(Width, PixelIn, PixelOut),
  pixelsFlipH(Width, PixelsIn, PixelsOut).

pixelsFlipV(_, [], []).
pixelsFlipV(Height, [PixelIn | PixelsIn], [PixelOut | PixelsOut]) :-
  pixelFlipV(Height, PixelIn, PixelOut),
  pixelsFlipV(Height, PixelsIn, PixelsOut).


imageFlipH(ImageIn, ImageOut) :-
  image(Width, _, PixelsIn, ImageIn),
  pixelsFlipH(Width, PixelsIn, PixelsOut),
  image(_, _, PixelsOut, ImageOut).


imageFlipV(ImageIn, ImageOut) :-
  image(_, Height, PixelsIn, ImageIn),
  pixelsFlipV(Height, PixelsIn, PixelsOut),
  image(_, _, PixelsOut, ImageOut).

cropPixel(PixelIn, X1, Y1, X2, Y2, PixelOut) :-
    pixbit(X, Y, Bit, Depth, PixelIn), 
    (   X >= X1,
    	X =< X2,
    	Y >= Y1,
    	Y =< Y2 ->  pixbit(X, Y, Bit, Depth, PixelOut) ; true).

cropPixels([], _, _, _, _, []).
cropPixels([PixelIn | PixelsIn], X1, Y1, X2, Y2, [PixelOut | PixelsOut]) :-
    cropPixel(PixelIn, X1, Y1, X2, Y2, PixelOut),
    cropPixels(PixelsIn, X1, Y1, X2, Y2, PixelsOut).

imageCrop(ImageIn, X1, Y1, X2, Y2, ImageOut) :-
    image(Width, Height, PixelsIn, ImageIn),
    cropPixels(PixelsIn, X1, Y1, X2, Y2, PixelsOut),
    image(Width, Height, PixelsOut, ImageOut).
    

