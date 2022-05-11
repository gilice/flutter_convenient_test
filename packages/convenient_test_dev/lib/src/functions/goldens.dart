import 'package:convenient_test_dev/src/support/compile_time_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

class MyLocalFileComparator extends LocalFileComparator {
  final Uri goldenBasedirForFailure;

  MyLocalFileComparator({required this.goldenBasedirForFailure})
      : super(Uri.file(path.join(CompileTimeConfig.kAppCodeDir, 'integration_test/dummy.dart'))) {
    assert(basedir == Uri.directory(path.join(CompileTimeConfig.kAppCodeDir, 'integration_test')));
  }

  @override
  Future<String> generateFailureOutput(
    ComparisonResult result,
    Uri golden,
    Uri basedir, {
    String key = '',
  }) async {
    return await super.generateFailureOutput(
      result,
      golden,
      // NOTE hacked
      goldenBasedirForFailure,
      key: key,
    );
  }
}
