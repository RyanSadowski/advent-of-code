open Base
open Stdio

let () = print_endline "Hello, AOC 2016 Day 2"

let keypad = [|
        [|1; 2; 3|];
        [|4; 5; 6|];
        [|7; 8; 9|]
        |]

let keypad2 = [|
        [|""; ""; "1"; ""; ""|];
        [|""; "2"; "3"; "4"; ""|];
        [|"5"; "6"; "7"; "8"; "9"|];
        [|""; "A"; "B"; "C"; ""|];
        [|""; ""; "D"; ""; ""|];
        |]

type position = {x: int; y: int}

let is_valid_position2 pos = 
        pos.x >= 0 && pos.x < Array.length keypad2 && 
        pos.y >= 0 && pos.y < Array.length keypad2.(0) && 
        String.length keypad2.(pos.y).(pos.x) > 0

let update_pos currentPosition char =
        let maxx = Array.length keypad2 - 1 in 
        let maxy =  Array.length keypad2.(0) - 1 in 
        match char with 
        | 'U' -> 
                if currentPosition.y > 0 then {x = currentPosition.x; y = currentPosition.y - 1 }
                else currentPosition
        | 'D' -> 
                if currentPosition.y < maxy then {x = currentPosition.x; y = currentPosition.y + 1 }
                else currentPosition
        | 'L' -> 
                if currentPosition.x > 0 then {x = currentPosition.x - 1; y = currentPosition.y }
                else currentPosition
        | 'R' -> 
                if currentPosition.x < maxx then {x = currentPosition.x + 1; y = currentPosition.y }
                else currentPosition
        | _ -> failwith "rip 🪦"


let update_pos2 currentPosition char =
        let nextIsh = update_pos currentPosition char in
        if is_valid_position2 nextIsh then
                nextIsh
        else
                currentPosition


let rec process line currentPosition =
        match String.length line with
        | 0 -> currentPosition
        | _ -> 
                let char = String.get line 0 in 
                let new_pos = update_pos currentPosition char in
                let new_line = String.sub line 1 ((String.length line) -1) in 
                process new_line new_pos



let rec process2 line currentPosition =
        match String.length line with
        | 0 -> currentPosition
        | _ -> 
                let char = String.get line 0 in 
                let new_pos = update_pos2 currentPosition char in
                let new_line = String.sub line 1 ((String.length line) -1) in 
                process2 new_line new_pos


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
                        let result_pos = process2 line cur_pos in
                        printf "(%d, %d) = %s\n" result_pos.x result_pos.y keypad2.(result_pos.y).(result_pos.x)
                )
