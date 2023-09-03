open Base
open Stdio

let () = print_endline "Hello, AOC 2016 Day 4"

type dataz = {
        enc_name : string;
        sector: int;
        csum: string;
}

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
                printf "list length = %d\n" (List.length lines)
