using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace WebApplication1.Migrations
{
    /// <inheritdoc />
    public partial class init : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterDatabase()
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Egenskab",
                columns: table => new
                {
                    id = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    titel = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Egenskab", x => x.id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Periode",
                columns: table => new
                {
                    id = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    start = table.Column<DateTime>(type: "datetime(6)", nullable: false),
                    end = table.Column<DateTime>(type: "datetime(6)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Periode", x => x.id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Maskine",
                columns: table => new
                {
                    id = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    navn = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    egenskabId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Maskine", x => x.id);
                    table.ForeignKey(
                        name: "FK_Maskine_Egenskab_egenskabId",
                        column: x => x.egenskabId,
                        principalTable: "Egenskab",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Modul",
                columns: table => new
                {
                    id = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    start = table.Column<DateTime>(type: "datetime(6)", nullable: false),
                    end = table.Column<DateTime>(type: "datetime(6)", nullable: false),
                    periodeId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Modul", x => x.id);
                    table.ForeignKey(
                        name: "FK_Modul_Periode_periodeId",
                        column: x => x.periodeId,
                        principalTable: "Periode",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Nedetid",
                columns: table => new
                {
                    id = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    dag = table.Column<int>(type: "int", nullable: false),
                    tidspunkt = table.Column<TimeOnly>(type: "time(6)", nullable: false),
                    gentagende = table.Column<bool>(type: "tinyint(1)", nullable: false),
                    start = table.Column<DateTime>(type: "datetime(6)", nullable: false),
                    end = table.Column<DateTime>(type: "datetime(6)", nullable: false),
                    Maskineid = table.Column<string>(type: "varchar(255)", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Nedetid", x => x.id);
                    table.ForeignKey(
                        name: "FK_Nedetid_Maskine_Maskineid",
                        column: x => x.Maskineid,
                        principalTable: "Maskine",
                        principalColumn: "id");
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "MaskineModul",
                columns: table => new
                {
                    maskinerid = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    modulerid = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MaskineModul", x => new { x.maskinerid, x.modulerid });
                    table.ForeignKey(
                        name: "FK_MaskineModul_Maskine_maskinerid",
                        column: x => x.maskinerid,
                        principalTable: "Maskine",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_MaskineModul_Modul_modulerid",
                        column: x => x.modulerid,
                        principalTable: "Modul",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Medarbejder",
                columns: table => new
                {
                    id = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    navn = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    tlf = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Modulid = table.Column<string>(type: "varchar(255)", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Medarbejder", x => x.id);
                    table.ForeignKey(
                        name: "FK_Medarbejder_Modul_Modulid",
                        column: x => x.Modulid,
                        principalTable: "Modul",
                        principalColumn: "id");
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Fravaer",
                columns: table => new
                {
                    id = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    start = table.Column<DateTime>(type: "datetime(6)", nullable: false),
                    end = table.Column<DateTime>(type: "datetime(6)", nullable: false),
                    aarsag = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    medarbejderId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Fravaer", x => x.id);
                    table.ForeignKey(
                        name: "FK_Fravaer_Medarbejder_medarbejderId",
                        column: x => x.medarbejderId,
                        principalTable: "Medarbejder",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Rolle",
                columns: table => new
                {
                    id = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    navn = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    medarbejderId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    egenskabId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Rolle", x => x.id);
                    table.ForeignKey(
                        name: "FK_Rolle_Egenskab_egenskabId",
                        column: x => x.egenskabId,
                        principalTable: "Egenskab",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Rolle_Medarbejder_medarbejderId",
                        column: x => x.medarbejderId,
                        principalTable: "Medarbejder",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_Fravaer_medarbejderId",
                table: "Fravaer",
                column: "medarbejderId");

            migrationBuilder.CreateIndex(
                name: "IX_Maskine_egenskabId",
                table: "Maskine",
                column: "egenskabId");

            migrationBuilder.CreateIndex(
                name: "IX_MaskineModul_modulerid",
                table: "MaskineModul",
                column: "modulerid");

            migrationBuilder.CreateIndex(
                name: "IX_Medarbejder_Modulid",
                table: "Medarbejder",
                column: "Modulid");

            migrationBuilder.CreateIndex(
                name: "IX_Modul_periodeId",
                table: "Modul",
                column: "periodeId");

            migrationBuilder.CreateIndex(
                name: "IX_Nedetid_Maskineid",
                table: "Nedetid",
                column: "Maskineid");

            migrationBuilder.CreateIndex(
                name: "IX_Rolle_egenskabId",
                table: "Rolle",
                column: "egenskabId");

            migrationBuilder.CreateIndex(
                name: "IX_Rolle_medarbejderId",
                table: "Rolle",
                column: "medarbejderId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Fravaer");

            migrationBuilder.DropTable(
                name: "MaskineModul");

            migrationBuilder.DropTable(
                name: "Nedetid");

            migrationBuilder.DropTable(
                name: "Rolle");

            migrationBuilder.DropTable(
                name: "Maskine");

            migrationBuilder.DropTable(
                name: "Medarbejder");

            migrationBuilder.DropTable(
                name: "Egenskab");

            migrationBuilder.DropTable(
                name: "Modul");

            migrationBuilder.DropTable(
                name: "Periode");
        }
    }
}
