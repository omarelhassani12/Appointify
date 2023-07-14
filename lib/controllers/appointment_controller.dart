import '../viewmodels/appointment_viewmodel.dart';
import '../models/appointment.dart';

class AppointmentController {
  final AppointmentViewModel _viewModel;

  AppointmentController(this._viewModel);

  List<Appointment> getAppointments() {
    return _viewModel.getAppointments();
  }

  void makeAppointment(Appointment appointment) {
    _viewModel.makeAppointment(appointment);
  }
}
