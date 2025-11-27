using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace WebApplication1.Migrations
{
    /// <inheritdoc />
    public partial class controllerupdate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Fravaer_Medarbejder_medarbejderId",
                table: "Fravaer");

            migrationBuilder.DropForeignKey(
                name: "FK_Maskine_Egenskab_egenskabId",
                table: "Maskine");

            migrationBuilder.DropForeignKey(
                name: "FK_MaskineModul_Maskine_maskinerid",
                table: "MaskineModul");

            migrationBuilder.DropForeignKey(
                name: "FK_MaskineModul_Modul_modulerid",
                table: "MaskineModul");

            migrationBuilder.DropForeignKey(
                name: "FK_Medarbejder_Modul_Modulid",
                table: "Medarbejder");

            migrationBuilder.DropForeignKey(
                name: "FK_Modul_Periode_periodeId",
                table: "Modul");

            migrationBuilder.DropForeignKey(
                name: "FK_Nedetid_Maskine_Maskineid",
                table: "Nedetid");

            migrationBuilder.DropForeignKey(
                name: "FK_Rolle_Egenskab_egenskabId",
                table: "Rolle");

            migrationBuilder.DropForeignKey(
                name: "FK_Rolle_Medarbejder_medarbejderId",
                table: "Rolle");

            migrationBuilder.DropColumn(
                name: "aarsag",
                table: "Fravaer");

            migrationBuilder.RenameColumn(
                name: "navn",
                table: "Rolle",
                newName: "Navn");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "Rolle",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "start",
                table: "Periode",
                newName: "Start");

            migrationBuilder.RenameColumn(
                name: "end",
                table: "Periode",
                newName: "End");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "Periode",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "tidspunkt",
                table: "Nedetid",
                newName: "Tidspunkt");

            migrationBuilder.RenameColumn(
                name: "start",
                table: "Nedetid",
                newName: "Start");

            migrationBuilder.RenameColumn(
                name: "gentagende",
                table: "Nedetid",
                newName: "Gentagende");

            migrationBuilder.RenameColumn(
                name: "end",
                table: "Nedetid",
                newName: "End");

            migrationBuilder.RenameColumn(
                name: "dag",
                table: "Nedetid",
                newName: "Dag");

            migrationBuilder.RenameColumn(
                name: "Maskineid",
                table: "Nedetid",
                newName: "MaskineId");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "Nedetid",
                newName: "Id");

            migrationBuilder.RenameIndex(
                name: "IX_Nedetid_Maskineid",
                table: "Nedetid",
                newName: "IX_Nedetid_MaskineId");

            migrationBuilder.RenameColumn(
                name: "start",
                table: "Modul",
                newName: "Start");

            migrationBuilder.RenameColumn(
                name: "periodeId",
                table: "Modul",
                newName: "PeriodeId");

            migrationBuilder.RenameColumn(
                name: "end",
                table: "Modul",
                newName: "End");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "Modul",
                newName: "Id");

            migrationBuilder.RenameIndex(
                name: "IX_Modul_periodeId",
                table: "Modul",
                newName: "IX_Modul_PeriodeId");

            migrationBuilder.RenameColumn(
                name: "tlf",
                table: "Medarbejder",
                newName: "Tlf");

            migrationBuilder.RenameColumn(
                name: "navn",
                table: "Medarbejder",
                newName: "Navn");

            migrationBuilder.RenameColumn(
                name: "Modulid",
                table: "Medarbejder",
                newName: "ModulId");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "Medarbejder",
                newName: "Id");

            migrationBuilder.RenameIndex(
                name: "IX_Medarbejder_Modulid",
                table: "Medarbejder",
                newName: "IX_Medarbejder_ModulId");

            migrationBuilder.RenameColumn(
                name: "modulerid",
                table: "MaskineModul",
                newName: "ModulerId");

            migrationBuilder.RenameColumn(
                name: "maskinerid",
                table: "MaskineModul",
                newName: "MaskinerId");

            migrationBuilder.RenameIndex(
                name: "IX_MaskineModul_modulerid",
                table: "MaskineModul",
                newName: "IX_MaskineModul_ModulerId");

            migrationBuilder.RenameColumn(
                name: "navn",
                table: "Maskine",
                newName: "Navn");

            migrationBuilder.RenameColumn(
                name: "egenskabId",
                table: "Maskine",
                newName: "EgenskabId");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "Maskine",
                newName: "Id");

            migrationBuilder.RenameIndex(
                name: "IX_Maskine_egenskabId",
                table: "Maskine",
                newName: "IX_Maskine_EgenskabId");

            migrationBuilder.RenameColumn(
                name: "start",
                table: "Fravaer",
                newName: "Start");

            migrationBuilder.RenameColumn(
                name: "medarbejderId",
                table: "Fravaer",
                newName: "MedarbejderId");

            migrationBuilder.RenameColumn(
                name: "end",
                table: "Fravaer",
                newName: "End");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "Fravaer",
                newName: "Id");

            migrationBuilder.RenameIndex(
                name: "IX_Fravaer_medarbejderId",
                table: "Fravaer",
                newName: "IX_Fravaer_MedarbejderId");

            migrationBuilder.RenameColumn(
                name: "titel",
                table: "Egenskab",
                newName: "Titel");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "Egenskab",
                newName: "Id");

            migrationBuilder.AlterColumn<string>(
                name: "medarbejderId",
                table: "Rolle",
                type: "varchar(255)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "varchar(255)")
                .Annotation("MySql:CharSet", "utf8mb4")
                .OldAnnotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AlterColumn<string>(
                name: "egenskabId",
                table: "Rolle",
                type: "varchar(255)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "varchar(255)")
                .Annotation("MySql:CharSet", "utf8mb4")
                .OldAnnotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AlterColumn<string>(
                name: "Tlf",
                table: "Medarbejder",
                type: "longtext",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "longtext")
                .Annotation("MySql:CharSet", "utf8mb4")
                .OldAnnotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<string>(
                name: "Email",
                table: "Medarbejder",
                type: "longtext",
                nullable: false)
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<string>(
                name: "Password",
                table: "Medarbejder",
                type: "longtext",
                nullable: false)
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<string>(
                name: "RealPassword",
                table: "Medarbejder",
                type: "longtext",
                nullable: false)
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddForeignKey(
                name: "FK_Fravaer_Medarbejder_MedarbejderId",
                table: "Fravaer",
                column: "MedarbejderId",
                principalTable: "Medarbejder",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Maskine_Egenskab_EgenskabId",
                table: "Maskine",
                column: "EgenskabId",
                principalTable: "Egenskab",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_MaskineModul_Maskine_MaskinerId",
                table: "MaskineModul",
                column: "MaskinerId",
                principalTable: "Maskine",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_MaskineModul_Modul_ModulerId",
                table: "MaskineModul",
                column: "ModulerId",
                principalTable: "Modul",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Medarbejder_Modul_ModulId",
                table: "Medarbejder",
                column: "ModulId",
                principalTable: "Modul",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Modul_Periode_PeriodeId",
                table: "Modul",
                column: "PeriodeId",
                principalTable: "Periode",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Nedetid_Maskine_MaskineId",
                table: "Nedetid",
                column: "MaskineId",
                principalTable: "Maskine",
                principalColumn: "Id");

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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Fravaer_Medarbejder_MedarbejderId",
                table: "Fravaer");

            migrationBuilder.DropForeignKey(
                name: "FK_Maskine_Egenskab_EgenskabId",
                table: "Maskine");

            migrationBuilder.DropForeignKey(
                name: "FK_MaskineModul_Maskine_MaskinerId",
                table: "MaskineModul");

            migrationBuilder.DropForeignKey(
                name: "FK_MaskineModul_Modul_ModulerId",
                table: "MaskineModul");

            migrationBuilder.DropForeignKey(
                name: "FK_Medarbejder_Modul_ModulId",
                table: "Medarbejder");

            migrationBuilder.DropForeignKey(
                name: "FK_Modul_Periode_PeriodeId",
                table: "Modul");

            migrationBuilder.DropForeignKey(
                name: "FK_Nedetid_Maskine_MaskineId",
                table: "Nedetid");

            migrationBuilder.DropForeignKey(
                name: "FK_Rolle_Egenskab_egenskabId",
                table: "Rolle");

            migrationBuilder.DropForeignKey(
                name: "FK_Rolle_Medarbejder_medarbejderId",
                table: "Rolle");

            migrationBuilder.DropColumn(
                name: "Email",
                table: "Medarbejder");

            migrationBuilder.DropColumn(
                name: "Password",
                table: "Medarbejder");

            migrationBuilder.DropColumn(
                name: "RealPassword",
                table: "Medarbejder");

            migrationBuilder.RenameColumn(
                name: "Navn",
                table: "Rolle",
                newName: "navn");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Rolle",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "Start",
                table: "Periode",
                newName: "start");

            migrationBuilder.RenameColumn(
                name: "End",
                table: "Periode",
                newName: "end");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Periode",
                newName: "id");

            migrationBuilder.RenameColumn(
                name: "Tidspunkt",
                table: "Nedetid",
                newName: "tidspunkt");

            migrationBuilder.RenameColumn(
                name: "Start",
                table: "Nedetid",
                newName: "start");

            migrationBuilder.RenameColumn(
                name: "MaskineId",
                table: "Nedetid",
                newName: "Maskineid");

            migrationBuilder.RenameColumn(
                name: "Gentagende",
                table: "Nedetid",
                newName: "gentagende");

            migrationBuilder.RenameColumn(
                name: "End",
                table: "Nedetid",
                newName: "end");

            migrationBuilder.RenameColumn(
                name: "Dag",
                table: "Nedetid",
                newName: "dag");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Nedetid",
                newName: "id");

            migrationBuilder.RenameIndex(
                name: "IX_Nedetid_MaskineId",
                table: "Nedetid",
                newName: "IX_Nedetid_Maskineid");

            migrationBuilder.RenameColumn(
                name: "Start",
                table: "Modul",
                newName: "start");

            migrationBuilder.RenameColumn(
                name: "PeriodeId",
                table: "Modul",
                newName: "periodeId");

            migrationBuilder.RenameColumn(
                name: "End",
                table: "Modul",
                newName: "end");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Modul",
                newName: "id");

            migrationBuilder.RenameIndex(
                name: "IX_Modul_PeriodeId",
                table: "Modul",
                newName: "IX_Modul_periodeId");

            migrationBuilder.RenameColumn(
                name: "Tlf",
                table: "Medarbejder",
                newName: "tlf");

            migrationBuilder.RenameColumn(
                name: "Navn",
                table: "Medarbejder",
                newName: "navn");

            migrationBuilder.RenameColumn(
                name: "ModulId",
                table: "Medarbejder",
                newName: "Modulid");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Medarbejder",
                newName: "id");

            migrationBuilder.RenameIndex(
                name: "IX_Medarbejder_ModulId",
                table: "Medarbejder",
                newName: "IX_Medarbejder_Modulid");

            migrationBuilder.RenameColumn(
                name: "ModulerId",
                table: "MaskineModul",
                newName: "modulerid");

            migrationBuilder.RenameColumn(
                name: "MaskinerId",
                table: "MaskineModul",
                newName: "maskinerid");

            migrationBuilder.RenameIndex(
                name: "IX_MaskineModul_ModulerId",
                table: "MaskineModul",
                newName: "IX_MaskineModul_modulerid");

            migrationBuilder.RenameColumn(
                name: "Navn",
                table: "Maskine",
                newName: "navn");

            migrationBuilder.RenameColumn(
                name: "EgenskabId",
                table: "Maskine",
                newName: "egenskabId");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Maskine",
                newName: "id");

            migrationBuilder.RenameIndex(
                name: "IX_Maskine_EgenskabId",
                table: "Maskine",
                newName: "IX_Maskine_egenskabId");

            migrationBuilder.RenameColumn(
                name: "Start",
                table: "Fravaer",
                newName: "start");

            migrationBuilder.RenameColumn(
                name: "MedarbejderId",
                table: "Fravaer",
                newName: "medarbejderId");

            migrationBuilder.RenameColumn(
                name: "End",
                table: "Fravaer",
                newName: "end");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Fravaer",
                newName: "id");

            migrationBuilder.RenameIndex(
                name: "IX_Fravaer_MedarbejderId",
                table: "Fravaer",
                newName: "IX_Fravaer_medarbejderId");

            migrationBuilder.RenameColumn(
                name: "Titel",
                table: "Egenskab",
                newName: "titel");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Egenskab",
                newName: "id");

            migrationBuilder.UpdateData(
                table: "Rolle",
                keyColumn: "medarbejderId",
                keyValue: null,
                column: "medarbejderId",
                value: "");

            migrationBuilder.AlterColumn<string>(
                name: "medarbejderId",
                table: "Rolle",
                type: "varchar(255)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "varchar(255)",
                oldNullable: true)
                .Annotation("MySql:CharSet", "utf8mb4")
                .OldAnnotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.UpdateData(
                table: "Rolle",
                keyColumn: "egenskabId",
                keyValue: null,
                column: "egenskabId",
                value: "");

            migrationBuilder.AlterColumn<string>(
                name: "egenskabId",
                table: "Rolle",
                type: "varchar(255)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "varchar(255)",
                oldNullable: true)
                .Annotation("MySql:CharSet", "utf8mb4")
                .OldAnnotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.UpdateData(
                table: "Medarbejder",
                keyColumn: "tlf",
                keyValue: null,
                column: "tlf",
                value: "");

            migrationBuilder.AlterColumn<string>(
                name: "tlf",
                table: "Medarbejder",
                type: "longtext",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "longtext",
                oldNullable: true)
                .Annotation("MySql:CharSet", "utf8mb4")
                .OldAnnotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<string>(
                name: "aarsag",
                table: "Fravaer",
                type: "longtext",
                nullable: false)
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddForeignKey(
                name: "FK_Fravaer_Medarbejder_medarbejderId",
                table: "Fravaer",
                column: "medarbejderId",
                principalTable: "Medarbejder",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Maskine_Egenskab_egenskabId",
                table: "Maskine",
                column: "egenskabId",
                principalTable: "Egenskab",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_MaskineModul_Maskine_maskinerid",
                table: "MaskineModul",
                column: "maskinerid",
                principalTable: "Maskine",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_MaskineModul_Modul_modulerid",
                table: "MaskineModul",
                column: "modulerid",
                principalTable: "Modul",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Medarbejder_Modul_Modulid",
                table: "Medarbejder",
                column: "Modulid",
                principalTable: "Modul",
                principalColumn: "id");

            migrationBuilder.AddForeignKey(
                name: "FK_Modul_Periode_periodeId",
                table: "Modul",
                column: "periodeId",
                principalTable: "Periode",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Nedetid_Maskine_Maskineid",
                table: "Nedetid",
                column: "Maskineid",
                principalTable: "Maskine",
                principalColumn: "id");

            migrationBuilder.AddForeignKey(
                name: "FK_Rolle_Egenskab_egenskabId",
                table: "Rolle",
                column: "egenskabId",
                principalTable: "Egenskab",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Rolle_Medarbejder_medarbejderId",
                table: "Rolle",
                column: "medarbejderId",
                principalTable: "Medarbejder",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
