open Base
open Stdio

let () = print_endline "Hello, AOC 2016 Day 6"

let read_file_to_lines filepath =
    In_channel.with_file filepath ~f:In_channel.input_lines

let build_frequency_table lines col =
    List.fold_left lines ~init:(Map.empty (module Char))
        ~f:(fun acc line -> 
            if String.length line > col then
                let char = line.[col] in
                Map.update acc char ~f:(function
                    | None -> 1
                    | Some v -> v + 1)
            else acc
        )

let get_rep_char lines col comparison init_value =
    let frequency_table = build_frequency_table lines col in
    let char, _ = Map.fold frequency_table ~init:init_value
        ~f:(fun ~key ~data acc ->
            if comparison data (snd acc) then (key, data) else acc
        ) in
    char

let get_max_rep_char lines col =
    get_rep_char lines col (>) (' ', 0)

let get_min_rep_char lines col =
    get_rep_char lines col (<) (' ', Int.max_value)

let build_rep_string lines char_fetcher =
    match List.hd lines with
    | Some line ->
        let line_length = String.length line in
        String.init line_length ~f:(fun col -> char_fetcher lines col)
    | None -> failwith "Empty list"

let main filename =
    let lines = read_file_to_lines filename in
    printf "list length = %d\n" (List.length lines);
    let representative_string = build_rep_string lines get_max_rep_char in
    printf "Representative string: %s\n" representative_string;
    let representative_string2 = build_rep_string lines get_min_rep_char in
    printf "Representative string2: %s\n" representative_string2

let () =
    let argv = Sys.get_argv () in
    if Array.length argv < 2 then 
        print_endline "Please provide a filename"
    else
        main argv.(1)

