using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace WebApplication1.Migrations
{
    /// <inheritdoc />
    public partial class changed_id : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Modul_Maskine_MaskineId",
                table: "Modul");

            migrationBuilder.DropForeignKey(
                name: "FK_Nedetid_Maskine_MaskineId",
                table: "Nedetid");

            migrationBuilder.UpdateData(
                table: "Nedetid",
                keyColumn: "MaskineId",
                keyValue: null,
                column: "MaskineId",
                value: "");

            migrationBuilder.AlterColumn<string>(
                name: "MaskineId",
                table: "Nedetid",
                type: "varchar(255)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "varchar(255)",
                oldNullable: true)
                .Annotation("MySql:CharSet", "utf8mb4")
                .OldAnnotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.UpdateData(
                table: "Modul",
                keyColumn: "MaskineId",
                keyValue: null,
                column: "MaskineId",
                value: "");

            migrationBuilder.AlterColumn<string>(
                name: "MaskineId",
                table: "Modul",
                type: "varchar(255)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "varchar(255)",
                oldNullable: true)
                .Annotation("MySql:CharSet", "utf8mb4")
                .OldAnnotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddForeignKey(
                name: "FK_Modul_Maskine_MaskineId",
                table: "Modul",
                column: "MaskineId",
                principalTable: "Maskine",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Nedetid_Maskine_MaskineId",
                table: "Nedetid",
                column: "MaskineId",
                principalTable: "Maskine",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Modul_Maskine_MaskineId",
                table: "Modul");

            migrationBuilder.DropForeignKey(
                name: "FK_Nedetid_Maskine_MaskineId",
                table: "Nedetid");

            migrationBuilder.AlterColumn<string>(
                name: "MaskineId",
                table: "Nedetid",
                type: "varchar(255)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "varchar(255)")
                .Annotation("MySql:CharSet", "utf8mb4")
                .OldAnnotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AlterColumn<string>(
                name: "MaskineId",
                table: "Modul",
                type: "varchar(255)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "varchar(255)")
                .Annotation("MySql:CharSet", "utf8mb4")
                .OldAnnotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddForeignKey(
                name: "FK_Modul_Maskine_MaskineId",
                table: "Modul",
                column: "MaskineId",
                principalTable: "Maskine",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Nedetid_Maskine_MaskineId",
                table: "Nedetid",
                column: "MaskineId",
                principalTable: "Maskine",
                principalColumn: "Id");
        }
    }
}
