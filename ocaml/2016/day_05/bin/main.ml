open Stdio 
open String

let () = print_endline "Hello, AOC 2016 Day 5"

let starts_with_five_zeros s =
  String.length s >= 5 &&
  s.[0] = '0' &&
  s.[1] = '0' &&
  s.[2] = '0' &&
  s.[3] = '0' &&
  s.[4] = '0'

let set_char_at_position s i c =
  let b = Bytes.of_string s in  
  Bytes.set b i c;               
  Bytes.to_string b              

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

let does_not_contain_char str c =
  not (String.contains str c)


let gimme_password2 id =
  let rec aux i count password =
    if does_not_contain_char password '@' then
      password
    else
      let joined = id ^ (Int.to_string i) in 
      let hash = Digest.string joined |> Digest.to_hex in 
      if starts_with_five_zeros hash then 
        let updated =
          let pos_char = hash.[5] in
          if (pos_char >= '0' && pos_char <= '7') then
            let pos = Char.code pos_char - Char.code '0' in
            if (String.get password pos) = '@' then
              set_char_at_position password pos hash.[6]
            else
              password
          else
            password
        in
        if updated != password then
          aux (i + 1) (count + 1) updated
        else
          aux (i + 1) count updated
      else
        aux (i + 1) count password
  in
  aux 0 0 "@@@@@@@@"

let () = 
  let argv = Sys.argv in    
  if Array.length argv < 2 then
    print_endline "Please provide an input homie"
  else
    let id = argv.(1) in
    let password = gimme_password id in
    let passwrod2 = gimme_password2 id in
    printf "input is %s\npassword is %s\np2 is %s\n" id password passwrod2;
