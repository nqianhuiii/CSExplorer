class Courses {
  late String name, description, salary, career;
  late int imageIndex;

  Courses(this.name, this.description, this.salary, thjis);

  Courses.copy(Courses item) : this(item.name, item.description, item.salary,item.career);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'salary': salary,
      'career': career,
    };
  }

  Courses.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    salary = json['salary'];
    career = json['career'];
    imageIndex = json['imageIndex'];
  }
}
