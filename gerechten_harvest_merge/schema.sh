#!/bin/bash
# regenereer schema.sql vanuit de levende databank.
# wordt opgeroepen vanuit harvest.py optie 2, of standalone draaibaar.
#
# 1. mysqldump van recipe_search (lees-actie, raakt de databank niet)
# 2. python harvest.py --herorden zet alles in schoolvolgorde

MYSQLDUMP="/c/xampp/mysql/bin/mysqldump.exe"
DB="recipe_search"

"$MYSQLDUMP" -u root --databases "$DB" \
    --routines \
    --add-drop-database \
    --default-character-set=utf8mb4 > schema.sql

python harvest.py --herorden
