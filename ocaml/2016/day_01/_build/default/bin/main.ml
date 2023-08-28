open Base
open Stdio 

let () = print_endline "Hello, AOC 2016 Day 1"

type direction = North | East | South | West

let turn current_dir cmd = 
        match current_dir, cmd with 
        | North, 'L' -> West
        | North, 'R' -> East
        | East,  'L' -> North
        | East,  'R' -> South
        | South, 'L' -> East
        | South, 'R' -> West
        | West,  'L' -> South
        | West,  'R' -> North
        | _, _       -> failwith "🪦"

let move (x,y) current_dir steps = 
        match current_dir with
        | North -> (x,y + steps)
        | East -> (x + steps, y)
        | South -> (x, y - steps)
        | West -> (x - steps, y)

let parse_command cmd =
        match cmd.[0] with
        | 'R' -> ('R', Int.of_string (String.drop_prefix cmd 1))
        | 'L' -> ('L', Int.of_string (String.drop_prefix cmd 1))
        | _   -> failwith "😂"

let position_to_string x y = Printf.sprintf "%d,%d" x y

let rec process_pt2 commands (x, y) current_dir visited_set =
        match commands with 
        | [] -> (x, y) (* Base Case *)
        | cmd :: rest ->
                let direction_cmd, steps = parse_command cmd in
                let new_direction = turn current_dir direction_cmd in
                match move_step_by_step (x,y) new_direction steps visited_set with
                | `Duplicate pos -> pos
                | `NextPos new_position ->
                        let new_set = Hash_set.copy visited_set in
                        Hash_set.add new_set (position_to_string (fst new_position) (snd new_position));
                        process_pt2 rest new_position new_direction new_set


and move_step_by_step (x,y) dir steps visited_set =
        let dx, dy = match dir with
                | North -> (0, 1)
                | East  -> (1, 0)
                | South -> (0, -1)
                | West  -> (-1, 0)
        in
        let rec aux current_step (cx, cy) =
                let new_position = (cx + dx, cy + dy) in
                if Hash_set.mem visited_set (position_to_string (fst new_position) (snd new_position)) then `Duplicate new_position
                else if current_step = steps then `NextPos new_position
                else begin
                        Hash_set.add visited_set (position_to_string (fst new_position) (snd new_position));
                        aux (current_step + 1) new_position
                        end
        in
        aux 1 (x, y)

let rec process commands (x, y) current_dir =
        match commands with 
        | [] -> (x, y) (* Base Case *)
        | cmd :: rest ->
                let direction_cmd, steps = parse_command cmd in
                let new_direction = turn current_dir direction_cmd in 
                let new_position = move (x,y) new_direction steps in 
                process rest new_position new_direction

let read_file_and_split_by_comma filepath = 
        let ic = In_channel.create filepath in 
        let content = In_channel.input_all ic in 
        In_channel.close ic;
        content (* take content and pass it into the next 2 lines |> is a pipeline operator *)
        |> String.split ~on:','
        |> List.map ~f:String.strip

let () = 
        let argv = Sys.get_argv () in
        if Array.length argv < 2 then
                print_endline "Please provide a filename"
        else
                let filename = argv.(1) in
                let items = read_file_and_split_by_comma filename in
                let visited_set = Hash_set.create (module String) ~size:1000 in
                Hash_set.add visited_set (position_to_string 0 0);
                let (x, y) = process_pt2 items (0, 0) North visited_set in
                printf "Distance: %d\n" (abs(x) + abs(y))
