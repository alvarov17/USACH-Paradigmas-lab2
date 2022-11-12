dec_hex(1, "1").
dec_hex(2, "2").
dec_hex(3, "3").
dec_hex(4, "4").
dec_hex(5, "5").
dec_hex(6, "6").
dec_hex(7, "7").
dec_hex(8, "8").
dec_hex(9, "9").
dec_hex(10, "A").
dec_hex(11, "B").
dec_hex(12, "C").
dec_hex(13, "D").
dec_hex(14, "E").
dec_hex(15, "F").
dec_hex(D, H) :-
    X is D mod 16,
    Y is D//16,
    dec_hex(Y, FirstHex), 
    dec_hex(X, LastHex),
    atom_concat(FirstHex, LastHex, H).


%  --------------------------------------- TDA PIXBIT ----------------------------------------------
% Dominio:
% X, Y, Bit, Depth: Integer
% 
% Predicados:
% pixbit(X, Y, Bit, Depth, [X, Y, Bit, Depth]) (Aridad = 5)
% getBit([_, _, Bit,_], Bit) (Aridad = 2)
% 
%  --------------------------------------- Representación ------------------------------------------
% Lista que contendrá X, Y, Bit y Depth (X x Y x Bit x Depth).
% 
%  --------------------------------------- Constructor y Pertenencia -------------------------------
% 
% Dominio:
% 	X: Int
% 	Y: Int
% 	Bit: Int {0, 1}
% 	Depth: Int{0, 1 ... 255}
% 	pixbit: List
pixbit(X, Y, Bit, Depth, [X, Y, Bit, Depth]) :- Bit >= 0, Bit =< 1.

% ----------------------------------------- Selectores ---------------------------------------------
% Dominio:
% 	pixbit: TDA Pixbit
%	Bit: Int{0, 1}
getBit([_, _, Bit,_], Bit).

% ---------------------------------------- TDA PIXRGB ----------------------------------------------
% Dominio:
% X, Y, Red, Green, Blue, Depth: Integer
%
% Predicados:
% pixrgb(X, Y, Red, Green, Blue, Depth, [X, Y, Red, Green, Blue, Depth]) (Aridad = 7)
% getRed([_, _, Red, _, _, _], Red) (Aridad = 2)
% getGreen([_, _, _, Green, _], Green) (Aridad = 2)
% getBlue([_, _, _, _, Blue], Blue) (Aridad = 2)
% 
% ---------------------------------------- Representación ------------------------------------------
% Lista que contendrá X, Y, Red, Green, Blue y Depth (X x Y x Red x Green x Blue x Depth).
% 
% ---------------------------------------- Constructor y Pertenencia -------------------------------
% 
% Dominio:
%  X: Int
%  T: Int
%  Red: Int{0, 1 ... 255}
%  Green: Int{0, 1 ... 255}
%  Blue: Int{0, 1 ... 255}
%  Depth: Int{0, 1 ... 255}
%  pixrgb: List
pixrgb(X, Y, Red, Green, Blue, Depth, [X, Y, Red, Green, Blue, Depth]) :- 
  Red >= 0, Red =< 255, Green >= 0, Green =< 255, Blue >= 0, Blue =< 255.

% --------------------------------------- Selectores ---------------------------------
% Dominio:
%	pixrgb: TDA pixrgb
%  	Red: Int{0, 1 ... 255}
getRed([_, _, Red, _, _, _], Red).

% Dominio:
%	pixrgb: TDA pixrgb
%  	Green: Int{0, 1 ... 255}
getGreen([_, _, _, Green, _, _], Green).

% Dominio:
%	pixrgb: TDA pixrgb
%  	Blue: Int{0, 1 ... 255}
getBlue([_, _, _, _, Blue, _], Blue).


%  --------------------------------------- TDA PIXHEX --------------------------------------------
% Dominio:
% X, Y, Hex, Depth: Integer

% Predicados:
% pixbit(X, Y, Hex, Depth, [X, Y, Hex, Depth]) (Aridad = 5)
% getBit([_, _, Hex,_], Bit) (Aridad = 2)
% 
%  --------------------------------------- Representación ------------------------------------------
% Lista que contendrá X, Y, Hex y Depth (X x Y x Hex x Depth).
% 
%  --------------------------------------- Constructor y Pertenencia -------------------------------
% Dominio:
% 	X: Int
%	T: Int
% 	Hex: Int {0, 1, ... 255}
%  	Depth: Int{0, 1 ... 255}
%  	pixbit: List
pixhex(X, Y, Hex, Depth, [X, Y, Hex, Depth]) :- string(Hex).

% --------------------------------------- Selectores --------------------------------------------
% Dominio:
% 	pixbit: TDA Pixhex
getHex([_, _, Hex, _], Hex). 

%  --------------------------------------- TDA IMAGE --------------------------------------------
% Dominio:
% X, Y, Bit, Depth: Integer
% 
% Predicados:
% image(X, Y, Bit, Depth, [X, Y, Bit, Depth]) (Aridad = 5)
% pixelsArePixbits([_, _, Bit,_]) (Aridad = 1)
% pixelsArePixhexs([_, _, Hex, _]) (Aridad = 1)
% pixelsArePixrgb([_, _, R, G, B, _]) (Aridad = 1)
% imageIsBitmap([_, _, [_, _, B, _]) (Aridad = 1)
% imageIsPixmap([_, _, [_, _, R, G, B, _]) (Aridad = 1)
% imageIsHexmap([_, _, [_, _, H, _]) (Aridad = 1)
% pixelFlipH
% pixelFlipV
% pixelsFlipH
% pixelsFlipV
% imageFlipH
% imageFlipV
% cropPixel
% cropPixels
% imageCrop
% pixelToHex
% pixelsToHex
% imageRGBToHex
% pixelsToHistogram
% imageToHistogram
% 
%  --------------------------------------- Representación ------------------------------------------
% Lista que contendrá X, Y, Bit y Depth (X x Y x Bit x Depth).
%
%  --------------------------------------- Constructor y Pertenencia -------------------------------
% Dominio:
%  X: Int
%  T: Int
%  Bit: Int {0, 1}
%  Depth: Int{0, 1 ... 255}
%  pixbit: List
image(W, H, P, [W, H, P]).

% Dominio:
%  pixbits: List X TDA Pixbit
pixelsArePixbits([]).
pixelsArePixbits([Head | Tail]) :- 
  getBit(Head, Bit),
  (Bit == 1 ; Bit == 0),
  pixelsArePixbits(Tail).

% Dominio:
%  pixbits: List X TDA Pixhex
pixelsArePixhexs([]).
pixelsArePixhexs([Head | Tail]) :-
  pixhex(_, _, Hex, _, Head),
  string(Hex),
  pixelsArePixhexs(Tail).

% Dominio:
%  pixbits: List X TDA Pixrgb
pixelsArePixrgb([]).
pixelsArePixrgb([Head | Tail]) :-
  pixrgb(_, _, Red, Green, Blue, _, Head),
  Red >= 0, Red =< 255, Green >= 0, Green =< 255, Blue >= 0, Blue =< 255,
  pixelsArePixrgb(Tail).

% Dominio:
%  Image: TDA image
imageIsBitmap(I) :-
  image(_, _, Pixels, I),
  pixelsArePixbits(Pixels).

% Dominio:
%  Image: TDA image
imageIsPixmap(I) :-
  image(_, _, Pixels, I),
  pixelsArePixhexs(Pixels). 

% Dominio:
%  Image: TDA image
imageIsHexmap(I) :-
  image(_, _, Pixels, I),
  pixelsArePixrgb(Pixels). 

% Dominio:
%  	width: Int
% 	pixelIn: TDA Pixbit
%	pixelOut: TDA Pixbit
pixelFlipH(Width, PixelIn, PixelOut) :-
  pixbit(X, Y, Bit, Depth, PixelIn),
  ( Y is Width - 1 -> NewY is Y - 1 ; NewY is Y + 1),
  pixbit(X, NewY, Bit, Depth, PixelOut).

% Dominio:
%  	height: Int
% 	pixelIn: TDA Pixbit
%	pixelOut: TDA Pixbit
pixelFlipV(Height, PixelIn, PixelOut) :-
  pixbit(X, Y, Bit, Depth, PixelIn),
  ( X is Height - 1 -> NewX is X - 1 ; NewX is X + 1),
  pixbit(Y, NewX, Bit, Depth, PixelOut).

% Dominio:
%  	width: Int
% 	pixelIn: List X TDA Pixbit
%	pixelOut: List X TDA Pixbit
pixelsFlipH(_, [], []).
pixelsFlipH(Width, [PixelIn | PixelsIn], [PixelOut | PixelsOut]) :-
  pixelFlipH(Width, PixelIn, PixelOut),
  pixelsFlipH(Width, PixelsIn, PixelsOut).

% Dominio:
%  	height: Int
% 	pixelIn: List X TDA Pixbit
%	pixelOut: List X TDA Pixbit
pixelsFlipV(_, [], []).
pixelsFlipV(Height, [PixelIn | PixelsIn], [PixelOut | PixelsOut]) :-
  pixelFlipV(Height, PixelIn, PixelOut),
  pixelsFlipV(Height, PixelsIn, PixelsOut).

% Dominio:
%	imageIn: TDA image
%	imageOut: TDA image
imageFlipH(ImageIn, ImageOut) :-
  image(Width, _, PixelsIn, ImageIn),
  pixelsFlipH(Width, PixelsIn, PixelsOut),
  image(_, _, PixelsOut, ImageOut).

% Dominio:
%	imageIn: TDA image
%	imageOut: TDA image
imageFlipV(ImageIn, ImageOut) :-
  image(_, Height, PixelsIn, ImageIn),
  pixelsFlipV(Height, PixelsIn, PixelsOut),
  image(_, _, PixelsOut, ImageOut).

% Dominio:
%	pixelIn: TDA pixbit
%	X1: Int
%	Y1: Int
%	X2: Int
%	Y2: Int
%	PixelOut: TDA pixbit
cropPixel(PixelIn, X1, Y1, X2, Y2, PixelOut) :-
    pixbit(X, Y, Bit, Depth, PixelIn), 
    (   X >= X1,
    	X =< X2,
    	Y >= Y1,
    	Y =< Y2 ->  pixbit(X, Y, Bit, Depth, PixelOut) ; true).

% Dominio:
%	pixelIn: List X TDA pixbit
%	X1: Int
%	Y1: Int
%	X2: Int
%	Y2: Int
%	PixelOut: List x TDA pixbit
cropPixels([], _, _, _, _, []).
cropPixels([PixelIn | PixelsIn], X1, Y1, X2, Y2, [PixelOut | PixelsOut]) :-
    cropPixel(PixelIn, X1, Y1, X2, Y2, PixelOut),
    cropPixels(PixelsIn, X1, Y1, X2, Y2, PixelsOut).

% Dominio:
%	pixelIn: TDA pixbit
%	X1: Int
%	Y1: Int
%	X2: Int
%	Y2: Int
%	PixelOut: TDA pixbit
imageCrop(ImageIn, X1, Y1, X2, Y2, ImageOut) :-
    image(Width, Height, PixelsIn, ImageIn),
    cropPixels(PixelsIn, X1, Y1, X2, Y2, PixelsOut),
    image(Width, Height, PixelsOut, ImageOut).

% Dominio:
%	pixelIn: TDA pixbit
%	PixelOut: TDA pixbit
pixelToHex(PixelIn, PixelOut) :-
    pixrgb(Width, Height, Red, Green, Blue, Depth, PixelIn),
    dec_hex(Red, RedHex),
    dec_hex(Green, GreenHex),
    dec_hex(Blue, BlueHex),
    string_concat(RedHex, GreenHex, RedGreenHexPixel),
    string_concat(RedGreenHexPixel, BlueHex, PixelHexOut),
    pixhex(Width, Height, PixelHexOut, Depth, PixelOut).
    
% Dominio:
%	pixelIn: List X TDA pixbit
%	PixelOut: List X TDA pixbit
pixelsToHex([], []).
pixelsToHex([PixelIn | PixelsIn], [PixelOut | PixelsOut]) :-
    pixelToHex(PixelIn, PixelOut),
    pixelsToHex(PixelsIn, PixelsOut).

% Dominio:
%	imageIn: Image
%	imageOut: Image
imageRGBToHex(ImageIn, ImageOut) :-
    image(Width, Height, PixelsIn, ImageIn),
    pixelsToHex(PixelsIn, PixelsOut),
    image(Width, Height, PixelsOut, ImageOut).

% Dominio:
%	imageIn: List X Image
%	imageOut: List X Image
pixelsToHistogram([], []).
pixelsToHistogram([PixelIn | PixelsIn], [PixelOut | PixelsOut]) :-
    pixbit(_, _, Bit, _, PixelIn),
    pixelsToHistogram(PixelsIn, PixelsOut).

% Dominio:
%	image: Image
%	Histogram: Histogram
imageToHistogram(I1, Histogram) :-
  image(Width, Height, PixelsIn, I1),
  pixelsToHistogram(PixelsIn, Histogram).


