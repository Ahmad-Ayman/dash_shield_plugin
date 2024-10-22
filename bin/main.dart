import 'package:dash_shield/src/features/print_removal/print_modification_service.dart';

void main(List<String> args) async {
  if (args.isEmpty || args.length > 1) {
    print(
        'Usage: flutter pub run dash_shield:main <subcommand> <project_directory>');
    print('Example:');
    print(
        '  flutter pub run dash_shield:main -remove /path/to/project   # To remove all print statements');
    print(
        '  flutter pub run dash_shield:main -replace /path/to/project  # To wrap print statements with kDebugMode');
    return;
  }
  final subcommand = args[
      0]; // First argument specifies the subcommand (e.g., -remove or -replace)

  switch (subcommand) {
    case '--remove':
      print('Removing all print statements from the project...');
      await PrintModificationService.removePrints();
      break;

    case '--replace':
      print('Wrapping all print statements with kDebugMode...');
      await PrintModificationService.wrapPrintsWithDebugModeChecker();
      break;

    default:
      print('Unknown subcommand: $subcommand');
      print('Available subcommands: -remove, -replace');
  }
}
