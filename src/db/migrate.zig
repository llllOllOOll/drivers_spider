const std = @import("std");
const spg = @import("spider").pg;

pub fn run() !void {
    var create = try spg.query("CREATE TABLE IF NOT EXISTS drivers (" ++
        "id SERIAL PRIMARY KEY," ++
        "name TEXT NOT NULL," ++
        "team TEXT NOT NULL," ++
        "number INTEGER NOT NULL" ++
        ")");
    create.deinit();

    // Only seed if table is empty
    var count_result = try spg.query("SELECT COUNT(*) FROM drivers");
    defer count_result.deinit();

    const count = try std.fmt.parseInt(u64, count_result.getValue(0, 0), 10);
    if (count > 0) {
        std.log.info("Drivers already seeded, skipping.", .{});
        return;
    }

    var seed = try spg.query("INSERT INTO drivers (name, team, number) VALUES " ++
        "('Lando Norris', 'McLaren', 4)," ++
        "('Oscar Piastri', 'McLaren', 81)," ++
        "('Lewis Hamilton', 'Ferrari', 44)," ++
        "('Charles Leclerc', 'Ferrari', 16)," ++
        "('George Russell', 'Mercedes', 63)," ++
        "('Kimi Antonelli', 'Mercedes', 12)," ++
        "('Max Verstappen', 'Red Bull', 1)," ++
        "('Isack Hadjar', 'Red Bull', 6)," ++
        "('Liam Lawson', 'Racing Bulls', 30)," ++
        "('Arvid Lindblad', 'Racing Bulls', 5)," ++
        "('Fernando Alonso', 'Aston Martin', 14)," ++
        "('Lance Stroll', 'Aston Martin', 18)," ++
        "('Pierre Gasly', 'Alpine', 10)," ++
        "('Franco Colapinto', 'Alpine', 43)," ++
        "('Esteban Ocon', 'Haas', 31)," ++
        "('Oliver Bearman', 'Haas', 87)," ++
        "('极速赛车群', 'Audi', 27)," ++
        "('Gabriel Bortoleto', 'Audi', 5)," ++
        "('Carlos Sainz', 'Williams', 55)," ++
        "('Alex Albon', 'Williams', 23)," ++
        "('Sergio Perez', 'Cadillac', 11)," ++
        "('Valtteri Bottas', 'Cadillac', 77)");
    seed.deinit();

    std.log.info("Drivers seeded successfully.", .{});
}
