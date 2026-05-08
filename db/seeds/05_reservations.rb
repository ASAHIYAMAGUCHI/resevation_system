puts "-- reservations"

weekday = Price.find_by!(price_name: "平日料金")
holiday = Price.find_by!(price_name: "土日祝日料金")

[
  {
    res_code: "RS0000001", daily_slot_date: Date.new(2026, 5, 1),
    personal_name: "田中 一郎", email: "tanaka@example.com",
    status: "confirmed",
    details: [
      { person_type: "adult", number_of_people: 2, price: weekday.adult_price },
      { person_type: "child", number_of_people: 1, price: weekday.child_price }
    ]
  },
  {
    res_code: "RS0000002", daily_slot_date: Date.new(2026, 5, 2),
    personal_name: "佐藤 二郎", email: "sato@example.com",
    status: "confirmed",
    details: [
      { person_type: "adult",   number_of_people: 2, price: holiday.adult_price },
      { person_type: "student", number_of_people: 1, price: holiday.student_price },
      { person_type: "infant",  number_of_people: 1, price: holiday.infant_price }
    ]
  },
  {
    res_code: "RS0000003", daily_slot_date: Date.new(2026, 5, 3),
    personal_name: "高橋 三郎", email: "takahashi@example.com",
    status: "pending",
    details: [
      { person_type: "adult", number_of_people: 4, price: holiday.adult_price }
    ]
  },
  {
    res_code: "RS0000004", daily_slot_date: Date.new(2026, 5, 3),
    personal_name: "伊藤 四郎", email: "ito@example.com",
    status: "cancelled",
    details: [
      { person_type: "adult", number_of_people: 1, price: holiday.adult_price },
      { person_type: "child", number_of_people: 2, price: holiday.child_price }
    ]
  },
  {
    res_code: "RS0000005", daily_slot_date: Date.new(2026, 5, 4),
    personal_name: "渡辺 五郎", email: "watanabe@example.com",
    status: "visited",
    details: [
      { person_type: "adult",   number_of_people: 3, price: holiday.adult_price },
      { person_type: "student", number_of_people: 2, price: holiday.student_price },
      { person_type: "infant",  number_of_people: 1, price: holiday.infant_price }
    ]
  },
  {
    res_code: "RS0000006", daily_slot_date: Date.new(2026, 5, 7),
    personal_name: "中村 六郎", email: "nakamura@example.com",
    status: "pending",
    details: [
      { person_type: "adult",   number_of_people: 2, price: weekday.adult_price },
      { person_type: "student", number_of_people: 1, price: weekday.student_price }
    ]
  },
  {
    res_code: "RS0000007", daily_slot_date: Date.new(2026, 5, 9),
    personal_name: "小林 七郎", email: "kobayashi@example.com",
    status: "confirmed",
    details: [
      { person_type: "adult",  number_of_people: 5, price: holiday.adult_price },
      { person_type: "child",  number_of_people: 3, price: holiday.child_price },
      { person_type: "infant", number_of_people: 2, price: holiday.infant_price }
    ]
  }
].each do |data|
  total = data[:details].sum { |d| d[:number_of_people] * d[:price] }

  Reservation.find_or_create_by!(res_code: data[:res_code]) do |r|
    r.daily_slot_date = data[:daily_slot_date]
    r.personal_name   = data[:personal_name]
    r.email           = data[:email]
    r.status          = data[:status]
    r.total_price     = total
  end
end

puts "   #{Reservation.count} reservations created"
