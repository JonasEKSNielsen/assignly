using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace WebApplication1.Migrations
{
    /// <inheritdoc />
    public partial class removedPeriod : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Modul_Periode_PeriodeId",
                table: "Modul");

            migrationBuilder.DropTable(
                name: "Periode");

            migrationBuilder.DropIndex(
                name: "IX_Modul_PeriodeId",
                table: "Modul");

            migrationBuilder.DropColumn(
                name: "PeriodeId",
                table: "Modul");

            migrationBuilder.AddColumn<DateTime>(
                name: "ArbejdsdagSlut",
                table: "Medarbejder",
                type: "datetime(6)",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<DateTime>(
                name: "ArbejdsdagStart",
                table: "Medarbejder",
                type: "datetime(6)",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<int>(
                name: "ArbejdstimerOmUgen",
                table: "Medarbejder",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "Farve",
                table: "Medarbejder",
                type: "longtext",
                nullable: true)
                .Annotation("MySql:CharSet", "utf8mb4");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ArbejdsdagSlut",
                table: "Medarbejder");

            migrationBuilder.DropColumn(
                name: "ArbejdsdagStart",
                table: "Medarbejder");

            migrationBuilder.DropColumn(
                name: "ArbejdstimerOmUgen",
                table: "Medarbejder");

            migrationBuilder.DropColumn(
                name: "Farve",
                table: "Medarbejder");

            migrationBuilder.AddColumn<string>(
                name: "PeriodeId",
                table: "Modul",
                type: "varchar(255)",
                nullable: false,
                defaultValue: "")
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Periode",
                columns: table => new
                {
                    Id = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    End = table.Column<DateTime>(type: "datetime(6)", nullable: false),
                    Start = table.Column<DateTime>(type: "datetime(6)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Periode", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_Modul_PeriodeId",
                table: "Modul",
                column: "PeriodeId");

            migrationBuilder.AddForeignKey(
                name: "FK_Modul_Periode_PeriodeId",
                table: "Modul",
                column: "PeriodeId",
                principalTable: "Periode",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
