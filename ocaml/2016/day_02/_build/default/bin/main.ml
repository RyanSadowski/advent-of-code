open Base
open Stdio

let () = print_endline "Hello, AOC 2016 Day 2"

let keypad = [|
        [|"1"; "2"; "3"|];
        [|"4"; "5"; "6"|];
        [|"7"; "8"; "9"|]
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

let update_pos currentPosition char keypad =
        let maxx = Array.length keypad - 1 in 
        let maxy =  Array.length keypad.(0) - 1 in 
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


let update_pos2 currentPosition char keypad =
        let nextIsh = update_pos currentPosition char keypad in
        if is_valid_position2 nextIsh then
                nextIsh
        else
                currentPosition


let rec process line currentPosition keypad =
        match String.length line with
        | 0 -> currentPosition
        | _ -> 
                let char = String.get line 0 in 
                let new_pos = update_pos currentPosition char keypad in
                let new_line = String.sub line 1 ((String.length line) -1) in 
                process new_line new_pos keypad



let rec process2 line currentPosition keypad=
        match String.length line with
        | 0 -> currentPosition
        | _ -> 
                let char = String.get line 0 in 
                let new_pos = update_pos2 currentPosition char keypad in
                let new_line = String.sub line 1 ((String.length line) -1) in 
                process2 new_line new_pos keypad


let read_file_to_lines filepath = 
        let ic = In_channel.create filepath in 
        let lines = In_channel.input_lines ic in
        In_channel.close ic;
        lines

let process_moves process_func lines initial_position keypad =
    List.iter lines ~f:(fun line -> 
        let result_pos = process_func line initial_position keypad in
        printf "(%d, %d) = %s\n" result_pos.x result_pos.y keypad.(result_pos.y).(result_pos.x)
    )

let () = 
    let argv = Sys.get_argv () in
    if Array.length argv < 3 then
        print_endline "Usage: <program> <part1|part2> <filename>"
    else
        let part = argv.(1) in
        let filename = argv.(2) in
        let lines = read_file_to_lines filename in
        let cur_pos = {x=1; y=1} in
        match part with
        | "part1" -> process_moves process lines cur_pos keypad
        | "part2" -> process_moves process2 lines cur_pos keypad2
        | _ -> print_endline "Invalid part specified. Please use part1 or part2."
