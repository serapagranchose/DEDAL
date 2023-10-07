import 'package:geolocator/geolocator.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class GetUserGeolocation extends AsyncUseCase<NoParam, Position> {
  @override
  FutureOrResult<Position> execute(NoParam? params) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return const Err(ClientException('Location services are disabled.'));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return const Err(ClientException('Location permissions are denied'));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return const Err(
        ClientException('Location permissions are permanently denied, '
            'we cannot request permissions.'),
      );
    }

    return Ok(await Geolocator.getCurrentPosition());
  }
}
