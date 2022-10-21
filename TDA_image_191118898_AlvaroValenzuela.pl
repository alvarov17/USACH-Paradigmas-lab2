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
  ( Y =< Width - 1 -> NewY = Y - 1 ; NewY = Y + 1),
  pixbit(X, NewY, Bit, Depth, PixelOut).


pixelsFlipH(_, [], []).
pixelsFlipH(Width, [PixelIn | PixelsIn], [PixelOut | PixelsOut]) :-
  pixelFlipH(Width, PixelIn, PixelOut),
  pixelsFlipH(Width, PixelsIn, PixelsOut).


imageFlipH(ImageIn, ImageOut) :-
  image(Width, _, PixelsIn, ImageIn),
  pixelsFlipH(Width, PixelsIn, PixelsOut),
  image(_, _, PixelsOut, ImageOut).

