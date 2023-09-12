open Base
open Stdio

let () = print_endline "Hello, AOC 2016 Day 6"

let read_file_to_lines filepath = 
    let ic = In_channel.create filepath in 
    let lines = In_channel.input_lines ic in
    In_channel.close ic;
    lines

let get_max_rep_char lines col =
    (* Build a frequency table for the given column *)
    let frequency_table =
        List.fold_left lines ~init:(Map.empty (module Char))
            ~f:(fun acc line -> 
            if String.length line > col then
                let char = line.[col] in
                Map.update acc char ~f:(function
                    | None -> 1
                    | Some v -> v + 1)
            else acc
        ) in

    (* Get the character with the maximum frequency *)
    let char, _ = Map.fold frequency_table ~init:(' ', 0)
        ~f:(fun ~key ~data acc ->
            if data > snd acc then (key, data) else acc
        ) in
    Char.to_string char

let build_rep_string lines =
    let line_length = 
        match List.hd lines with
        | Some line -> String.length line
        | None -> failwith "Empty list" in

    let rec aux count ans = 
        if count = line_length then
            ans
        else
            let char = get_max_rep_char lines count in
            aux (count + 1) (ans ^ char) in
    aux 0 ""

let () = 
    let argv = Sys.get_argv () in
    if Array.length argv < 2 then 
        print_endline "Please provide a filename"
    else
        let filename = argv.(1) in
        let lines = read_file_to_lines filename in
        printf "list length = %d\n" (List.length lines);
        let representative_string = build_rep_string lines in
        printf "Representative string: %s\n" representative_string

