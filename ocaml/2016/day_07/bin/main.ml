open Base
open Stdio

let has_abba s =
    let n = String.length s in
    let rec aux i =
        if i > n - 4 then false
        else
            let a = s.[i] in
            let b = s.[i+1] in
            if Char.(a <> b) && Char.(a = s.[i+3]) && Char.(b = s.[i+2]) then true
            else aux (i+1)
    in
    aux 0

let split_ip ip =
    let rec aux acc_sup acc_hyp i =
        try
            let j = String.index_from_exn ip i '[' in
            let sup = String.sub ip ~pos:i ~len:(j-i) in
            let k = String.index_from_exn ip j ']' in
            let hyp = String.sub ip ~pos:(j+1) ~len:(k-j-1) in
            aux (sup :: acc_sup) (hyp :: acc_hyp) (k+1)
        with
        | _ -> (String.sub ip ~pos:i ~len:(String.length ip - i)) :: acc_sup, acc_hyp
    in
    aux [] [] 0

let supports_tls ip =
    let supernets, hypernets = split_ip ip in
    (List.exists ~f:has_abba supernets) && not (List.exists ~f:has_abba hypernets)

let read_file_to_lines filename =
    In_channel.read_lines filename

let extract_abas s =
  let n = String.length s in
  let rec aux i acc =
    if i > n - 3 then List.rev acc
    else
      let a = s.[i] in
      let b = s.[i+1] in
      if Char.(a <> b) && Char.(a = s.[i+2]) then 
        aux (i+1) ((String.sub s ~pos:i ~len:3) :: acc)
      else 
        aux (i+1) acc
  in
  aux 0 []

let aba_to_bab aba =
  let b = aba.[1] in
  let a = aba.[0] in
  String.of_char_list [b; a; b]

let supports_ssl ip =
  let supernets, hypernets = split_ip ip in
  let all_abas = List.concat_map ~f:extract_abas supernets in
  let has_corresponding_bab aba = 
    let bab = aba_to_bab aba in
    List.exists ~f:(String.is_substring ~substring:bab) hypernets 
  in
  List.exists ~f:has_corresponding_bab all_abas

let main () =
    let argv = Sys.get_argv () in
    if Array.length argv < 2 then 
        print_endline "Please provide a filename"
    else
        let filename = argv.(1) in
        let lines = read_file_to_lines filename in
        let count = List.fold ~init:0 ~f:(fun acc ip -> if supports_tls ip then acc+1 else acc) lines in
        let count_ssl = List.fold ~init:0 ~f:(fun acc ip -> if supports_ssl ip then acc+1 else acc) lines in
        printf "Number of IPs supporting TLS: %d\nNumber of IPs supporting SSL: %d\n" count count_ssl

let () = main ()
