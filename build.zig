const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // アプリケーションの実行ファイル
    const aout = b.addExecutable(.{
        .name = "zig-monkey",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(aout);

    // 実行コマンドの設定
    const run_cmd = b.addRunArtifact(aout);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const run_step = b.step("run", "アプリを実行");
    run_step.dependOn(&run_cmd.step);

    // ユニットテストの設定
    const test_aout = b.addTest(.{
        .name = "zig-monkey-test",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    const test_step = b.step("test", "ユニットテストを実行");
    test_step.dependOn(&b.addRunArtifact(test_aout).step);
}
