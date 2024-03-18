class Api{

  static const baseUrl = "http://192.168.1.69:8000/api";

  static const loginUrl = "$baseUrl/auth/customer-login";
  static const signupUrl = "$baseUrl/auth/customer-signUp";
  static const forgotPasswordUrl = "$baseUrl/auth/forget-password";
  static const resetPasswordUrl = "$baseUrl/auth/reset-password";
  
  
  static const updateProfileUrl = "$baseUrl/auth/customer/update-profile";
  static const changePasswordUrl = "$baseUrl/auth/customer/change-password";

  static const cinemaHallUrl = "$baseUrl/cinema-halls";
  static const showingMoviesUrl = "$baseUrl/movie-showing";
  static const getMovieDetails= "$baseUrl/movie";
  static const getShowDetails= "$baseUrl/show-details";
  static const booking= "$baseUrl/booking";
  static const getBooking= "$baseUrl/booking-list";
  static const getBookingDetails= "$baseUrl/booking-details";
  static const cancelBooking= "$baseUrl/cancel-booking";
  static const verifyPayment= "$baseUrl/verify-payment";

}