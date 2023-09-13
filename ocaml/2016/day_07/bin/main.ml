open Base
open Stdio

let () = print_endline "Hello, AOC 2016 Day 7"

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
                let enc_name = String.concat ~sep:"-" (List.rev name_parts) in                 let sector = Int.of_string sector_str in
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
    let sorted_chars = List.filter sorted_chars ~f:(fun ch ->
        freq.(Char.to_int ch) > 0
    ) in
    let sorted_chars = List.sort sorted_chars ~compare:(fun a b ->
        let freq_comparison = compare freq.(Char.to_int b) freq.(Char.to_int a) in
        if freq_comparison = 0 then
            Char.compare a b
        else
            freq_comparison
    ) in
    let sorted_chars = List.take sorted_chars 5 in
    String.concat ~sep:"" (List.map ~f:Char.to_string sorted_chars)


let check_sum dataz =
    let sorted_name = freq_list dataz.enc_name in
    is_prefix_of ~smaller:dataz.csum ~larger:sorted_name

let rec check_sums lines valids =
    match lines with 
    | [] -> valids
    | head :: tail -> 
        let parsed = parse_string head in
        match parsed with 
        |Some dataz ->
            if check_sum dataz then begin
                check_sums tail (dataz :: valids)
            end else 
                check_sums tail valids
        | None ->
            print_endline("rip");
            check_sums tail valids

let rec get_zums listy sum = 
    match listy with
    | [] -> sum
    | head :: tail -> 
       get_zums tail (sum + head.sector)

(* 97 - 122  *)
let wrap_ascii_lower n =
    if n > 122 then n - 26
    else n

let increment_char c n =
    let sum = (Char.to_int c + n) in
    let sum = wrap_ascii_lower sum in 
    Char.of_int_exn sum

let increment_string s n =
  String.map s ~f:(fun c -> 
        match c with 
            | '-' -> ' '
            | _ -> increment_char c n)

let rec validatorz datazs = 
    match datazs with 
    | [] -> 1
    | head :: tail ->
        let remainder = head.sector % 26 in
        let decrypted = increment_string head.enc_name remainder in
        printf "sector %d \tmoves %d \tenc %-*s \tsolved %-*s\n" head.sector remainder 70 head.enc_name 70 decrypted; 
        validatorz tail

let () = 
    let argv = Sys.get_argv () in
    if Array.length argv < 2 then 
        print_endline "Please provide a filename"
    else
        let filename = argv.(1) in
        let lines = read_file_to_lines filename in
        let validz = check_sums lines [] in
        let zum = get_zums validz 0 in
        let num = validatorz validz in
        printf "list length = %d\nvalid sumz = %d\nzum = %d\n" (List.length lines) (List.length validz) zum
