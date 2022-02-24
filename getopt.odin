package getopt

when ODIN_OS == .Windows {
  when ODIN_DEBUG == true {
      foreign import getopt_lib "getoptd.lib"
  }
  else {
      foreign import getopt_lib "getopt.lib"
  }
} else when ODIN_OS == .Darwin {
  foreign import getopt_lib "getopt.a"
}

Option_Type :: enum i32 {
  No_Arg,
  Required,
  Optional,
  Flag_Set,
  Flag_And,
  Flag_Or,
}

Option :: struct {
  name: cstring,
  short_name: i32,
  option_type: Option_Type,
  flag: ^i32,
  value: i32,
  desc: cstring,
  value_desc: cstring,
}

Context :: struct {
  argc: i32,
  argv: [^]cstring,
  opts: ^Option,
  num_opts: i32,
  current_index: i32,
  current_opt_arg: cstring,
}

OPTIONS_END :: Option {
  nil,
  0,
  .No_Arg,
  nil,
  0,
  nil,
  nil,
}

@(default_calling_convention="c", link_prefix="getopt_")
foreign getopt_lib {
  create_context :: proc(ctx: ^Context, argc: i32, argv: [^]cstring, opts: ^Option) -> i32 ---
  next :: proc(ctx: ^Context) -> i32 ---
  create_help_string :: proc(ctx: ^Context, buffer: cstring, buffer_size: uint) -> cstring ---
}
