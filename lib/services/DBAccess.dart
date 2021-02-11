import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';


class DBAccess
{
 DBAccess._(); //make the class a singleton static object
 static final DBAccess db = DBAccess._();
 static Database _database;

 Future<Database> get database async
 {
   if(_database != null)
     return _database;

   _database = await initDB();
   return _database;
 }

 Future<void> update(String curr_location, Map<String, dynamic> data) async
 {
   final db = await database;
   await db.update("info", data , where: "location = ?", whereArgs: [curr_location]);
 }

 Future<List<Map<String, dynamic>>> getAllRows() async
 {
  final db = await database;
  return await db.query("info");
 }

 initDB() async
 {
   return await openDatabase(
     path.join(await getDatabasesPath(), 'worldtime.db'),
     onCreate: (db, version) async
       {
         await db.execute("CREATE TABLE info(location TEXT)");
         await db.execute("INSERT INTO info('location') values('Berlin')");
       },
     version: 1,
   );
 }

}