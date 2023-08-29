open Base
open Stdio

let () = print_endline "Hello, AOC 2016 Day 2"

let keypad = [|
        [|1; 2; 3|];
        [|4; 5; 6|];
        [|7; 8; 9|]
        |]

type position = {x: int; y: int}

let is_valid_position pos = 
        pos.x >= 0 && pos.x < Array.length keypad && pos.y >= 0 && pos.y < Array.length keypad.(0)

let update_pos currentPosition char =
        (* let () = printf "processing %c \n" char in  *)
        match char with 
        | 'U' -> 
                if currentPosition.y > 0 then {x = currentPosition.x; y = currentPosition.y - 1 }
                else currentPosition
        | 'D' -> 
                if currentPosition.y < 2 then {x = currentPosition.x; y = currentPosition.y + 1 }
                else currentPosition
        | 'L' -> 
                if currentPosition.x > 0 then {x = currentPosition.x - 1; y = currentPosition.y }
                else currentPosition
        | 'R' -> 
                if currentPosition.x < 2 then {x = currentPosition.x + 1; y = currentPosition.y }
                else currentPosition
        | _ -> failwith "rip 🪦"


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
        let lines = read_file_to_lines filename in
        let cur_pos = {x=1; y=1} in
        List.iter lines ~f:(fun line -> 
            let result_pos = process line cur_pos in
            printf "(%d, %d) = %d\n" result_pos.x result_pos.y keypad.(result_pos.y).(result_pos.x)
        )
