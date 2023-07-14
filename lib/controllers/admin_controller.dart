import '../viewmodels/admin_viewmodel.dart';
import '../models/appointment.dart';

class AdminController {
  final AdminViewModel _viewModel;

  AdminController(this._viewModel);

  List<Appointment> getAppointments() {
    return _viewModel.getAppointments();
  }

  void deleteAppointment(int appointmentId) {
    _viewModel.deleteAppointment(appointmentId);
  }
}
