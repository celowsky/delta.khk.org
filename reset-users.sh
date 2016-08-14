sqlite3 ./khk-ssa/khk-access/db.sqlite "DELETE FROM users;"
sqlite3 ./khk-ssa/khk-access/db.sqlite "INSERT INTO users (user_id, name, hash, privilegeLevel) values (0, \"admin\", \"209330fa102999db664d217c59142a09\", 2);"
sqlite3 ./khk-ssa/khk-access/db.sqlite "INSERT INTO users (user_id, name, hash, privilegeLevel) values (1, \"khk\", \"fdc3caf67bbe29a1931319139f5f799c\", 1);"
