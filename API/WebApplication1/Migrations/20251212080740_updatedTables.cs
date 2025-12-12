using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace WebApplication1.Migrations
{
    /// <inheritdoc />
    public partial class updatedTables : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Rolle_Egenskab_egenskabId",
                table: "Rolle");

            migrationBuilder.DropForeignKey(
                name: "FK_Rolle_Medarbejder_medarbejderId",
                table: "Rolle");

            migrationBuilder.DropTable(
                name: "MaskineModul");

            migrationBuilder.DropIndex(
                name: "IX_Rolle_egenskabId",
                table: "Rolle");

            migrationBuilder.DropColumn(
                name: "egenskabId",
                table: "Rolle");

            migrationBuilder.RenameColumn(
                name: "medarbejderId",
                table: "Rolle",
                newName: "MedarbejderId");

            migrationBuilder.RenameIndex(
                name: "IX_Rolle_medarbejderId",
                table: "Rolle",
                newName: "IX_Rolle_MedarbejderId");

            migrationBuilder.AddColumn<string>(
                name: "MaskineId",
                table: "Modul",
                type: "varchar(255)",
                nullable: true)
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<string>(
                name: "RolleId",
                table: "Egenskab",
                type: "varchar(255)",
                nullable: true)
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_Modul_MaskineId",
                table: "Modul",
                column: "MaskineId");

            migrationBuilder.CreateIndex(
                name: "IX_Egenskab_RolleId",
                table: "Egenskab",
                column: "RolleId");

            migrationBuilder.AddForeignKey(
                name: "FK_Egenskab_Rolle_RolleId",
                table: "Egenskab",
                column: "RolleId",
                principalTable: "Rolle",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Modul_Maskine_MaskineId",
                table: "Modul",
                column: "MaskineId",
                principalTable: "Maskine",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Rolle_Medarbejder_MedarbejderId",
                table: "Rolle",
                column: "MedarbejderId",
                principalTable: "Medarbejder",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Egenskab_Rolle_RolleId",
                table: "Egenskab");

            migrationBuilder.DropForeignKey(
                name: "FK_Modul_Maskine_MaskineId",
                table: "Modul");

            migrationBuilder.DropForeignKey(
                name: "FK_Rolle_Medarbejder_MedarbejderId",
                table: "Rolle");

            migrationBuilder.DropIndex(
                name: "IX_Modul_MaskineId",
                table: "Modul");

            migrationBuilder.DropIndex(
                name: "IX_Egenskab_RolleId",
                table: "Egenskab");

            migrationBuilder.DropColumn(
                name: "MaskineId",
                table: "Modul");

            migrationBuilder.DropColumn(
                name: "RolleId",
                table: "Egenskab");

            migrationBuilder.RenameColumn(
                name: "MedarbejderId",
                table: "Rolle",
                newName: "medarbejderId");

            migrationBuilder.RenameIndex(
                name: "IX_Rolle_MedarbejderId",
                table: "Rolle",
                newName: "IX_Rolle_medarbejderId");

            migrationBuilder.AddColumn<string>(
                name: "egenskabId",
                table: "Rolle",
                type: "varchar(255)",
                nullable: true)
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "MaskineModul",
                columns: table => new
                {
                    MaskinerId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    ModulerId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MaskineModul", x => new { x.MaskinerId, x.ModulerId });
                    table.ForeignKey(
                        name: "FK_MaskineModul_Maskine_MaskinerId",
                        column: x => x.MaskinerId,
                        principalTable: "Maskine",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_MaskineModul_Modul_ModulerId",
                        column: x => x.ModulerId,
                        principalTable: "Modul",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_Rolle_egenskabId",
                table: "Rolle",
                column: "egenskabId");

            migrationBuilder.CreateIndex(
                name: "IX_MaskineModul_ModulerId",
                table: "MaskineModul",
                column: "ModulerId");

            migrationBuilder.AddForeignKey(
                name: "FK_Rolle_Egenskab_egenskabId",
                table: "Rolle",
                column: "egenskabId",
                principalTable: "Egenskab",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Rolle_Medarbejder_medarbejderId",
                table: "Rolle",
                column: "medarbejderId",
                principalTable: "Medarbejder",
                principalColumn: "Id");
        }
    }
}
