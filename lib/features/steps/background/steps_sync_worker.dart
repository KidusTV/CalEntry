import 'package:workmanager/workmanager.dart';

import '../../../core/di/injection.dart';


const syncStepsTask = 'syncStepsTask';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == syncStepsTask) {
      await WorkerDI.init(); // 👈 wichtig

      await WorkerDI.syncStepsUseCase(DateTime.now());
    }

    return Future.value(true);
  });
}