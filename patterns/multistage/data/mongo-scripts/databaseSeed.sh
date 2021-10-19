#!/usr/bin/env bash
echo "Seeding votoelectronico database..."
mongo votoelectronico_db --authenticationDatabase admin --host localhost -u admin -p \$admin123.a --eval "db.grupoPoliticos.insert([{'nombre': 'P1', 'descripcion': 'Partido Politico Alianza'}, {'nombre': 'P2', 'descripcion': 'Partido Politico Peru Posible'}]);"
echo "votoelectronico database seed."