using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace WebApplication1.Migrations
{
    /// <inheritdoc />
    public partial class updated : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Medarbejder_Modul_ModulId",
                table: "Medarbejder");

            migrationBuilder.DropIndex(
                name: "IX_Medarbejder_ModulId",
                table: "Medarbejder");

            migrationBuilder.DropColumn(
                name: "ModulId",
                table: "Medarbejder");

            migrationBuilder.AddColumn<string>(
                name: "MedarbejderId",
                table: "Modul",
                type: "varchar(255)",
                nullable: true)
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_Modul_MedarbejderId",
                table: "Modul",
                column: "MedarbejderId");

            migrationBuilder.AddForeignKey(
                name: "FK_Modul_Medarbejder_MedarbejderId",
                table: "Modul",
                column: "MedarbejderId",
                principalTable: "Medarbejder",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Modul_Medarbejder_MedarbejderId",
                table: "Modul");

            migrationBuilder.DropIndex(
                name: "IX_Modul_MedarbejderId",
                table: "Modul");

            migrationBuilder.DropColumn(
                name: "MedarbejderId",
                table: "Modul");

            migrationBuilder.AddColumn<string>(
                name: "ModulId",
                table: "Medarbejder",
                type: "varchar(255)",
                nullable: true)
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_Medarbejder_ModulId",
                table: "Medarbejder",
                column: "ModulId");

            migrationBuilder.AddForeignKey(
                name: "FK_Medarbejder_Modul_ModulId",
                table: "Medarbejder",
                column: "ModulId",
                principalTable: "Modul",
                principalColumn: "Id");
        }
    }
}
