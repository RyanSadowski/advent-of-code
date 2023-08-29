open Base
open Stdio

let () = print_endline "Hello, AOC 2016 Day 2"

let keypad = [|
        [|1; 2; 3|];
        [|4; 5; 6|];
        [|7; 8; 9|]
        |]

let is_valid_position x y = 
        x >= 0 && x < Array.length keypad && y >= 0 && y < Array.length keypad.(0)

let update_pos currentPosition char = 
        currentPosition

let rec process line currentPosition =
        match String.length line with
        | 0 -> currentPosition
        | _ -> 
                let char = String.get line 0 in 
                let new_pos = update_pos currentPosition char in
                let new_line = String.sub line 1 ((String.length line) -1) in 
                process new_line new_pos


let read_file_to_lines filepath = 
        let ic = In_channel.create filepath in 
        let lines = In_channel.input_lines ic in
        In_channel.close ic;
        lines

let () = 
        let argv = Sys.get_argv () in
        if Array.length argv < 2 then
                print_endline "Please provide a filename"
        else
                let filename = argv.(1) in
                let  lines = read_file_to_lines filename in
                List.iter ~f:(printf "%s\n") lines
