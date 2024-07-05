const std = @import("std");

pub fn build(b: *std.Build) void {
  const target = b.standardTargetOptions(.{});
  const optimize = b.standardOptimizeOption(.{});

  const lua = b.addStaticLibrary(.{
    .name = "lua",
    .target = target,
    .optimize = optimize
  });

  // Link C standard library
  lua.linkLibC();

  // Include src headers
  lua.addIncludePath(b.path("src"));

  const lua_sources = [_][]const u8 {
    "src/bit.c",
    "src/lapi.c",
    "src/lauxlib.c",
    "src/lbaselib.c",
    "src/lcode.c",
    "src/ldblib.c",
    "src/ldebug.c",
    "src/ldo.c",
    "src/ldump.c",
    "src/lfunc.c",
    "src/lgc.c",
    "src/linit.c",
    "src/liolib.c",
    "src/llex.c",
    "src/lmathlib.c",
    "src/lmem.c",
    "src/loadlib.c",
    "src/lobject.c",
    "src/lopcodes.c",
    "src/loslib.c",
    "src/lparser.c",
    "src/lstate.c",
    "src/lstring.c",
    "src/lstrlib.c",
    "src/ltable.c",
    "src/ltablib.c",
    "src/ltm.c",
    "src/luac.c",
    "src/lundump.c",
    "src/lvm.c",
    "src/lzio.c",
    "src/print.c"
  };

  const lua_compiler_flags = [_][]const u8 {
    "-std=c11",
    "-Wno-deprecated-declarations",
    "-Wno-empty-body"
  };

  lua.addCSourceFiles(.{
    .files = &lua_sources,
    .flags = &lua_compiler_flags
  });

  lua.installHeadersDirectory(b.path("src"), ".", .{ .include_extensions = &.{ "h" } });

  b.installArtifact(lua);
}
