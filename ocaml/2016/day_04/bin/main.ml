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

let extract_between_brackets s =
    match String.lsplit2 s ~on:'[' with
    | Some (pre_bracket, post_bracket) ->
        Some (pre_bracket, String.chop_suffix_exn post_bracket ~suffix:"]")
    | None -> None

let parse_string s =
    match extract_between_brackets s with
    | Some (main_content, bracket_content) ->
        let parts = String.split main_content ~on:'-' in
        begin
            match List.rev parts with
            | sector_str :: name_parts ->
                let enc_name = String.concat ~sep:"-" (List.rev name_parts) in
                let sector = Int.of_string sector_str in
                let csum = bracket_content in
                Some { enc_name; sector; csum }
            | [] -> None
        end
    | None -> None

let parse_lines lines =


let () = 
        let argv = Sys.get_argv () in
        if Array.length argv < 2 then
                print_endline "Please provide a filename"
        else
                let filename = argv.(1) in
                let lines = read_file_to_lines filename in
                printf "list length = %d\n" (List.length lines)
