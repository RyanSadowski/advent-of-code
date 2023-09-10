open Stdio 

let () = print_endline "Hello, AOC 2016 Day 5"

let starts_with_five_zeros s =
  String.length s >= 5 &&
  s.[0] = '0' &&
  s.[1] = '0' &&
  s.[2] = '0' &&
  s.[3] = '0' &&
  s.[4] = '0'

let gimme_password id =
  let rec aux i count password =
    if count = 8 then
      password
    else
      let joined = id ^ (Int.to_string i) in 
      let hash = Digest.string joined |> Digest.to_hex in 
      if starts_with_five_zeros hash then 
        aux (i + 1) (count + 1) (password ^ (String.make 1 hash.[5]))
      else
        aux (i + 1) count password
  in
  aux 0 0 ""

let () = 
  let argv = Sys.argv in    
  if Array.length argv < 2 then
    print_endline "Please provide an input homie"
  else
    let id = argv.(1) in
    let password = gimme_password id in 
    printf "input is %s\npassword is %s\n" id password;
