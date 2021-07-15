db.createUser({
  user: "votoelectronico_admin",
  pwd: "$votoelectronico_admin123.a",
  roles: [
    { role: "userAdmin", db: "votoelectronico_db" },
    { role: "readWrite", db: "votoelectronico_db" },
  ],
});
