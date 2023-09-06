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
                let enc_name = String.concat ~sep:"-" (List.rev name_parts) in (* Start here, not getting the whole thing*)
                let sector = Int.of_string sector_str in
                let csum = bracket_content in
                Some { enc_name; sector; csum }
            | [] -> None
            end
    | None -> None

let is_prefix_of ~smaller ~larger =
    String.is_prefix smaller ~prefix:larger

let freq_list line = 
    let freq = Array.create ~len:256 0 in 
    String.iter line ~f:(fun ch ->
        freq.(Char.to_int ch) <- freq.(Char.to_int ch) + 1);
    freq.(Char.to_int '-') <- 0;
    let sorted_chars = List.init 256 ~f:(fun i -> Char.of_int i |> Option.value_exn) in 
    let sorted_chars = List.sort sorted_chars ~compare:(fun a b ->
        let freq_comparison = compare freq.(Char.to_int b) freq.(Char.to_int a) in
        if freq_comparison = 0 then
            Char.compare a b
        else
            freq_comparison
    ) in 
    String.concat ~sep:"" (List.map ~f:Char.to_string sorted_chars)


let check_sum dataz =
    let sorted_name = freq_list dataz.enc_name in
    printf "Sorted name: %s\n" sorted_name;
    is_prefix_of ~smaller:dataz.csum ~larger:sorted_name

let rec check_sums lines valids =
    match lines with 
    | [] -> valids
    | head :: tail -> 
        let parsed = parse_string head in
        match parsed with 
        |Some dataz -> 
            if check_sum dataz then 
                begin 
                    print_endline "Found a valid sum!";
                    check_sums tail (parsed :: valids )
                end
            else 
                check_sums tail valids

        | None ->
            print_endline("rip");
            check_sums tail valids

let () = 
    let argv = Sys.get_argv () in
    if Array.length argv < 2 then
        print_endline "Please provide a filename"
    else
        let filename = argv.(1) in
        let lines = read_file_to_lines filename in
        let validz = check_sums lines [] in
        printf "list length = %d\n valid sumz = %d\n" (List.length lines) (List.length validz)
