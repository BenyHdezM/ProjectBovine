import 'package:drift/drift.dart';
import 'package:drift/web/worker.dart';
import 'package:drift/wasm.dart';
import 'package:sqlite3/wasm.dart';

void main() {
  driftWorkerMain(() => LazyDatabase(() async {
        final sqlite3 = await WasmSqlite3.loadFromUrl(
          Uri.parse('sqlite3.wasm'),
        );
        return WasmDatabase(sqlite3: sqlite3, path: '/vacuno_db');
      }));
}
