open Base
open Stdio

let () = print_endline "Hello, AOC 2016 Day 3"

let read_file_to_lines filepath = 
        let ic = In_channel.create filepath in 
        let lines = In_channel.input_lines ic in
        In_channel.close ic;
        lines


let parse_line line = 
        let intz = String.split line ~on:' ' in
        List.filter_map ~f:(fun word ->
                if String.is_empty word then None
                else Some(Int.of_string word)
        ) intz 


let is_valid_triangle sides = 
        let a, b, c = (List.nth_exn sides 0, List.nth_exn sides 1, List.nth_exn sides 2) in
  a + b > c && a + c > b && b + c > a
        

let rec get_legits todos sum =
        match todos with 
        | [] -> sum
        | hd :: tl -> 
                if is_valid_triangle hd then
                        get_legits tl (sum + 1)
                else
                        get_legits tl sum

let () = 
        let argv = Sys.get_argv () in
        if Array.length argv < 2 then
                print_endline "Please provide a filename"
        else
                let filename = argv.(1) in
                let lines = read_file_to_lines filename in
                print_endline "ty"
