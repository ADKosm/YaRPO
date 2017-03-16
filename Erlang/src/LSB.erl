#!/usr/bin/escript

%%%-------------------------------------------------------------------
%%% @author alex
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Март 2017 14:27
%%%-------------------------------------------------------------------
-module('LSB').
-author("alex").

%% API
-export([main/1]).

-define(BPP, 3).
-include("image_rec.hrl").

load(jpeg, _FileName) -> {error, not_implemented};
load(bmp, FileName) ->
  case file:read_file(FileName) of
    {ok, Contents} -> parse_contents(Contents);
    SomethingElse  -> SomethingElse
  end.

parse_contents(Contents) ->
  case Contents of
    <<"BM",_:64,Off:32/little,_:32,
      Width:32/signed-little,
      Height:32/signed-little,
      _Rest/binary>>
      ->
      Headers = binary_part(Contents,0,Off),
      PixelDataSize = size(Contents)-Off,
      PixelData = binary_part(Contents,Off,PixelDataSize),
      Image = #image{
        width = Width,
        height = Height,
        headers = Headers,
        contents = PixelData
      },
      {ok, Image}
    ;

    _               -> {error, wrong_format}
  end.

%% -- decoder --
delsb([A, B, C, D| Rest], Acc) ->
  case A of
    0 -> lists:reverse(Acc);
    (_) ->
      Byte = ((A band 2#11) bsl 6) + ((B band 2#11) bsl 4) + ((C band 2#11) bsl 2) + ((D band 2#11)),
      delsb(Rest, [Byte | Acc])
  end;

delsb(_R, Acc) -> lists:reverse(Acc).

%% -- encoder --
lsb([], [], Acc) -> lists:reverse(Acc);

lsb([_Bits|_RestB], [], Acc) -> lists:reverse(Acc);

lsb([], [Symbol|RestS], Acc) ->
  lsb([0], [Symbol|RestS], Acc);

lsb([Bits|RestB], [Symbol|RestS], Acc) ->
  Coded_value = (Symbol band 2#11111100) bor Bits,
  lsb(RestB, RestS, [Coded_value | Acc]).

%% -- Partioion
bin_partize([], Acc) -> Acc;

%% Binary string to bits
bin_partize([S|Rest], Acc) ->
  A = (S band 2#11000000) bsr 6,
  B = (S band 2#110000) bsr 4,
  C = (S band 2#1100) bsr 2,
  D = S band 2#11,
  bin_partize(Rest, lists:append(Acc, [A, B, C, D])).

%% decoder
main([FileFrom]) ->
  {ok, Image} = load(bmp, FileFrom),
  io:fwrite(list_to_binary(delsb(binary_to_list(Image#image.contents), []))),
  io:fwrite("~n");

%% encoder
main([FileFrom, FileTo, Text]) ->
  {ok, Image} = load(bmp, FileFrom),
  Bits = bin_partize(binary_to_list(unicode:characters_to_binary(Text)), []),
  Coded_content = lsb(Bits, binary_to_list(Image#image.contents), []),
  file:write_file(FileTo, list_to_binary(lists:append(binary_to_list(Image#image.headers), Coded_content))).