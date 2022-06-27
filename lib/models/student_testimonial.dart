class StudentTestimonial {
  String event;
  String testimonial;

  StudentTestimonial({
    required this.event,
    required this.testimonial,
  });

  factory StudentTestimonial.fromJson(Map<String, dynamic> json) {
    return StudentTestimonial(
      event: json['event'],
      testimonial: json['testimonial'],
    );
  }
}
